#!/bin/bash

#Compile simlink.cpp
g++ simlink.cpp -o simlink -pthread

#Run simlink -- the interface between libiec61850 and MATLAB/Simulink
gnome-terminal --hide-menubar -t INTFtoSimulink --geometry=23x29+1700+500 -- ./simlink

#Running program Subscriber from IED_PIOC_XFMR1
gnome-terminal --hide-menubar -t SUB_XFMR1 --geometry=36x11+46+4 -- ./snr/goose_subscriber_PIOC_XFMR1

#Running program Subscriber from IED_PIOC_XFMR2
gnome-terminal --hide-menubar -t SUB_XFMR2 --geometry=36x11+46+264 -- ./snr/goose_subscriber_PIOC_XFMR2

#Running program Subscriber from IED_PIOC_FDR
gnome-terminal --hide-menubar -t SUB_FDR --geometry=36x11+46+500 -- ./snr/goose_subscriber_PIOC_FDR

#Running program Subscriber from IED_BFP
#gnome-terminal --hide-menubar -t SUB_BFP --geometry=36x11+46+770 -- ./snr/goose_subscriber_BFP_FDR

echo "Enter your scenario ID"
read n
case $n in

######################################## Benign behaviour ########################################

0)
#Running benign program SV1_PUB and SV2_PUB
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;


######################################## Malicious behaviour in emergency ########################################

9111)
#Running malicious scenarios 9111 -- inject mal_SV1_PUB (50ms HB) to fake normal situation only when a fault occurs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9111 ;;

9112)
#Running malicious scenarios 9112 -- inject mal_SV1_PUB (25ms HB) to fake normal situation only when a fault occurs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9112 ;;

9131)
#Running malicious scenarios 9131 -- inject mal_SV2_PUB (50ms HB) to fake normal situation only when a fault occurs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9131 ;;

9132)
#Running malicious scenarios 9132 -- inject mal_SV2_PUB (25ms HB) to fake normal situation only when a fault occurs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9132 ;;

915)
#Running malicious scenarios 915 -- delete first 100 packets in SV1_PUB when a fault occurs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_915
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

916)
#Running malicious scenarios 916 -- delete first 100 packets in SV2_PUB when a fault occurs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_916 ;;


############################################## Malicious behaviour in normal without KCL/KVL laws ##############################################################################
#########################--------------------- Injecting additional messages ---------------------#########################
9211)
#Running malicious scenarios 9211 -- inject mal_SV1_PUB (60pkts 50ms) to fake emergency situation (2 types of 66kV with 2000pkts intervals between) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9211 ;;

9212)
#Running malicious scenarios 9212 -- inject mal_SV1_PUB (30pkts 25ms) (66kV) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9212 ;;

9221)
#Running malicious scenarios 9221 -- inject mal_SV1_PUB (60pkts 50ms) to fake emergency situation (2 types of XFMR with 2000pkts intervals between) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9221 ;;

9222)
#Running malicious scenarios 9222 -- inject mal_SV1_PUB (30pkts 25ms) (XFMR) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9222 ;;

9223)
#Running malicious scenarios 9223 -- inject mal_SV1_PUB (60pkts 50ms) (XFMR) (1000, 1732, 0, 3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9223 ;;

9224)
#Running malicious scenarios 9224 -- inject mal_SV1_PUB (30pkts 25ms) (XFMR) (1000, 1732, 0, 3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9224 ;;

9231)
#Running malicious scenarios 9231 -- inject mal_SV2_PUB (60pkts 50ms) to fake emergency situation (2 types of 22kV with 1000pkts intervals between) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9231 ;;

9232)
#Running malicious scenarios 9232 -- inject mal_SV2_PUB (30pkts 25ms) (22kV) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9232 ;;

9241)
#Running malicious scenarios 9241 -- inject mal_SV1_PUB (60pkts 50ms) to fake emergency situation (4 types of FDR with 1000pkts intervals among each type) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9241 ;;

9242)
#Running malicious scenarios 9242 -- inject mal_SV1_PUB (30pkts 25ms) (FDR) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9242 ;;

#########################--------------------- Altering original messages ---------------------#########################
9311)
#Running malicious scenarios 9311 -- alter SV1_PUB (10pkts) to fake emergency situation (2 types of 66kV with 2000pkts intervals between) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9311
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9312)
#Running malicious scenarios 9312 -- alter SV1_PUB (2pkts) (66kV) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9312
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9321)
#Running malicious scenarios 9321 -- alter SV1_PUB (10pkts) to fake emergency situation (2 types of XFMR with 2000pkts intervals between) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9321
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9322)
#Running malicious scenarios 9322 -- alter SV1_PUB (2pkts) (XFMR) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9322
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9323)
#Running malicious scenarios 9323 -- alter SV1_PUB (10pkts) (XFMR) (1000, 1732, 0, 3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9323
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9324)
#Running malicious scenarios 9324 -- alter SV1_PUB (2pkts) (XFMR) (1000, 1732, 0, 3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9324
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9331)
#Running malicious scenarios 9331 -- alter SV2_PUB (10pkts) to fake emergency situation (2 types of 22kV with 1000pkts intervals between) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9331 ;;

9332)
#Running malicious scenarios 9332 -- alter SV2_PUB (2pkts) (22kV) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9332 ;;

9341)
#Running malicious scenarios 9341 -- alter SV2_PUB (10pkts) to fake emergency situation (4 types of FDR with 1000pkts intervals among each type) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9341 ;;

9342)
#Running malicious scenarios 9342 -- alter SV2_PUB (2pkts) (FDR) (2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9342 ;;


######################################## Malicious behaviour in normal from recorded faults ########################################
#########################--------------------- Injecting additional messages ---------------------#########################

9411)
#Running malicious scenarios 9411 -- record a fault, then 2000 packets later, inject mal_SV1_PUB (all recorded pkts 50ms) to fake emergency situation (2 types of 66kV seperately)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9411 ;;

9412)
#Running malicious scenarios 9412 -- inject mal_SV1_PUB (all recorded pkts 25ms) (66kV)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9412 ;;

9413)
#Running malicious scenarios 9413 -- inject mal_SV1_PUB (the first 50 recorded pkts 50ms) (66kV)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9413 ;;

9414)
#Running malicious scenarios 9414 -- inject mal_SV1_PUB (the first 50 recorded pkts 25ms) (66kV)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9414 ;;

9421)
#Running malicious scenarios 9421 -- record a fault, then 2000 packets later, inject mal_SV1_PUB (all recorded pkts 50ms) to fake emergency situation (2 types of XFMR seperately)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9421 ;;

9422)
#Running malicious scenarios 9422 -- inject mal_SV1_PUB (all recorded pkts 25ms) (XFMR)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9422 ;;

9423)
#Running malicious scenarios 9423 -- inject mal_SV1_PUB (the first 80 recorded pkts 50ms) (XFMR)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9423 ;;

9424)
#Running malicious scenarios 9424 -- inject mal_SV1_PUB (the first 80 recorded pkts 25ms) (XFMR)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9424 ;;

9431)
#Running malicious scenarios 9431 -- record a fault, then 2000 packets later, inject mal_SV2_PUB (all recorded pkts 50ms) to fake emergency situation (2 types of 22kV seperately)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9431 ;;

9432)
#Running malicious scenarios 9432 -- inject mal_SV2_PUB (all recorded pkts 25ms) (22kV)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9432 ;;

9433)
#Running malicious scenarios 9433 -- inject mal_SV2_PUB (the first 50 recorded pkts 50ms) (22kV)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9433 ;;

9434)
#Running malicious scenarios 9434 -- inject mal_SV2_PUB (the first 50 recorded pkts 25ms) (22kV)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9434 ;;

9441)
#Running malicious scenarios 9441 -- record a fault, then 2000 packets later, inject mal_SV2_PUB (all recorded pkts 50ms) to fake emergency situation (4 types of FDR seperately)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9441 ;;

9442)
#Running malicious scenarios 9442 -- inject mal_SV2_PUB (all recorded pkts 25ms) (FDR)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9442 ;;

9443)
#Running malicious scenarios 9443 -- inject mal_SV2_PUB (the first 50 recorded pkts 50ms) (FDR)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9443 ;;

9444)
#Running malicious scenarios 9444 -- inject mal_SV2_PUB (the first 50 recorded pkts 25ms) (FDR)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9444 ;;

#########################--------------------- Altering original messages ---------------------#########################
9511)
#Running malicious scenarios 9511 -- record a fault, then 2000 packets later, alter SV1_PUB (all recorded pkts) to fake emergency situation (2 types of 66kV seperately)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9511
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9512)
#Running malicious scenarios 9512 -- alter SV1_PUB (the first 50 recorded pkts) (66kV)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9512
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9513)
#Running malicious scenarios 9513 -- alter SV1_PUB (all recorded pkts) (66kV) (values*1.5)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9513
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9514)
#Running malicious scenarios 9514 -- alter SV1_PUB (the first 30 recorded pkts) (66kV) (values*2)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9514
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9521)
#Running malicious scenarios 9521 -- record a fault, then 2000 packets later, alter SV1_PUB (all recorded pkts) to fake emergency situation (2 types of XFMR seperately)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9521
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9522)
#Running malicious scenarios 9522 -- alter SV1_PUB (the first 80 recorded pkts) (XFMR)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9522
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9523)
#Running malicious scenarios 9523 -- alter SV1_PUB (all recorded pkts) (XFMR) (values*1.5)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9523
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9524)
#Running malicious scenarios 9524 -- alter SV1_PUB (the first 50 recorded pkts) (XFMR) (values*2)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9524
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9531)
#Running malicious scenarios 9531 -- record a fault, then 2000 packets later, alter SV2_PUB (all recorded pkts) to fake emergency situation (2 types of 22kV seperately)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9531 ;;

9532)
#Running malicious scenarios 9532 -- alter SV2_PUB (the first 50 recorded pkts) (22kV)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9532 ;;

9533)
#Running malicious scenarios 9533 -- alter SV2_PUB (all recorded pkts) (22kV) (values*1.5)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9533 ;;

9534)
#Running malicious scenarios 9534 -- alter SV2_PUB (the first 30 recorded pkts) (22kV) (values*2)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9534 ;;

9541)
#Running malicious scenarios 9541 -- record a fault, then 2000 packets later, alter SV2_PUB (all recorded pkts) to fake emergency situation (4 types of FDR seperately)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9541 ;;

9542)
#Running malicious scenarios 9542 -- alter SV2_PUB (the first 50 recorded pkts) (FDR)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9542 ;;

9543)
#Running malicious scenarios 9543 -- alter SV2_PUB (all recorded pkts) (FDR) (values*1.5)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9543 ;;

9544)
#Running malicious scenarios 9544 -- alter SV2_PUB (the first 30 recorded pkts) (FDR) (values*2)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9544 ;;

*)
echo "Sorry, wrong scenario ID" ;;
esac
