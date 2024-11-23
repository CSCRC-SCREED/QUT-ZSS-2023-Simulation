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
#case start#
case $n in

######################################## Benign behaviour ########################################

0)
#Running benign program SV1_PUB and SV2_PUB
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

######################################## Malicious behaviour in emergency operation ########################################
####################--------------------- Injecting additional messages ---------------------#####################

9111)
#Running malicious scenarios 9111 -- inject mal_SV1_PUB (50ms HB) to fake normal situation only when a short-circuit fault occurs around 66kv Bus or XFMRs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9111 ;;

9112)
#Running malicious scenarios 9112 -- inject mal_SV1_PUB (25ms HB) to fake normal situation only when a short-circuit fault occurs around 66kv Bus or XFMRs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9112 ;;

9131)
#Running malicious scenarios 9131 -- inject mal_SV2_PUB (50ms HB) to fake normal situation only when a short-circuit fault occurs around 22kv Bus or FDRs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9131 ;;

9132)
#Running malicious scenarios 9132 -- inject mal_SV2_PUB (25ms HB) to fake normal situation only when a short-circuit fault occurs around 22kv Bus or FDRs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9132 ;;

######################################## Malicious behaviour in emergency operation ########################################
#####################--------------------- Modifying original messages ---------------------######################

921)
#Running malicious scenarios 921 -- Alter SV1_PUB to fake normal situation only when a short-circuit fault occurs around 66kv Bus or XFMRs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_921
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

923)
#Running malicious scenarios 923 -- Alter SV2_PUB to fake normal situation only when a short-circuit fault occurs around 22kv Bus or FDRs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_923 ;;

######################################## Malicious behaviour in normal operation ########################################
#######################--------------------- Injecting additional messages ---------------------#########################

9311a)
#Running malicious scenarios 9311a-- inject mal_SV1_PUB (100pkts 50ms) to fake emergency situation around 66kv Bus (66kV1=F_66kV1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9311a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9311b)
#Running malicious scenarios 9311b-- inject mal_SV1_PUB (100pkts 50ms) to fake emergency situation around 66kv Bus (66kV3=F_66kV2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9311b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9312a)
#Running malicious scenarios 9312a-- inject mal_SV1_PUB (80pkts 25ms) to fake emergency situation around 66kv Bus (66kV1=F_66kV1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9312a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9312b)
#Running malicious scenarios 9312b-- inject mal_SV1_PUB (80pkts 25ms) to fake emergency situation around 66kv Bus (66kV3=F_66kV2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9312b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

#--------------------------------------------------------------------------------------------------------------------------#

9321a)
#Running malicious scenarios 9321a-- inject mal_SV1_PUB (100pkts 50ms) to fake emergency situation around XFMR1 (66kV1=XFMR1W1=XFMR1W2=CB_XFMR1=F_XFMR1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9321a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9321b)
#Running malicious scenarios 9321b-- inject mal_SV1_PUB (100pkts 50ms) to fake emergency situation around XFMR2 (66kV3=XFMR2W1=XFMR2W2=CB_XFMR2=F_XFMR2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9321b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9322a)
#Running malicious scenarios 9322a-- inject mal_SV1_PUB (80pkts 25ms) to fake emergency situation around XFMR1 (66kV1=XFMR1W1=XFMR1W2=CB_XFMR1=F_XFMR1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9322a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9322b)
#Running malicious scenarios 9322b-- inject mal_SV1_PUB (80pkts 25ms) to fake emergency situation around XFMR2 (66kV3=XFMR2W1=XFMR2W2=CB_XFMR2=F_XFMR2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9322b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9323a)
#Running malicious scenarios 9323a-- inject mal_SV1_PUB (100pkts 50ms) to fake emergency situation around XFMR1 (66kV1=XFMR1W1=1000, XFMR1W2=1732, CB_XFMR1=0, F_XFMR1=3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9323a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9323b)
#Running malicious scenarios 9323b-- inject mal_SV1_PUB (100pkts 50ms) to fake emergency situation around XFMR2 (66kV3=XFMR2W1=1000, XFMR2W2=1732, CB_XFMR2=0, F_XFMR2=3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9323b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9324a)
#Running malicious scenarios 9324a-- inject mal_SV1_PUB (80pkts 25ms) to fake emergency situation around XFMR1 (66kV1=XFMR1W1=1000, XFMR1W2=1732, CB_XFMR1=0, F_XFMR1=3000))
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9324a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9324b)
#Running malicious scenarios 9324b-- inject mal_SV1_PUB (80pkts 25ms) to fake emergency situation around XFMR2 (66kV3=XFMR2W1=1000, XFMR2W2=1732, CB_XFMR2=0, F_XFMR2=3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9324b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

#--------------------------------------------------------------------------------------------------------------------------#

9331a)
#Running malicious scenarios 9331a-- inject mal_SV2_PUB (100pkts 50ms) to fake emergency situation around 22kv Bus (22kV1=F_22kV1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9331a ;;

9331b)
#Running malicious scenarios 9331b-- inject mal_SV2_PUB (100pkts 50ms) to fake emergency situation around 22kv Bus (22kV3=F_22kV2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9331b ;;

9332a)
#Running malicious scenarios 9332a-- inject mal_SV2_PUB (80pkts 25ms) to fake emergency situation around 22kv Bus (22kV1=F_22kV1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9332a ;;

9332b)
#Running malicious scenarios 9332b-- inject mal_SV2_PUB (80pkts 25ms) to fake emergency situation around 22kv Bus (22kV3=F_22kV2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9332b ;;

#--------------------------------------------------------------------------------------------------------------------------#

9341a)
#Running malicious scenarios 9341a-- inject mal_SV2_PUB (100pkts 50ms) to fake emergency situation around Feeders (22kV1=FDR1=F_FDR1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9341a ;;

9341b)
#Running malicious scenarios 9341b-- inject mal_SV2_PUB (100pkts 50ms) to fake emergency situation around Feeders (FDR2=F_FDR2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9341b ;;

9341c)
#Running malicious scenarios 9341c-- inject mal_SV2_PUB (100pkts 50ms) to fake emergency situation around Feeders (FDR3=F_FDR3=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9341c ;;

9341d)
#Running malicious scenarios 9341d-- inject mal_SV2_PUB (100pkts 50ms) to fake emergency situation around Feeders (22kV3=FDR4=F_FDR4=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9341d ;;

9342a)
#Running malicious scenarios 9342a-- inject mal_SV2_PUB (80pkts 25ms) to fake emergency situation around Feeders (22kV1=FDR1=F_FDR1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9342a ;;

9342b)
#Running malicious scenarios 9342b-- inject mal_SV2_PUB (80pkts 25ms) to fake emergency situation around Feeders (FDR2=F_FDR2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9342b ;;

9342c)
#Running malicious scenarios 9342c-- inject mal_SV2_PUB (80pkts 25ms) to fake emergency situation around Feeders (FDR3=F_FDR3=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9342c ;;

9342d)
#Running malicious scenarios 9342d-- inject mal_SV2_PUB (80pkts 25ms) to fake emergency situation around Feeders (22kV3=FDR4=F_FDR4=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9342d ;;

######################################## Malicious behaviour in normal operation ########################################
#######################--------------------- Modifying original messages ---------------------#########################

9411a)
#Running malicious scenarios 9411a -- Alter SV1_PUB (20 packets) to fake emergency situation around 66kv Bus (66kV1=F_66kV1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9411a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9411b)
#Running malicious scenarios 9411b -- Alter SV1_PUB (20 packets) to fake emergency situation around 66kv Bus (66kV3=F_66kV2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9411b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9412a)
#Running malicious scenarios 9412a -- Alter SV1_PUB (two packets) to fake emergency situation around 66kv Bus (66kV1=F_66kV1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9412a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9412b)
#Running malicious scenarios 9412b -- Alter SV1_PUB (two packets) to fake emergency situation around 66kv Bus (66kV3=F_66kV2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9412b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

#--------------------------------------------------------------------------------------------------------------------------#

9421a)
#Running malicious scenarios 9421a-- Alter SV1_PUB (20 packets) to fake emergency situation around XFMR1 (66kV1=XFMR1W1=XFMR1W2=CB_XFMR1=F_XFMR1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9421a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9421b)
#Running malicious scenarios 9421b-- Alter SV1_PUB (20 packets) to fake emergency situation around XFMR2 (66kV3=XFMR2W1=XFMR2W2=CB_XFMR2=F_XFMR2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9421b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9422a)
#Running malicious scenarios 9422a-- Alter SV1_PUB (two packets) to fake emergency situation around XFMR1 (66kV1=XFMR1W1=XFMR1W2=CB_XFMR1=F_XFMR1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9422a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9422b)
#Running malicious scenarios 9422b-- Alter SV1_PUB (two packets) to fake emergency situation around XFMR2 (66kV3=XFMR2W1=XFMR2W2=CB_XFMR2=F_XFMR2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9422b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9423a)
#Running malicious scenarios 9423a-- Alter SV1_PUB (20 packets) to fake emergency situation around XFMR1 (66kV1=XFMR1W1=1000, XFMR1W2=1732, CB_XFMR1=0, F_XFMR1=3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9423a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9423b)
#Running malicious scenarios 9423b-- Alter SV1_PUB (20 packets) to fake emergency situation around XFMR2 (66kV3=XFMR2W1=1000, XFMR2W2=1732, CB_XFMR2=0, F_XFMR2=3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9423b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9424a)
#Running malicious scenarios 9424a-- Alter SV1_PUB (two packets) to fake emergency situation around XFMR1 (66kV1=XFMR1W1=1000, XFMR1W2=1732, CB_XFMR1=0, F_XFMR1=3000))
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9424a
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9424b)
#Running malicious scenarios 9424b-- Alter SV1_PUB (two packets) to fake emergency situation around XFMR2 (66kV3=XFMR2W1=1000, XFMR2W2=1732, CB_XFMR2=0, F_XFMR2=3000)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9424b
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

#--------------------------------------------------------------------------------------------------------------------------#

9431a)
#Running malicious scenarios 9431a-- Alter SV2_PUB (20 packets) to fake emergency situation around 22kv Bus (22kV1=F_22kV1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9431a ;;

9431b)
#Running malicious scenarios 9431b-- Alter SV2_PUB (20 packets) to fake emergency situation around 22kv Bus (22kV3=F_22kV2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9431b ;;

9432a)
#Running malicious scenarios 9432a-- Alter SV2_PUB (two packets) to fake emergency situation around 22kv Bus (22kV1=F_22kV1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9432a ;;

9432b)
#Running malicious scenarios 9432b-- Alter SV2_PUB (two packets) to fake emergency situation around 22kv Bus (22kV3=F_22kV2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9432b ;;

#--------------------------------------------------------------------------------------------------------------------------#

9441a)
#Running malicious scenarios 9441a-- Alter SV2_PUB (20 packets) to fake emergency situation around Feeders (22kV1=FDR1=F_FDR1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9441a ;;

9441b)
#Running malicious scenarios 9441b-- Alter SV2_PUB (20 packets) to fake emergency situation around Feeders (FDR2=F_FDR2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9441b ;;

9441c)
#Running malicious scenarios 9441c-- Alter SV2_PUB (20 packets) to fake emergency situation around Feeders (FDR3=F_FDR3=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9441c ;;

9441d)
#Running malicious scenarios 9441d-- Alter SV2_PUB (20 packets) to fake emergency situation around Feeders (22kV3=FDR4=F_FDR4=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9441d ;;

9442a)
#Running malicious scenarios 9442a-- Alter SV2_PUB (two packets) to fake emergency situation around Feeders (22kV1=FDR1=F_FDR1=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9442a ;;

9442b)
#Running malicious scenarios 9442b-- Alter SV2_PUB (two packets) to fake emergency situation around Feeders (FDR2=F_FDR2=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9442b ;;

9442c)
#Running malicious scenarios 9442c-- Alter SV2_PUB (two packets) to fake emergency situation around Feeders (FDR3=F_FDR3=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9442c ;;

9442d)
#Running malicious scenarios 9442d-- Alter SV2_PUB (two packets) to fake emergency situation around Feeders (22kV3=FDR4=F_FDR4=2017)
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9442d ;;

######################################## Malicious behaviour in normal operation based on a preivous fault ########################################
#########################--------------------- Replaying and injecting additional messages ---------------------#########################

9511)
#Running malicious scenarios 9511 -- record a short-circuit fault occurred around 66kv Bus, replay and inject mal_SV1_PUB (all recorded pkts 50ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9511 ;;

9512)
#Running malicious scenarios 9512 -- record a short-circuit fault occurred around 66kv Bus, replay and inject mal_SV1_PUB (all recorded pkts 25ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9512 ;;

9513)
#Running malicious scenarios 9513 -- record a short-circuit fault occurred around 66kv Bus, replay and inject mal_SV1_PUB (the first half recorded pkts 25ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9513 ;;

9521)
#Running malicious scenarios 9521 -- record a short-circuit fault occurred around Transformers, replay and inject mal_SV1_PUB (all recorded pkts 50ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9521 ;;

9522)
#Running malicious scenarios 9522 -- record a short-circuit fault occurred around Transformers, replay and inject mal_SV1_PUB (all recorded pkts 25ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9522 ;;

9523)
#Running malicious scenarios 9523 -- record a short-circuit fault occurred around Transformers, replay and inject mal_SV1_PUB (the first half recorded pkts 25ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9523 ;;

9531)
#Running malicious scenarios 9531 -- record a short-circuit fault occurred around 22kv Bus, replay and inject mal_SV2_PUB (all recorded pkts 50ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9531 ;;

9532)
#Running malicious scenarios 9532 -- record a short-circuit fault occurred around 22kv Bus, replay and inject mal_SV2_PUB (all recorded pkts 25ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9532 ;;

9533)
#Running malicious scenarios 9533 -- record a short-circuit fault occurred around 22kv Bus, replay and inject mal_SV2_PUB (the first half recorded pkts 25ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9533 ;;

9541)
#Running malicious scenarios 9541 -- record a short-circuit fault occurred around Feeders, replay and inject mal_SV2_PUB (all recorded pkts 50ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9541 ;;

9542)
#Running malicious scenarios 9542 -- record a short-circuit fault occurred around Feeders, replay and inject mal_SV2_PUB (all recorded pkts 25ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9542 ;;

9543)
#Running malicious scenarios 9543 -- record a short-circuit fault occurred around Feeders, replay and inject mal_SV2_PUB (the first half recorded pkts 25ms) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher 
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9543 ;;

######################################## Malicious behaviour in normal operation based on a preivous fault ########################################
#########################--------------------- Replaying and modifying original messages ---------------------#########################

9611)
#Running malicious scenarios 9611 -- record a short-circuit fault occurred around 66kv Bus, alter SV1_PUB (all recorded pkts) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9611
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9612)
#Running malicious scenarios 9612 -- record a short-circuit fault occurred around 66kv Bus, alter SV1_PUB (the first one-third recorded pkts) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9612
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9613)
#Running malicious scenarios 9613 -- record a short-circuit fault occurred around 66kv Bus, alter SV1_PUB (all recorded pkts) (1.1 times of measurements) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9613
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9614)
#Running malicious scenarios 9614 -- record a short-circuit fault occurred around 66kv Bus, alter SV1_PUB (the first quater recorded pkts) (1.2 times of measurements) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9614
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9621)
#Running malicious scenarios 9621 -- record a short-circuit fault occurred around Transformers, alter SV1_PUB (all recorded pkts) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9621
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9622)
#Running malicious scenarios 9622 -- record a short-circuit fault occurred around Transformers, alter SV1_PUB (the first one-third recorded pkts) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9622
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9623)
#Running malicious scenarios 9623 -- record a short-circuit fault occurred around Transformers, alter SV1_PUB (all recorded pkts) (1.1 times of measurements) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9623
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9624)
#Running malicious scenarios 9624 -- record a short-circuit fault occurred around Transformers, alter SV1_PUB (the first quater recorded pkts) (1.2 times of measurements) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_9624
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

9631)
#Running malicious scenarios 9631 -- record a short-circuit fault occurred around 22kv Bus, alter SV2_PUB (all recorded pkts) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9631 ;;

9632)
#Running malicious scenarios 9632 -- record a short-circuit fault occurred around 22kv Bus, alter SV2_PUB (the first one-third recorded pkts) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9632 ;;

9633)
#Running malicious scenarios 9633 -- record a short-circuit fault occurred around 22kv Bus, alter SV2_PUB (all recorded pkts) (1.1 times of measurements) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9633 ;;

9634)
#Running malicious scenarios 9634 -- record a short-circuit fault occurred around 22kv Bus, alter SV2_PUB (the first quater recorded pkts) (1.2 times of measurements) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9634 ;;

9641)
#Running malicious scenarios 9641 -- record a short-circuit fault occurred around Feeders, alter SV2_PUB (all recorded pkts) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9641 ;;

9642)
#Running malicious scenarios 9642 -- record a short-circuit fault occurred around Feeders, alter SV2_PUB (the first one-third recorded pkts) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9642 ;;

9643)
#Running malicious scenarios 9643 -- record a short-circuit fault occurred around Feeders, alter SV2_PUB (all recorded pkts) (1.1 times of measurements) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9643 ;;

9644)
#Running malicious scenarios 9644 -- record a short-circuit fault occurred around Feeders, alter SV2_PUB (the first quater recorded pkts) (1.2 times of measurements) to fake emergency situation
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_9644 ;;

######################################## Malicious behaviour in emergency operation ########################################
#########################--------------------- Deleting original messages ---------------------#########################

971)
#Running malicious scenarios 971 -- SV1_PUB deletes the first 100 SV packets to delay protections when a short-circuit fault occurs around 66kv Bus or XFMRs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher_971
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher ;;

973)
#Running malicious scenarios 973 -- SV2_PUB deletes the first 100 SV packets to delay protections when a short-circuit fault occurs around 22kv Bus or FDRs
gnome-terminal --hide-menubar -t SV1_PUB --geometry=23x4+1700+190 -- ./snr/sv1_publisher
gnome-terminal --hide-menubar -t SV2_PUB --geometry=23x4+1700+300 -- ./snr/sv2_publisher_973 ;;

#else#
*)
echo "Sorry, wrong scenario ID" ;;
#case finished#
esac
