from scapy.all import *
import csv
import sys
import struct

TemPCAP=rdpcap("/media/sf_shared_amongVMs/QUTZS.pcapng") #
# TemPCAP=rdpcap("{}.pcapng".format(sys.argv[1]))

#############		Extract features from GOOSE messages		##############
with open('/media/sf_shared_amongVMs/QUTZS_GOOSE.csv', mode='w') as traffic:
# with open('{}_GOOSE.csv'.format(sys.argv[1]), mode='w') as traffic:
    traffic = csv.writer(traffic, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    
    traffic.writerow(['pkt arrival time', 'MACsrc', 'MACdst', 'APPID', 'GOOSElength', 'gocbRef', 'Timeallowedtolive', 'datset', 'goID','t', 'stNum', 'sqNum', 'simulation', 'confRev', 'ndsCom', 'num of data', 'data'])   
    gocbRef=datset=goID=""
    alldata=[]
     
    for pkt in TemPCAP:
        # GOOSE only, when the sequence number of hsr_prp == 35000(0x88b8), this hsr_prp will be mis-classified as GOOSE. Thus, raw(pkt)[26][27] are cross-checking.
        if hex(raw(pkt)[16]) == '0x88' and hex(raw(pkt)[17]) == '0xb8' and hex(raw(pkt)[26]) == '0x61' and hex(raw(pkt)[27]) == '0x81': 
        
            # APPID #
            APPID=hex(pkt.load[0]*16**2+pkt.load[1])
            
            # GOOSElength #
            len_GOOSE=pkt.load[2]*16+pkt.load[3]
            index=11 # pkt.load[index] is "0x80" indicating the flag of gocbRef #
            
            # gocbRef #
            len_gocbRef=pkt.load[index+1]
            for x in range(len_gocbRef):
                gocbRef+=chr(pkt.load[index+2+x])
            index=index+2+len_gocbRef # pkt.load[index] is "0x81" indicating the flag of timeAllowedtoLive #
            
            # timeallowedtolive # 
            len_ttl=pkt.load[index+1]
            if len_ttl == 1:
                TLL=pkt.load[index+2]
            if len_ttl == 2: # in the IEC 61850 standard, the max_len_ttl == 5, here is only usual cases #
                TLL=pkt.load[index+2]*256+pkt.load[index+3]
            index=index+2+len_ttl # pkt.load[index] is "0x82" indicating the flag of datSet #
            
            # datset #
            len_datset=pkt.load[index+1]
            for x in range(len_datset):
                datset+=chr(pkt.load[index+2+x])
            index=index+2+len_datset # pkt.load[index] is "0x83" indicating the flag of goID #
            
            # goID #
            len_goID=pkt.load[index+1]
            for x in range(len_goID):
                goID+=chr(pkt.load[index+2+x])
            index=index+2+len_goID # pkt.load[index] is "0x84" indicating the flag of t #
            
            # t (the time at which the last state change was detected) #	
            len_t=8
            t=format(pkt.load[index+2]*16**6+pkt.load[index+3]*16**4+pkt.load[index+4]*16**2+pkt.load[index+5]+pkt.load[index+6]*16**-2+pkt.load[index+7]*16**-4+pkt.load[index+8]*16**-6,'.5f')
            # The first four bytes is integer seconds, the following four bytes is the fraction of second. The last byte is timequality
            index=index+2+len_t # pkt.load[index] is "0x85" indicating the flag of stNum #
            
            # stNum #
            len_stnum=pkt.load[index+1]
            if len_stnum == 1:
                stNum=pkt.load[index+2]
            if len_stnum == 2:
                stNum=pkt.load[index+2]*16**2+pkt.load[index+3]
            if len_stnum == 3:
                stNum=pkt.load[index+2]*16**4+pkt.load[index+3]*16**2+pkt.load[index+4]
            if len_stnum == 4:
                stNum=pkt.load[index+2]*16**6+pkt.load[index+3]*16**4+pkt.load[index+4]*16**2+pkt.load[index+5]
            if len_stnum == 5:
                stNum=pkt.load[index+2]*16**8+pkt.load[index+3]*16**6+pkt.load[index+4]*16**4+pkt.load[index+5]*16**2+pkt.load[index+6]
            index=index+2+len_stnum # pkt.load[index] is "0x86" indicating the flag of sqNum #
            
            # sqNum #
            len_sqnum=pkt.load[index+1]
            if len_sqnum == 1:
                sqNum=pkt.load[index+2]
            if len_sqnum == 2:
                sqNum=pkt.load[index+2]*16**2+pkt.load[index+3]
            if len_sqnum == 3:
                sqNum=pkt.load[index+2]*16**4+pkt.load[index+3]*16**2+pkt.load[index+4]
            if len_sqnum == 4:
                sqNum=pkt.load[index+2]*16**6+pkt.load[index+3]*16**4+pkt.load[index+4]*16**2+pkt.load[index+5]
            if len_sqnum == 5:
                sqNum=pkt.load[index+2]*16**8+pkt.load[index+3]*16**6+pkt.load[index+4]*16**4+pkt.load[index+5]*16**2+pkt.load[index+6]
            index=index+2+len_sqnum # pkt.load[index] is "0x87" indicating the flag of simulation #
            
            # simulation #
            len_simulation=1
            simulation=bool(pkt.load[index+2])
            index=index+2+len_simulation # pkt.load[index] is "0x88" indicating the flag of confRev #
            
            # confRev #
            len_confRev=pkt.load[index+1]
            if len_confRev == 1:
                confRev=pkt.load[index+2]
            if len_confRev == 2: # in the IEC 61850 standard, the max_len_confRev == 5, here is only usual cases #
                confRev=pkt.load[index+2]*256+pkt.load[index+3]
            index=index+2+len_confRev # pkt.load[index] is "0x89" indicating the flag of ndsCom #
            
            # ndsCom #
            len_ndsCom=1
            ndsCom=bool(pkt.load[index+2])
            index=index+2+len_ndsCom # pkt.load[index] is "0x8a" indicating the flag of numDatSetEntries #
            
            # numDatSetEntries #
            Len_numDatSet=1 # in the IEC 61850 standard, the max_Len_numDatSet == 5, here is only usual cases #
            numofallData=pkt.load[index+2]
            index=index+2+Len_numDatSet # pkt.load[index] is "0xab" or "0xa2" indicating the flag of allData #
            
            # allData #
            index=index+2 # pkt.load[index] is "0x8?" indicating the flag of the first data #
            for x in range(numofallData):
                if hex(pkt.load[index]) == '0x83': # one-byte Boolean #
                    alldata.append(bool(pkt.load[index+2]))
                    index=index+2+1 # pkt.load[index] is "0x8?" indicating the flag of the next data #
                    continue
                if hex(pkt.load[index]) == '0x84': # three-byte bit-string "Quality" #
                    alldata.append((pkt.load[index+3]*256+pkt.load[index+4])>>pkt.load[index+2])
                    index=index+2+3 # pkt.load[index] is "0x8?" indicating the flag of the next data #
                    continue
                if hex(pkt.load[index]) == '0xa2' and hex(pkt.load[index+2]) == '0x83': # structure #
                    alldata.append(bool(pkt.load[index+4])) # append Boolean type "0x83" #
                    index=index+5 #point to the flag of the next data "0x84"
                    alldata.append((pkt.load[index+3]*256+pkt.load[index+4])>>pkt.load[index+2]) # append bit-string "Quality" "0x84" #
                    index=index+5 #point to the flag of the next data "0x91"
                    alldata.append(pkt.load[index+2]*16**6+pkt.load[index+3]*16**4+pkt.load[index+4]*16**2+pkt.load[index+5]) # append utc timestamp "0x91" #
                    index=index+10 #point to the flag of the next data
                    continue
            
            # write into csv #
            traffic.writerow([pkt.time, pkt.src, pkt.dst, APPID, len_GOOSE, gocbRef, TLL, datset, goID, t, stNum, sqNum, simulation, confRev, ndsCom, numofallData, alldata])
            
            # clear #
            gocbRef=datset=goID=""
            alldata=[]

    	
#############		Extract features from SV messages		##############
with open('/media/sf_shared_amongVMs/QUTZS_SV.csv', mode='w') as traffic:
# with open('{}_SV.csv'.format(sys.argv[1]), mode='w') as traffic:
    traffic = csv.writer(traffic, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    
    traffic.writerow(['pkt arrival time', 'MACsrc', 'MACdst', 'APPID', 'SVlength', 'noASDU', 'svID1', 'smpCnt1', 'Data1', 'svID2', 'smpCnt2', 'Data2', 'svID3', 'smpCnt3', 'Data3', 'svID4', 'smpCnt4', 'Data4', 'svID5', 'smpCnt5', 'Data5', 'svID6', 'smpCnt6', 'Data6', 'svID7', 'smpCnt7', 'Data7', 'svID8', 'smpCnt8', 'Data8', 'svID9', 'smpCnt9', 'Data9', 'svID10', 'smpCnt10', 'Data10', 'svID11', 'smpCnt11', 'Data11', 'svID12', 'smpCnt12', 'Data12', 'svID13', 'smpCnt13', 'Data13'])
    tempsvID=""
    len_asdu=[0]*20
    len_svID=[0]*20
    svID=[0]*20
    svCnt=[0]*20
    Data=[0]*20
    start_asdu=0
    
    for pktSV in TemPCAP:
        if hex(raw(pktSV)[16]) == '0x88' and hex(raw(pktSV)[17]) == '0xba':   
            # APPID #
            APPID=hex(pktSV.load[0]*16**2+pktSV.load[1])
        
            # length #
            len_SV=pktSV.load[2]*16**2+pktSV.load[3]
        
            # noASDU #
            noASDU=pktSV.load[14]
            
            # index of the start point of the first ASDU #
            start_asdu=19
            
            # svID1 -- svID(n) #
            for index in range(1,noASDU+1,1):
                len_asdu[index]=pktSV.load[start_asdu+1]
                len_svID[index]=pktSV.load[start_asdu+3]
                for x in range(len_svID[index]):
                    tempsvID+=chr(pktSV.load[start_asdu+4+x])
                svID[index]=tempsvID
                tempsvID=""
                svCnt[index]=pktSV.load[start_asdu+6+len_svID[index]]*16**2 + \
			      pktSV.load[start_asdu+7+len_svID[index]]
			      
                Data[index]=pktSV.load[start_asdu+19+len_svID[index]]*16**6 + \
                	     pktSV.load[start_asdu+20+len_svID[index]]*16**4 + \
                	     pktSV.load[start_asdu+21+len_svID[index]]*16**2 + \
                	     pktSV.load[start_asdu+22+len_svID[index]]
                	     
                start_asdu+=len_asdu[index]+2
    
            traffic.writerow([pktSV.time, pktSV.src, pktSV.dst, APPID, len_SV, noASDU, svID[1], svCnt[1], Data[1], svID[2], svCnt[2], Data[2], svID[3], svCnt[3], Data[3], svID[4], svCnt[4], Data[4], svID[5], svCnt[5], Data[5], svID[6], svCnt[6], Data[6], svID[7], svCnt[7], Data[7], svID[8], svCnt[8], Data[8], svID[9], svCnt[9], Data[9], svID[10], svCnt[10], Data[10], svID[11], svCnt[11], Data[11], svID[12], svCnt[12], Data[12], svID[13], svCnt[13], Data[13] ])
            
            # Reset following values #
            len_asdu=[0]*20
            len_svID=[0]*20
            svID=[0]*20
            svCnt=[0]*20
            Data=[0]*20
    		
