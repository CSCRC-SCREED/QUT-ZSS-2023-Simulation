TYPE
  LOGLEVEL : (CRITICAL, WARNING, INFO, DEBUG) := INFO;
END_TYPE

FUNCTION_BLOCK LOGGER
  VAR_INPUT
    TRIG : BOOL;
    MSG : STRING;
    LEVEL : LOGLEVEL := INFO;
  END_VAR
  VAR
    TRIG0 : BOOL;
  END_VAR

  IF TRIG AND NOT TRIG0 THEN
  {{
   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  }}
  END_IF;
  TRIG0:=TRIG;
END_FUNCTION_BLOCK



FUNCTION_BLOCK python_eval
  VAR_INPUT
    TRIG : BOOL;
    CODE : STRING;
  END_VAR
  VAR_OUTPUT
    ACK : BOOL;
    RESULT : STRING;
  END_VAR
  VAR
    STATE : DWORD;
    BUFFER : STRING;
    PREBUFFER : STRING;
    TRIGM1 : BOOL;
    TRIGGED : BOOL;
  END_VAR

  {extern void __PythonEvalFB(int, PYTHON_EVAL*);__PythonEvalFB(0, data__);}
END_FUNCTION_BLOCK

FUNCTION_BLOCK python_poll
  VAR_INPUT
    TRIG : BOOL;
    CODE : STRING;
  END_VAR
  VAR_OUTPUT
    ACK : BOOL;
    RESULT : STRING;
  END_VAR
  VAR
    STATE : DWORD;
    BUFFER : STRING;
    PREBUFFER : STRING;
    TRIGM1 : BOOL;
    TRIGGED : BOOL;
  END_VAR

  {extern void __PythonEvalFB(int, PYTHON_EVAL*);__PythonEvalFB(1,(PYTHON_EVAL*)(void*)data__);}
END_FUNCTION_BLOCK

FUNCTION_BLOCK python_gear
  VAR_INPUT
    N : UINT;
    TRIG : BOOL;
    CODE : STRING;
  END_VAR
  VAR_OUTPUT
    ACK : BOOL;
    RESULT : STRING;
  END_VAR
  VAR
    py_eval : python_eval;
    COUNTER : UINT;
    ADD10_OUT : UINT;
    EQ13_OUT : BOOL;
    SEL15_OUT : UINT;
    AND7_OUT : BOOL;
  END_VAR

  ADD10_OUT := ADD(COUNTER, 1);
  EQ13_OUT := EQ(N, ADD10_OUT);
  SEL15_OUT := SEL(EQ13_OUT, ADD10_OUT, 0);
  COUNTER := SEL15_OUT;
  AND7_OUT := AND(EQ13_OUT, TRIG);
  py_eval(TRIG := AND7_OUT, CODE := CODE);
  ACK := py_eval.ACK;
  RESULT := py_eval.RESULT;
END_FUNCTION_BLOCK


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
    Open_CB1_22KV : BOOL;
    Open_CB2_22KV : BOOL := TRUE;
    Open_CB3_22KV : BOOL;
    Open_CB_FDR1 : BOOL;
    Open_CB_FDR2 : BOOL;
    Open_CB_FDR3 : BOOL;
    Open_CB_FDR4 : BOOL;
    Reset_All_CB : BOOL;
    Current_22BUS1 : INT;
    Current_22BUS2 : INT;
    Current_22BUS3 : INT;
    Current_FDR1 : INT;
    Current_FDR2 : INT;
    Current_FDR3 : INT;
    Current_FDR4 : INT;
    Fault_on_22BUS1_Current : INT;
    Fault_on_22BUS2_Current : INT;
    Fault_on_FDR1_Current : INT;
    Fault_on_FDR2_Current : INT;
    Fault_on_FDR3_Current : INT;
    Fault_on_FDR4_Current : INT;
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
