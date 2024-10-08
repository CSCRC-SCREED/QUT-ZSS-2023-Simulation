/*
 * goose_subscriber_FDR
 *
 * This is an example for a standalone GOOSE subscriber
 *
 * Has to be started as root in Linux.
 */

#include "goose_receiver.h"
#include "goose_subscriber.h"
#include "hal_thread.h"

#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <string.h>

static int running = 1;

FILE *fp;

void sigint_handler(int signalId)
{
    running = 0;
}

//################################# unix timestamp to time string [begin] ###########################//

#define UTC_BASE_YEAR   1970
#define MONTH_PER_YEAR  12
#define DAY_PER_YEAR    365
#define SEC_PER_DAY     86400
#define SEC_PER_HOUR    3600
#define SEC_PER_MIN     60

/* Num of days in each month */
const unsigned char g_day_per_mon[MONTH_PER_YEAR] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

/* is leap_year or not */
static unsigned char applib_dt_is_leap_year(unsigned short year)
{

    if ((year % 400) == 0) {
        return 1;
    } else if ((year % 100) == 0) {
        return 0;
    } else if ((year % 4) == 0) {
        return 1;
    } else {
        return 0;
    }
}

/*How many days in that month*/
static unsigned char applib_dt_last_day_of_mon(unsigned char month, unsigned short year)
{
    if ((month == 0) || (month > 12)) {
        return g_day_per_mon[1] + applib_dt_is_leap_year(year);
    }

    if (month != 2) {
        return g_day_per_mon[month - 1];
    } else {
        return g_day_per_mon[1] + applib_dt_is_leap_year(year);
    }
}


static void change(uint64_t ts)
{
    int year = 0;
    int month = 0;
    int day = 0;
    int hour = 0;
    int minute = 0;
    int second = 0;

    int days = ts / SEC_PER_DAY;
    //Transfer in years
    int yearTmp = 0;
    int dayTmp = 0;
    //how many years
    for (yearTmp = UTC_BASE_YEAR; days > 0; yearTmp++) {
        dayTmp = (DAY_PER_YEAR + applib_dt_is_leap_year(yearTmp)); //how many days in this year
        if (days >= dayTmp)
        {
           days -= dayTmp;
        }
        else
        {
           break;
        }
    }
    year = yearTmp;

    //Transfer in months 
    int monthTmp = 0;
    for (monthTmp = 1; monthTmp < MONTH_PER_YEAR; monthTmp++) {
       dayTmp = applib_dt_last_day_of_mon(monthTmp, year);
       if (days >= dayTmp) {
           days -= dayTmp;
       }
       else
       {
           break;
       }
    }
    month = monthTmp;

    day = days + 1;

    //Transfer To total seconds
    int secs = ts % SEC_PER_DAY;
    //Transfer In Hours
    hour = (secs / SEC_PER_HOUR);
    //Transfer In Minutes
    secs %= SEC_PER_HOUR;
    minute = secs / SEC_PER_MIN;
    //Transfer In Seconds
    second = secs % SEC_PER_MIN;
    	
    printf("timestamp: %d-%d-%d %d:%d:%d", year, month, day, hour, minute, second);
}

//############################# unix timestamp to time string [ end ] ##########################//


void
gooseListener(GooseSubscriber subscriber, void* parameter)
{
    printf("PIOC_FDR\n");
    printf("  stNum: %u sqNum: %u\n", GooseSubscriber_getStNum(subscriber),
            GooseSubscriber_getSqNum(subscriber));
    printf("  timeToLive: %u\n", GooseSubscriber_getTimeAllowedToLive(subscriber));

    uint64_t timestamp = GooseSubscriber_getTimestamp(subscriber);

    //Add 10 hours time differences to UTC timestamp 
    timestamp = timestamp + 36000000;
    
    //printf("  timestamp: %u.%u\n", (uint32_t) (timestamp / 1000), (uint32_t) (timestamp % 1000));
    change(timestamp / 1000); // display year-month-day-hour-min-sec
    printf(".%u\n", (uint32_t) (timestamp % 1000)); //display milliseconds

    MmsValue* values = GooseSubscriber_getDataSetValues(subscriber);

    char buffer[1024];

    MmsValue_printToBuffer(values, buffer, 1024);

    printf("%s\n\n", buffer);
    
    int i=0;
    int CBstval[7] = {0,0,0,0,0,0,0};
       
    for (int j=0; buffer[j] != '\0'; j++) {
        //Debug
        //printf("%c", buffer[j]);
        if ( (buffer[j] == ',') && (buffer[j-2] == 's') && (i<7) ){
            CBstval[i] = 0;
            //Debug
            //printf("%d,%d,%d\n", i, j, CBstval[i]);
            i++;
        }
        if ( (buffer[j] == ',') && (buffer[j-2] == 'u') && (i<7) ){
            CBstval[i] = 1;
            //Debug
            //printf("%d,%d,%d\n", i, j, CBstval[i]);
            i++;        
		}
    }

//############### store CBstval to local for control signal ##########################//  
    //Open File//
    fp=fopen("/home/ray/Desktop/Primary Plant/TripRecord/TripFromFDR.csv","w");
    if(fp==NULL) {
        printf("File cannot open! " );
        exit(0);
     	}
    //write values to file//
    for (i=0; i<7; i++)
	fprintf(fp,"%d,", CBstval[i]);   
    //Close file//
    fclose(fp);
//##############################################################################//
}


int
main(int argc, char** argv)
{
    GooseReceiver receiver = GooseReceiver_create();

     if (argc > 1) {
         printf("Set interface id: %s\n", argv[1]);
         GooseReceiver_setInterfaceId(receiver, argv[1]);
     }
     else {
         printf("Using interface enp0s8\n");
         GooseReceiver_setInterfaceId(receiver, "enp0s8");
     }
    		
    GooseSubscriber subscriber = GooseSubscriber_create("QUTZS_FDRPIOC/LLN0$GO$gcb_1", NULL);

    GooseSubscriber_setAppId(subscriber, 0x3103);

    GooseSubscriber_setListener(subscriber, gooseListener, NULL);

    GooseReceiver_addSubscriber(receiver, subscriber);

    GooseReceiver_start(receiver);

    if (GooseReceiver_isRunning(receiver)) {
        signal(SIGINT, sigint_handler);
        
        while (running) {
            Thread_sleep(50);
        }
    }
    else {
        printf("Failed to start GOOSE subscriber. Reason can be that the Ethernet interface doesn't exist or root permission are required.\n");
    }

    GooseReceiver_stop(receiver);

    GooseReceiver_destroy(receiver);
}
