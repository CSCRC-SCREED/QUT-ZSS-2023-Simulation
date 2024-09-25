## Testbed essential scripts

The testbed simulates a small-scale smart zone substation, including the primary plant (physical process), the process bus communication (GOOSE and SV protocols), the protective relays (Intelligent electronic devices or IEDs), the station bus communication (MMS protocol), and the human-machine interface (HMI). Figures 3 and 4 demonstrate the overall architecture and communication design of the simulation testbed.

<img src="PrimaryPlant.jpg" alt="" width="800" height="510" />

*Figure 2. The primary plant simulation in MATLAB*

<img src="Testbed design (Station-bus).jpg" alt="" width="800" height="553" />

*Figure 3. Architecture and communication design of the simulation testbed (station bus part)*

<img src="Testbed design (Process-bus).jpg" alt="" width="800" height="553" />

*Figure 4. Architecture and communication design of the simulation testbed (process bus part)*

The testbed simulates both the primary plant and secondary plant of an electricity distribution substation, especially the physical distribution process and the process bus communications based on the IEC 61850 standard. The testbed runs on an Oracle VirtualBox with five virtual machines (VMs). One VM simulates a small-scale primary plant of a distribution substation using [**MATLAB/Simulink**](https://www.mathworks.com/products/simulink). The other three VMs represent three instantaneous-overcurrent-protection relays using [**OpenPLC**](https://www.openplcproject.com). Communication interfaces among each VM, such as GOOSE and SV messages between IEDs and the primary plant, are written in C++ based on an open-source library - [**libiec61850**](http://libiec61850.com). The last VM simulates the process bus network switch.

**Each folder/directory contains various essential scripts for one particular Virtual Machine. These include:**
- Primary plant: the physical process
- IED_PIOC_XFMR1: the overcurrent protection IED/relays for transformer1
- IED_PIOC_XFMR2: the overcurrent protection IED/relays for transformer2
- IED_PIOC_FDR: the overcurrent protection IED/relays for feeders
- IED_HMI: the human-machine interface for controlling IEDs
- Network Switch IDS: the network switch for data analysis and intrusion detection purpose

> Port summary.xlsx: indicates all the UDP port numbers for communication between Simulink and OpenPLC

> **Sincerely thanks [Thiago Alves](https://github.com/thiagoralves) for helping me solve issues regarding OpenPLC_Simulink-Interface.**
