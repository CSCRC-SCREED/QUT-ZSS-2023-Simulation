#!/bin/bash
# Action 5, read invalid or non-existent journals from the domain directory in different IEDs

hosts=("32.32.32.23" "32.32.32.32" "32.32.32.11")

for n in ${hosts[@]};
do
    ./mms_utility -h $n -j simpleIOGenericIO/GGIO1
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/GGIO1\$CF
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/GGIO1\$CO
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/GGIO1\$DC
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/GGIO1\$MX
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/GGIO1\$OR
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/GGIO1\$ST
    sleep 4
    
    ./mms_utility -h $n-j simpleIOGenericIO/LLN0
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/LLN0\$CF
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/LLN0\$DC
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/LLN0\$EX
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/LLN0\$RP
    sleep 2
    ./mms_utility -h $n-j simpleIOGenericIO/LLN0\$ST
    sleep 4
    
    ./mms_utility -h $n -j simpleIOGenericIO/LPHD1
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/LPHD1\$DC
    sleep 2
    ./mms_utility -h $n -j simpleIOGenericIO/LPHD1\$ST

done

