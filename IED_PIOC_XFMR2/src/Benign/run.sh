#!/bin/bash

#Compile simlink.cpp
g++ simlink.cpp -o simlink -pthread

#Collect pcap from interface enp0s8 and dump to file "QUTZS.pcapng"
#gnome-terminal --hide-menubar -t CollectPCAP --geometry=36x4+46+210 -- tshark -i enp0s8 -w /media/sf_sharing/Testbed\ final/Datasets/QUTZS.pcapng -f "not udp" -F pcap

#Run simlink -- the interface among libiec61850, OpenPLC and MATLAB/Simulink
gnome-terminal --hide-menubar -t INTFtoSimulink --geometry=36x8+46+430 -- ./simlink

#Running program SV_SUB
gnome-terminal --hide-menubar -t SV_SUB --geometry=36x8+46+4 -- ./snr/sv_subscriber

#Running benign program Publisher_PIOC
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC

