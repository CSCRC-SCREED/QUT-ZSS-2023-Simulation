#!/bin/bash
# Action 2, show the server identity of different IEDs

for n in {1..10};
do
    #show the server identity of IED_XFMR1
    ./mms_utility -h 32.32.32.23 -i
    sleep 3

    #show the server identity of IED_XFMR2
    ./mms_utility -h 32.32.32.32 -i
    sleep 3

    #show the server identity of IED_FDR
    ./mms_utility -h 32.32.32.11 -i
    sleep 3
done

