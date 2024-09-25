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


PROGRAM OverCurrent_XFMR2
  VAR
    Short_Circuit_XFMR2 : BOOL;
    Short_Circuit_66BUS2 : BOOL;
  END_VAR
  VAR
    Open_CB2_66KV : BOOL;
    Open_CB3_66KV : BOOL;
    Open_CB_XFMR2 : BOOL;
    Open_CB2_22KV : BOOL;
    Reset_All_CB : BOOL;
    Current_CB2_66KV : INT;
    Current_CB3_66KV : INT;
    Current_XFMR2_W1 : INT;
    Current_XFMR2_W2 : INT;
    Current_CB_XFMR2 : INT;
    Current_Fault_on_66BUS2 : INT;
    Current_Fault_on_XFMR2 : INT;
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
