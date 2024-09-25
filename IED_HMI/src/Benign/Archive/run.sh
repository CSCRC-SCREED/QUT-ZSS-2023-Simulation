#!/bin/bash

#Compile simlink.cpp
g++ simlink.cpp -o simlink -pthread

#Collect pcap from interface enp0s8 and dump to file "IED_FDR.pcapng"
gnome-terminal --hide-menubar -t CollectPCAP --geometry=36x4+46+210 -- tshark -i enp0s8 -w /media/sf_sharing/Simulation\ testbed\ for\ Stage\ 3/Datasets/IED_FDR.pcapng -f "not udp" -F pcap

#Run simlink -- the interface among libiec61850, OpenPLC and MATLAB/Simulink
gnome-terminal --hide-menubar -t INTFtoSimulink --geometry=36x8+46+430 -- ./simlink

#Running program SV_SUB
gnome-terminal --hide-menubar -t SV_SUB --geometry=36x8+46+4 -- ./sv_subscriber

#Running program SUBtoTRSF1
gnome-terminal --hide-menubar -t SUB_TRSF1 --geometry=36x8+46+610 -- ./goose_subscriber_to_TRSF1

#Running program SUBtoTRSF2
gnome-terminal --hide-menubar -t SUB_TRSF2 --geometry=36x8+46+790 -- ./goose_subscriber_to_TRSF2

#Running program Publisher_PIOC_FDR
gnome-terminal --hide-menubar -t PUB_FDR --geometry=36x4+46+320 -- ./goose_publisher_PIOC_FDR
