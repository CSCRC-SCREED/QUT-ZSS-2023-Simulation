#!/bin/bash

#Compile simlink.cpp
g++ simlink.cpp -o simlink -pthread

#Collect pcap from interface enp0s8 and dump to file "QUTZS.pcapng"
#gnome-terminal --hide-menubar -t CollectPCAP --geometry=36x4+46+210 -- tshark -i enp0s8 -w /media/sf_sharing/Testbed\ final/Datasets/QUTZS.pcapng -f "not udp" -F pcap

#Run simlink -- the interface among libiec61850, OpenPLC and MATLAB/Simulink
gnome-terminal --hide-menubar -t INTFtoSimulink --geometry=36x8+46+430 -- ./simlink

#Running program SV_SUB
gnome-terminal --hide-menubar -t SV_SUB --geometry=36x8+46+4 -- ./snr/sv_subscriber

echo "Enter your scenario ID"
read n
case $n in

# Benign behaviours
0)
#Running benign program Publisher_PIOC
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;


# Injection attacks to open CBs in fault-free operation to disrupt power supply
8111)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB3_66KV and CB_XFMR2) (500ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8111
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8112)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB3_66KV and CB_XFMR2) (250ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8112
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8113)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 15 GOOSE (open CB3_66KV and CB_XFMR2) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8113
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8114)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 10 GOOSE (open CB3_66KV and CB_XFMR2) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8114
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;


# Modification attacks to open CBs in fault-free operation to disrupt power supply
8211)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB3_66KV and CB_XFMR2) every 1 minute (st and HB unchange)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8211 ;;

8212)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB3_66KV and CB_XFMR2) every 1 minute (st+1 and 1,4,16,64,256,1000ms HB)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8212 ;;


# Injection attacks to close CBs in emergency operation to interfere protection measures
8311)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages (close CB3_66KV and CB_XFMR2) (500ms HB), when a short-circuit happens around XFMR2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8311
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8312)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages (close CB3_66KV and CB_XFMR2) (500ms HB), when a short-circuit happens around XFMR2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8312
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8313)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages (close CB3_66KV and CB_XFMR2) (1,4,16,64,256,1000ms HB), when a short-circuit happens around XFMR2
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8313
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8314)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages (close CB3_66KV and CB_XFMR2) (1,4,16,64,256,1000ms HB), when a short-circuit happens around XFMR2
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8314
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;


# Modification attacks to close CBs in emergency operation to stop protection measures
8411)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of GOOSE messages (close CB3_66KV and CB_XFMR2), when a short-circuit happens around XFMR2
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8411 ;;

8412)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of the first 30 GOOSE messages (close CB3_66KV and CB_XFMR2), when a short-circuit happens around XFMR2
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8412 ;;


# Injection attacks to open XFMR1 CBs in emergency operation to trigger unnecessary protection measures
8511)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_XFMR1 (open CB1_66KV and CB_XFMR1) (500ms HB), when a short-circuit happens around XFMR2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8511
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8512)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages PIOC_XFMR1 (open CB1_66KV and CB_XFMR1) (500ms HB), when a short-circuit happens around XFMR2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8512
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8513)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_XFMR1 (open CB1_66KV and CB_XFMR1) (1,4,16,64,256,1000ms HB), when a short-circuit happens around XFMR2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8513
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8514)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages PIOC_XFMR1 (open CB1_66KV and CB_XFMR1) (1,4,16,64,256,1000ms HB), when a short-circuit happens around XFMR2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8514
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;


# Modification attacks to open XFMR2 CBs in emergency operation (XFMR1 fault) to trigger unnecessary protection measures
8611)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of GOOSE messages PIOC_XFMR2 (open CB3_66KV and CB_XFMR2), when a short-circuit happens around XFMR1
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8611 ;;

8612)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of the first 30 GOOSE messages PIOC_XFMR2 (open CB3_66KV and CB_XFMR2), when a short-circuit happens around XFMR1
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8612 ;;


# Deletion attacks to delete GOOSE packets in emergency operation to delay protection measures
871)
#Running compromised/malicious program Publisher_PIOC
# -- delete the first 40 GOOSE messages, when a short-circuit happens around XFMR2
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_871 ;;


*)
echo "Sorry, wrong scenario ID" ;;
esac




