#!/bin/bash

#Compile simlink.cpp
g++ simlink.cpp -o simlink -pthread

#Run simlink -- the interface between libiec61850 and MATLAB/Simulink
gnome-terminal --hide-menubar -t INTFtoSimulink --geometry=23x29+1700+500 -- ./simlink

#Running program SV1_Publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher

#Running program SV2_Publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher

#Running program Subscriber from IED_PIOC_XFMR1
gnome-terminal --hide-menubar -t SUB_XFMR1 --geometry=36x11+46+4 -- ./snr/goose_subscriber_PIOC_XFMR1

#Running program Subscriber from IED_PIOC_XFMR2
gnome-terminal --hide-menubar -t SUB_XFMR2 --geometry=36x11+46+264 -- ./snr/goose_subscriber_PIOC_XFMR2

#Running program Subscriber from IED_PIOC_FDR
gnome-terminal --hide-menubar -t SUB_FDR --geometry=36x11+46+500 -- ./snr/goose_subscriber_PIOC_FDR

#Running program Subscriber from IED_BFP
#gnome-terminal --hide-menubar -t SUB_BFP --geometry=36x11+46+770 -- ./snr/goose_subscriber_BFP_FDR
