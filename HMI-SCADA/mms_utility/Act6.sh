#!/bin/bash
# Action 6, request invalid or non-existent files from different IEDs

for n in {1..10};
do
    #show file list in IED_XFMR1
    ./mms_utility -h 32.32.32.23 -f
    sleep 3

    #show file list in IED_XFMR2
    ./mms_utility -h 32.32.32.32 -f
    sleep 3

    #show file list in IED_FDR
    ./mms_utility -h 32.32.32.11 -f
    sleep 3
done

