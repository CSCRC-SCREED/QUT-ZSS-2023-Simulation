PROGRAM OverCurrent_FDR
  VAR
    Short_Circuit_FDR1 : BOOL;
    Short_Circuit_FDR2 : BOOL;
    Short_Circuit_FDR3 : BOOL;
    Short_Circuit_FDR4 : BOOL;
    Short_Circuit_22BUS1 : BOOL;
    Short_Circuit_22BUS2 : BOOL;
  END_VAR
  VAR
    Open_CB1_22KV AT %QX0.0 : BOOL;
    Open_CB2_22KV AT %QX0.1 : BOOL := TRUE;
    Open_CB3_22KV AT %QX0.2 : BOOL;
    Open_CB_FDR1 AT %QX0.3 : BOOL;
    Open_CB_FDR2 AT %QX0.4 : BOOL;
    Open_CB_FDR3 AT %QX0.5 : BOOL;
    Open_CB_FDR4 AT %QX0.6 : BOOL;
    Reset_All_CB AT %IX0.0 : BOOL;
    Current_22BUS1 AT %IW0 : INT;
    Current_22BUS2 AT %IW1 : INT;
    Current_22BUS3 AT %IW2 : INT;
    Current_FDR1 AT %IW3 : INT;
    Current_FDR2 AT %IW4 : INT;
    Current_FDR3 AT %IW5 : INT;
    Current_FDR4 AT %IW6 : INT;
    Fault_on_22BUS1_Current AT %IW7 : INT;
    Fault_on_22BUS2_Current AT %IW8 : INT;
    Fault_on_FDR1_Current AT %IW9 : INT;
    Fault_on_FDR2_Current AT %IW10 : INT;
    Fault_on_FDR3_Current AT %IW11 : INT;
    Fault_on_FDR4_Current AT %IW12 : INT;
  END_VAR
  VAR CONSTANT
    Threshold : INT := 500;
  END_VAR
  VAR
    GT10_OUT : BOOL;
    GT4_OUT : BOOL;
    GT15_OUT : BOOL;
    GT20_OUT : BOOL;
    GT47_OUT : BOOL;
    GT51_OUT : BOOL;
  END_VAR

  Open_CB1_22KV := NOT(Reset_All_CB) AND Open_CB1_22KV OR Short_Circuit_22BUS1;
  GT10_OUT := GT(Fault_on_22BUS1_Current, Threshold);
  Short_Circuit_22BUS1 := GT10_OUT;
  Open_CB3_22KV := NOT(Reset_All_CB) AND Open_CB3_22KV OR Short_Circuit_22BUS2;
  GT4_OUT := GT(Fault_on_22BUS2_Current, Threshold);
  Short_Circuit_22BUS2 := GT4_OUT;
  Open_CB_FDR1 := NOT(Reset_All_CB) AND Open_CB_FDR1 OR Short_Circuit_FDR1;
  GT15_OUT := GT(Fault_on_FDR1_Current, Threshold);
  Short_Circuit_FDR1 := GT15_OUT;
  Open_CB_FDR2 := NOT(Reset_All_CB) AND Open_CB_FDR2 OR Short_Circuit_FDR2;
  GT20_OUT := GT(Fault_on_FDR2_Current, Threshold);
  Short_Circuit_FDR2 := GT20_OUT;
  Open_CB_FDR3 := NOT(Reset_All_CB) AND Open_CB_FDR3 OR Short_Circuit_FDR3;
  GT47_OUT := GT(Fault_on_FDR3_Current, Threshold);
  Short_Circuit_FDR3 := GT47_OUT;
  Open_CB_FDR4 := NOT(Reset_All_CB) AND Open_CB_FDR4 OR Short_Circuit_FDR4;
  GT51_OUT := GT(Fault_on_FDR4_Current, Threshold);
  Short_Circuit_FDR4 := GT51_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK TaskMain(INTERVAL := T#10ms,PRIORITY := 0);
    PROGRAM Inst0 WITH TaskMain : OverCurrent_FDR;
  END_RESOURCE
END_CONFIGURATION
