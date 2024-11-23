#!/bin/bash
# Action 3, show the domain directory in different IEDs

for n in {1..10};
do
    #show the domain directory in IED_XFMR1
    ./mms_utility -h 32.32.32.23 -t simpleIOGenericIO
    sleep 3

    #show the domain directory in IED_XFMR2
    ./mms_utility -h 32.32.32.32 -t simpleIOGenericIO
    sleep 3

    #show the domain directory in IED_FDR
    ./mms_utility -h 32.32.32.11 -t simpleIOGenericIO
    sleep 3
done

