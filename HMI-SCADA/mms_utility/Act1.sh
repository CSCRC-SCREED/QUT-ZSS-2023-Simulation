#!/bin/bash
# Action 1, show a list of MMS domains on different IEDs

for n in {1..10};
do
    #show a list of MMS domains on IED_XFMR1
    ./mms_utility -h 32.32.32.23 -d
    sleep 3

    #show a list of MMS domains on IED_XFMR2
    ./mms_utility -h 32.32.32.32 -d
    sleep 3

    #show a list of MMS domains on IED_FDR
    ./mms_utility -h 32.32.32.11 -d
    sleep 3
done

