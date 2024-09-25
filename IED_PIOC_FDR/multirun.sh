#!/bin/bash

#Compile simlink.cpp
g++ simlink.cpp -o simlink -pthread

#Collect pcap from interface enp0s8 and dump to file "QUTZS.pcapng"
#gnome-terminal --hide-menubar -t CollectPCAP --geometry=36x4+46+210 -- tshark -i enp0s8 -w /media/sf_shared_amongVMs/QUTZS.pcapng -f "not udp" -F pcap

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
8121a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB1_22kV) (500ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8121a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8121b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB3_22kV) (500ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8121b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8131a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB_FDR1) (500ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8131a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8131b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB_FDR2) (500ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8131b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8131c)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB_FDR3) (500ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8131c
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8131d)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB_FDR4) (500ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8131d
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8122a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB1_22kV) (250ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8122a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8122b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB3_22kV) (250ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8122b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8132a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB_FDR1) (250ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8132a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8132b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB_FDR2) (250ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8132b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8132c)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB_FDR3) (250ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8132c
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8132d)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE (open CB_FDR4) (250ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8132d
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8123a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 15 GOOSE (open CB1_22kV) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8123a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8123b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 15 GOOSE (open CB3_22kV) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8123b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8133a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 15 GOOSE (open CB_FDR1) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8133a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8133b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 15 GOOSE (open CB_FDR2) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8133b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8133c)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 15 GOOSE (open CB_FDR3) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8133c
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8133d)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 15 GOOSE (open CB_FDR4) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8133d
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8124a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 10 GOOSE (open CB1_22kV) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8124a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8124b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 10 GOOSE (open CB3_22kV) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8124b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8134a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 10 GOOSE (open CB_FDR1) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8134a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8134b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 10 GOOSE (open CB_FDR2) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8134b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8134c)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 10 GOOSE (open CB_FDR3) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8134c
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8134d)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 10 GOOSE (open CB_FDR4) (1,4,16,64,256,1000ms HB) every 1 minute
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8134d
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;




# Modification attacks to open CBs in fault-free operation to disrupt power supply
8221a)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB1_22kV) every 1 minute (st and HB unchange)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8221a ;;

8221b)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB3_22kV) every 1 minute (st and HB unchange)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8221b ;;

8231a)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB_FDR1) every 1 minute (st and HB unchange)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8231a ;;

8231b)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB_FDR2) every 1 minute (st and HB unchange)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8231b ;;

8231c)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB_FDR3) every 1 minute (st and HB unchange)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8231c ;;

8231d)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB_FDR4) every 1 minute (st and HB unchange)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8231d ;;

8222a)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB1_22kV) every 1 minute (st+1 and 1,4,16,64,256,1000ms HB)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8222a ;;

8222b)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB3_22kV) every 1 minute (st+1 and 1,4,16,64,256,1000ms HB)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8222b ;;

8232a)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB_FDR1) every 1 minute (st+1 and 1,4,16,64,256,1000ms HB)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8232a ;;

8232b)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB_FDR2) every 1 minute (st+1 and 1,4,16,64,256,1000ms HB)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8232b ;;

8232c)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB_FDR3) every 1 minute (st+1 and 1,4,16,64,256,1000ms HB)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8232c ;;

8232d)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of 10 GOOSE messages (open CB_FDR4) every 1 minute (st+1 and 1,4,16,64,256,1000ms HB)
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8232d ;;




# Injection attacks to close CBs in emergency operation to interfere protection measures
8321)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages (close CB1_22kV and CB3_22kV) (500ms HB), when a short-circuit happens on 22kv bus line  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8321
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8331)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages (close CB_FDR1, CB_FDR2, CB_FDR3, CB_FDR4) (500ms HB), when a short-circuit happens on any Feeders  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8331
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8322)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages (close CB1_22kV and CB3_22kV) (500ms HB), when a short-circuit happens on 22kv bus line  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8322
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8332)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages (close CB_FDR1, CB_FDR2, CB_FDR3, CB_FDR4) (500ms HB), when a short-circuit happens on any Feeders  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8332
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8323)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages (close CB1_22kV and CB3_22kV) (1,4,16,64,256,1000ms HB), when a short-circuit happens on 22kv bus line  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8323
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8333)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages (close CB_FDR1, CB_FDR2, CB_FDR3, CB_FDR4) (1,4,16,64,256,1000ms HB), when a short-circuit happens on any Feeders  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8333
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8324)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages (close CB1_22kV and CB3_22kV) (1,4,16,64,256,1000ms HB), when a short-circuit happens on 22kv bus line
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8324
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8334)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages (close CB_FDR1, CB_FDR2, CB_FDR3, CB_FDR4) (1,4,16,64,256,1000ms HB), when a short-circuit happens on any Feeders
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8334
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;




# Modification attacks to close CBs in emergency operation to stop protection measures
8421)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of GOOSE messages (close CB1_22kV and CB3_22kV), when a short-circuit happens on 22kv bus line
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8421 ;;

8431)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of GOOSE messages (close CB_FDR1, CB_FDR2, CB_FDR3, CB_FDR4), when a short-circuit happens on any Feeders
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8431 ;;

8422)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of the first 30 GOOSE messages (close CB1_22kV and CB3_22kV), when a short-circuit happens on 22kv bus line
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8422 ;;

8432)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of the first 30 GOOSE messages (close CB_FDR1, CB_FDR2, CB_FDR3, CB_FDR4), when a short-circuit happens on any Feeders
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8432 ;;




# Injection attacks to open XFMR1 CBs in emergency operation to trigger unnecessary protection measures
8521a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB3_22kV) (500ms HB), when a short-circuit happens around CB1_22kV  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8521a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8521b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB1_22kV) (500ms HB), when a short-circuit happens around CB3_22kV  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8521b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8531a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB_FDR2) (500ms HB), when a short-circuit happens around Feeder1  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8531a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8531b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB_FDR1) (500ms HB), when a short-circuit happens around Feeder2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8531b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8531c)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB_FDR4) (500ms HB), when a short-circuit happens around Feeder3  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8531c
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8531d)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB_FDR3) (500ms HB), when a short-circuit happens around Feeder4  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8531d
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8522a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages PIOC_FDR (open CB3_22kV) (500ms HB), when a short-circuit happens around CB1_22kV  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8522a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8522b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages PIOC_FDR (open CB1_22kV) (500ms HB), when a short-circuit happens around CB3_22kV  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8522b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8532a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages PIOC_FDR (open CB_FDR2) (500ms HB), when a short-circuit happens around Feeder1  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8532a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8532b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages PIOC_FDR (open CB_FDR1) (500ms HB), when a short-circuit happens around Feeder2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8532b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8532c)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages PIOC_FDR (open CB_FDR4) (500ms HB), when a short-circuit happens around Feeder3  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8532c
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8532d)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 40 GOOSE messages PIOC_FDR (open CB_FDR3) (500ms HB), when a short-circuit happens around Feeder4  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8532d
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8523a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB3_22kV) (1,4,16,64,256,1000ms HB), when a short-circuit happens around CB1_22kV  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8523a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8523b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB1_22kV) (1,4,16,64,256,1000ms HB), when a short-circuit happens around CB3_22kV  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8523b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8533a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB_FDR2) (1,4,16,64,256,1000ms HB), when a short-circuit happens around Feeder1  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8533a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8533b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB_FDR1) (1,4,16,64,256,1000ms HB), when a short-circuit happens around Feeder2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8533b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8533c)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB_FDR4) (1,4,16,64,256,1000ms HB), when a short-circuit happens around Feeder3  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8533c
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8533d)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects GOOSE messages PIOC_FDR (open CB_FDR3) (1,4,16,64,256,1000ms HB), when a short-circuit happens around Feeder4  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8533d
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8524a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages PIOC_FDR (open CB3_22kV) (1,4,16,64,256,1000ms HB), when a short-circuit happens around CB1_22kV  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8524a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8524b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages PIOC_FDR (open CB1_22kV) (1,4,16,64,256,1000ms HB), when a short-circuit happens around CB3_22kV  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8524b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8534a)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages PIOC_FDR (open CB_FDR2) (1,4,16,64,256,1000ms HB), when a short-circuit happens around Feeder1  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8534a
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8534b)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages PIOC_FDR (open CB_FDR1) (1,4,16,64,256,1000ms HB), when a short-circuit happens around Feeder2  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8534b
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8534c)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages PIOC_FDR (open CB_FDR4) (1,4,16,64,256,1000ms HB), when a short-circuit happens around Feeder3  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8534c
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;

8534d)
#Running both benign program Publisher_PIOC and malicious program Mal_PIOC
# -- injects 30 GOOSE messages PIOC_FDR (open CB_FDR3) (1,4,16,64,256,1000ms HB), when a short-circuit happens around Feeder4  
gnome-terminal --hide-menubar -t Mal_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8534d
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC ;;




# Modification attacks to open XFMR2 CBs in emergency operation (XFMR1 fault) to trigger unnecessary protection measures
8621)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of GOOSE messages PIOC_FDR (open CB1_22kV and CB3_22kV), when a short-circuit happens on one location of the 22kV bus line
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8621 ;;

8631ab)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of GOOSE messages PIOC_FDR (open CB_FDR1 and CB_FDR2), when a short-circuit happens on either Feeder1 or Feeder2
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8631ab ;;

8631cd)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of GOOSE messages PIOC_FDR (open CB_FDR3 and CB_FDR4), when a short-circuit happens on either Feeder3 or Feeder4
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8631cd ;;

8622)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of the first 30 GOOSE messages PIOC_FDR (open CB1_22kV and CB3_22kV), when a short-circuit happens on one location of the 22kV bus line
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8622 ;;

8632ab)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of the first 30 GOOSE messages PIOC_FDR (open CB_FDR1 and CB_FDR2), when a short-circuit happens on either Feeder1 or Feeder2
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8632ab ;;

8632cd)
#Running compromised/malicious program Publisher_PIOC
# -- modify the allData fields of the first 30 GOOSE messages PIOC_FDR (open CB_FDR3 and CB_FDR4), when a short-circuit happens on either Feeder3 or Feeder4
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_8632cd ;;




# Deletion attacks to delete GOOSE packets in emergency operation to delay protection measures
872)
#Running compromised/malicious program Publisher_PIOC
# -- delete the first 40 GOOSE messages, when a short-circuit happens on 22kV bus line
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_872 ;;

873)
#Running compromised/malicious program Publisher_PIOC
# -- delete the first 40 GOOSE messages, when a short-circuit happens on any Feeders
gnome-terminal --hide-menubar -t PUB_PIOC --geometry=36x4+46+320 -- ./snr/goose_publisher_PIOC_873 ;;


*)
echo "Sorry, wrong scenario ID" ;;
esac




