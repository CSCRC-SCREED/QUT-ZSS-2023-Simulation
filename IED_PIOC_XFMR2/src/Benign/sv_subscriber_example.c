/*
 * SV subscriber for receiving 7 physical values which are only applicable for IED_XFMR2
 */

#include "hal_thread.h"
#include <signal.h>
#include <stdio.h>
#include "sv_subscriber.h"


static bool running = true;
const char* subasdu[7] = {"66kV2", "66kV3", "XFMR2W1", "XFMR2W2", "CB_XFMR2", "F_66kV2", "F_XFMR2"};

void sigint_handler(int signalId)
{
    running = 0;
}


/* Callback handler for received SV messages */
static void
svUpdateListener (SVSubscriber subscriber, void* parameter, SVSubscriber_ASDU asdu)
{
    FILE *fp;
    int i;
    int current;

    const char* svID = SVSubscriber_ASDU_getSvId(asdu);
    
    
    for (int i = 0; i<7; i++) {
    
	    if (strcmp(svID, subasdu[i]) == 0)
	    { 
	    	//printf("svUpdateListener called\n");
	    	printf("  svID= %s\n", svID);

	    	printf("  smpCnt: %i\n", SVSubscriber_ASDU_getSmpCnt(asdu));
	    	//printf("  confRev: %u\n", SVSubscriber_ASDU_getConfRev(asdu));
	    	//printf("  smpRate: %u\n", SVSubscriber_ASDU_getSmpRate(asdu));
	    	//printf("  smpMod: %u\n", SVSubscriber_ASDU_getSmpMod(asdu));
	    

	   	 /*
	    	 * Access to the data requires a priori knowledge of the data set.
	    	 * For this example we assume a data set consisting of FLOAT32 values.
	   	  * A FLOAT32 value is encoded as 4 bytes. You can find the first FLOAT32
	   	  * value at byte position 0, the second value at byte position 4, the third
	   	  * value at byte position 8, and so on.
	   	  *
	   	  * To prevent damages due configuration, please check the length of the
	   	  * data block of the SV message before accessing the data.
	   	  */
	   	  
	   	 if (SVSubscriber_ASDU_getDataSize(asdu) >= 4) {
			current = SVSubscriber_ASDU_getINT32(asdu, 0);
			//data2 = SVSubscriber_ASDU_getINT32(asdu, 4);
			//data3 = SVSubscriber_ASDU_getINT32(asdu, 8);  	 
	       	printf("   current: %d\n", current);
	  	 }
	  	 
	  	 if (i == 0) {
	  	 	//open File with "w"//
    			fp=fopen("/home/ray/Desktop/XFMR2 OverCur Prot/TripRecord/CurrentValues.csv","w"); 
    			      	
	       	//Write values to file//
		 	fprintf(fp,"%d,", current);
		 	//Debug//
		 	//printf("%d\t",current);
		 	
		 	//Close file//
    			fclose(fp);
    		}
    		else {
    			//open File with "a"//
    			fp=fopen("/home/ray/Desktop/XFMR2 OverCur Prot/TripRecord/CurrentValues.csv","a"); 
    			      	
	       	//Write values to file//
		 	fprintf(fp,"%d,", current);
		 	//Debug//
		 	//printf("%d\t",current);
		 	
		 	//Close file//
    			fclose(fp);
    		}
		  
	    }
    }
}


int
main(int argc, char** argv)
{
    SVReceiver receiver = SVReceiver_create();

    if (argc > 1) {
        SVReceiver_setInterfaceId(receiver, argv[1]);
		printf("Set interface id: %s\n", argv[1]);
    }
    else {
        printf("Using interface enp0s8\n");
        SVReceiver_setInterfaceId(receiver, "enp0s8");
    }

    /* Create a subscriber listening to SV messages with APPID 0x4001 */
    SVSubscriber subscriber = SVSubscriber_create(NULL, 0x4001);

    /* Install a callback handler for the subscriber */
    SVSubscriber_setListener(subscriber, svUpdateListener, NULL);

    /* Connect the subscriber to the receiver */
    SVReceiver_addSubscriber(receiver, subscriber);

    /* Start listening to SV messages - starts a new receiver background thread */
    SVReceiver_start(receiver);

    if (SVReceiver_isRunning(receiver)) {
        signal(SIGINT, sigint_handler);

        while (running)
            Thread_sleep(50);

        /* Stop listening to SV messages */
        SVReceiver_stop(receiver);
    }
    else {
        printf("Failed to start SV subscriber. Reason can be that the Ethernet interface doesn't exist or root permission are required.\n");
    }

    /* Cleanup and free resources */
    SVReceiver_destroy(receiver);
}
