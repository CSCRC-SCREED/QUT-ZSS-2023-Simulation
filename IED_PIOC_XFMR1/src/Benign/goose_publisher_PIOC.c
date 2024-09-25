/*
 * goose_publisher_PIOC
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

// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
    int HBnew = 1000; // the new HB when st changes
    int CBstval[4] = {0,1,0,1}; //current CBstval
    int PreCBstval[4] = {0,1,0,1}; //previous CBstval
    int idx_cycle50ms = 1;
    
    if (argc > 1)
       interface = argv[1];
    else
       interface = "enp0s8";

    printf("Using interface %s\n", interface);
	
	CommParameters gooseCommParameters;

	gooseCommParameters.appId = 0x3101;
	gooseCommParameters.dstAddress[0] = 0x01;
	gooseCommParameters.dstAddress[1] = 0x0c;
	gooseCommParameters.dstAddress[2] = 0xcd;
	gooseCommParameters.dstAddress[3] = 0x01;
	gooseCommParameters.dstAddress[4] = 0x0c;
	gooseCommParameters.dstAddress[5] = 0x01;
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
	    GoosePublisher_setGoCbRef(publisher, "QUTZS_XFMR1PIOC/LLN0$GO$gcb_1");
	    GoosePublisher_setTimeAllowedToLive(publisher, 1100);    
	    GoosePublisher_setDataSetRef(publisher, "QUTZS_XFMR1PIOC/LLN0$DS_XFMR");
	    GoosePublisher_setGoID(publisher , "gcb_1");
	    GoosePublisher_setConfRev(publisher, 200);

	    while (1) {	    	
	    	LinkedList dataSetValues = LinkedList_create(); 	
	    	FILE *fp;
	    	int i;
	    	
	    	//Open File//
	    	fp=fopen("/home/ray/Desktop/XFMR1 OverCur Prot/TripRecord/TripFromPLC.csv","r");
	    	if(fp==NULL) {
		    	printf("File cannot open! " );
		    	exit(0);
	     	}
	    	//Read values from file//
			for (i=0; i<4; i++) {
		    	fscanf(fp,"%d,", &CBstval[i]);
				//Debug//
		    	//printf("%d\t",CBstval[i]);
			}    
	    	//Close file//
	    	fclose(fp);
	    	
			for (i = 0; i <4; i++ ) {
				LinkedList_add(dataSetValues, MmsValue_newBoolean(CBstval[i]));
				//MmsValue_setBitStringFromIntegerBigEndian(quality,9);  
				// Modifying quality. IntegerBigEndian(quality, 9) means quality = 0000 0000 0000 0 + 0100 1 (integer 9) = 0000 0000 0100 1000 = 0x48
				LinkedList_add(dataSetValues, quality); 
			}

			//Debug//
			/*
			printf("\nCBstval:\n");
			for (i = 0; i <4; i++ )
				printf("%d\t",CBstval[i]);
				
			printf("\nPreCBstval:\n");
			for (i = 0; i <4; i++ )
				printf("%d\t",PreCBstval[i]);
			*/    
	    
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