#!/bin/bash

#Compile simlink.cpp
g++ simlink.cpp -o simlink -pthread

#Collect pcap from interface enp0s8 and dump to file "IED_XSFM1.pcapng"
gnome-terminal --hide-menubar -t CollectPCAP --geometry=36x4+46+210 -- tshark -i enp0s8 -w /media/sf_sharing/Simulation\ testbed\ for\ Stage\ 3/Datasets/IED_XSFM1.pcapng -f "not udp" -F pcap

#Run simlink -- the interface among libiec61850, OpenPLC and MATLAB/Simulink
gnome-terminal --hide-menubar -t INTFtoSimulink --geometry=36x8+46+430 -- ./simlink

#Running program SV_SUB
gnome-terminal --hide-menubar -t SV_SUB --geometry=36x8+46+4 -- ./sv_subscriber

#Running program SUBtoXSFM2
gnome-terminal --hide-menubar -t SUB_XSFM2 --geometry=36x8+46+610 -- ./goose_subscriber_to_XSFM2

#Running program SUBtoFDR
gnome-terminal --hide-menubar -t SUB_FDR --geometry=36x8+46+790 -- ./goose_subscriber_to_FDR

echo "Enter your scenario ID"
read n
case $n in

0)
#Running benign program Publisher_PIOC_XSFM1
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1 ;;

901)
#Running malicious program goose_publisher_PIOC_XSFM1_901 -- inject another mal_Pub_XSFM1 (open CB1_66KV, CB_XSFM1 message) every 1 minute
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_901
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1 ;;

902)
#Running malicious program goose_publisher_PIOC_XSFM1_902 --  modify Pub_XSFM1 to (open CB1_66KV, CB_XSFM1 message) every 1 minute
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_902 ;;

903)
#Running malicious program goose_publisher_PIOC_XSFM1_903 -- inject another mal_Pub_XSFM1 (open CB1_66KV and CB_XSFM1, close CB2_22KV message) every 1 minute
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_903
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1 ;;

904)
#Running malicious program goose_publisher_PIOC_XSFM1_904 --  modify Pub_XSFM1 to (open CB1_66KV and CB_XSFM1, close CB2_22KV message) every 1 minute
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_904 ;;

905)
#Running malicious program goose_publisher_PIOC_XSFM1_905 -- inject Pub_XSFM2 (open CB2_66KV, CB3_66KV, CB_XSFM2 message) when a short-circuit happens around XSFM1 
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_905 ;;

906)
#Running malicious program goose_publisher_PIOC_XSFM1_906 -- modify Pub_XSFM1 payloads to (open CB1_66KV, CB2_66KV, CB_XSFM1 message) when a short-circuit happens around XSFM2
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_906 ;;

907)
#Running malicious program goose_publisher_PIOC_XSFM1_907 -- inject Pub_XSFM1 (0101) when a short-circuit happens around XSFM1 -- publish both (0101) and (1110) simultaneously
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_907 ;;

908)
#Running malicious program goose_publisher_PIOC_XSFM1_908 -- modify Pub_XSFM1 payloads to (0101) even when a short-circuit happens around XSFM1 -- Always close CB
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_908 ;;

909)
#Running malicious program goose_publisher_PIOC_XSFM1_909 -- delay (open CB1_66KV, CB2_66KV, CB_XSFM1 message, close CB2_22KV) after 10 seconds
gnome-terminal --hide-menubar -t PUB_XSFM1 --geometry=36x4+46+320 -- ./goose_publisher_PIOC_XSFM1_909 ;;


*)
echo "Sorry, wrong scenario ID" ;;
esac




