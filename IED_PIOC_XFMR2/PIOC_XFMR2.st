PROGRAM OverCurrent_XFMR2
  VAR
    Short_Circuit_XFMR2 : BOOL;
    Short_Circuit_66BUS2 : BOOL;
  END_VAR
  VAR
    Open_CB2_66KV AT %QX0.0 : BOOL;
    Open_CB3_66KV AT %QX0.1 : BOOL;
    Open_CB_XFMR2 AT %QX0.2 : BOOL;
    Open_CB2_22KV AT %QX0.3 : BOOL;
    Reset_All_CB AT %IX0.0 : BOOL;
    Current_CB2_66KV AT %IW0 : INT;
    Current_CB3_66KV AT %IW1 : INT;
    Current_XFMR2_W1 AT %IW2 : INT;
    Current_XFMR2_W2 AT %IW3 : INT;
    Current_CB_XFMR2 AT %IW4 : INT;
    Current_Fault_on_66BUS2 AT %IW5 : INT;
    Current_Fault_on_XFMR2 AT %IW6 : INT;
  END_VAR
  VAR CONSTANT
    Threshold : INT := 500;
  END_VAR
  VAR
    GT15_OUT : BOOL;
    GT4_OUT : BOOL;
  END_VAR

  Open_CB2_22KV := NOT(NOT(Reset_All_CB) AND NOT(Open_CB2_22KV) AND Open_CB3_66KV AND Open_CB_XFMR2 OR Short_Circuit_66BUS2);
  Open_CB3_66KV := NOT(Reset_All_CB) AND NOT(Open_CB2_22KV) AND Open_CB3_66KV AND Open_CB_XFMR2 OR Short_Circuit_66BUS2;
  GT15_OUT := GT(Current_Fault_on_66BUS2, Threshold);
  Short_Circuit_66BUS2 := GT15_OUT;
  Open_CB_XFMR2 := NOT(Reset_All_CB) AND NOT(Open_CB2_22KV) AND Open_CB3_66KV AND Open_CB_XFMR2 OR Short_Circuit_66BUS2;
  Open_CB2_66KV := TRUE;
  Open_CB2_22KV := NOT(NOT(Reset_All_CB) AND NOT(Open_CB2_22KV) AND Open_CB3_66KV AND Open_CB_XFMR2 OR Short_Circuit_XFMR2);
  Open_CB3_66KV := NOT(Reset_All_CB) AND NOT(Open_CB2_22KV) AND Open_CB3_66KV AND Open_CB_XFMR2 OR Short_Circuit_XFMR2;
  GT4_OUT := GT(Current_Fault_on_XFMR2, Threshold);
  Short_Circuit_XFMR2 := GT4_OUT;
  Open_CB_XFMR2 := NOT(Reset_All_CB) AND NOT(Open_CB2_22KV) AND Open_CB3_66KV AND Open_CB_XFMR2 OR Short_Circuit_XFMR2;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK TaskMain(INTERVAL := T#10ms,PRIORITY := 0);
    PROGRAM Inst0 WITH TaskMain : OverCurrent_XFMR2;
  END_RESOURCE
END_CONFIGURATION
