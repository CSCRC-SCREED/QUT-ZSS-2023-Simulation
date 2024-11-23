#!/bin/bash
# Action 4, Control IEDs in different modes, including direct control, status check, and direct control with enhanced security

for n in {1..10};
do
    #sControl IED_XFMR1
    ./client_example_control 32.32.32.23
    sleep 5

    #Control IED_XFMR2
    ./client_example_control 32.32.32.32
    sleep 5

    #Control IED_FDR
    ./client_example_control 32.32.32.11
    sleep 5
done

