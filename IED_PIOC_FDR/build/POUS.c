void LOGGER_init__(LOGGER *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MSG,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->LEVEL,LOGLEVEL__INFO,retain)
  __INIT_VAR(data__->TRIG0,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void LOGGER_body__(LOGGER *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  if ((__GET_VAR(data__->TRIG,) && !(__GET_VAR(data__->TRIG0,)))) {
    #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
    #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)

   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  
    #undef GetFbVar
    #undef SetFbVar
;
  };
  __SET_VAR(data__->,TRIG0,,__GET_VAR(data__->TRIG,));

  goto __end;

__end:
  return;
} // LOGGER_body__() 





void PYTHON_EVAL_init__(PYTHON_EVAL *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CODE,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->ACK,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESULT,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->STATE,0,retain)
  __INIT_VAR(data__->BUFFER,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->PREBUFFER,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->TRIGM1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->TRIGGED,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void PYTHON_EVAL_body__(PYTHON_EVAL *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
  #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)
extern void __PythonEvalFB(int, PYTHON_EVAL*);__PythonEvalFB(0, data__);
  #undef GetFbVar
  #undef SetFbVar
;

  goto __end;

__end:
  return;
} // PYTHON_EVAL_body__() 





void PYTHON_POLL_init__(PYTHON_POLL *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CODE,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->ACK,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESULT,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->STATE,0,retain)
  __INIT_VAR(data__->BUFFER,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->PREBUFFER,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->TRIGM1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->TRIGGED,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void PYTHON_POLL_body__(PYTHON_POLL *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
  #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)
extern void __PythonEvalFB(int, PYTHON_EVAL*);__PythonEvalFB(1,(PYTHON_EVAL*)(void*)data__);
  #undef GetFbVar
  #undef SetFbVar
;

  goto __end;

__end:
  return;
} // PYTHON_POLL_body__() 





void PYTHON_GEAR_init__(PYTHON_GEAR *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->N,0,retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CODE,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->ACK,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESULT,__STRING_LITERAL(0,""),retain)
  PYTHON_EVAL_init__(&data__->PY_EVAL,retain);
  __INIT_VAR(data__->COUNTER,0,retain)
  __INIT_VAR(data__->ADD10_OUT,0,retain)
  __INIT_VAR(data__->EQ13_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->SEL15_OUT,0,retain)
  __INIT_VAR(data__->AND7_OUT,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void PYTHON_GEAR_body__(PYTHON_GEAR *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  __SET_VAR(data__->,ADD10_OUT,,ADD__UINT__UINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (UINT)__GET_VAR(data__->COUNTER,),
    (UINT)1));
  __SET_VAR(data__->,EQ13_OUT,,EQ__BOOL__UINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (UINT)__GET_VAR(data__->N,),
    (UINT)__GET_VAR(data__->ADD10_OUT,)));
  __SET_VAR(data__->,SEL15_OUT,,SEL__UINT__BOOL__UINT__UINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (BOOL)__GET_VAR(data__->EQ13_OUT,),
    (UINT)__GET_VAR(data__->ADD10_OUT,),
    (UINT)0));
  __SET_VAR(data__->,COUNTER,,__GET_VAR(data__->SEL15_OUT,));
  __SET_VAR(data__->,AND7_OUT,,AND__BOOL__BOOL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (BOOL)__GET_VAR(data__->EQ13_OUT,),
    (BOOL)__GET_VAR(data__->TRIG,)));
  __SET_VAR(data__->PY_EVAL.,TRIG,,__GET_VAR(data__->AND7_OUT,));
  __SET_VAR(data__->PY_EVAL.,CODE,,__GET_VAR(data__->CODE,));
  PYTHON_EVAL_body__(&data__->PY_EVAL);
  __SET_VAR(data__->,ACK,,__GET_VAR(data__->PY_EVAL.ACK,));
  __SET_VAR(data__->,RESULT,,__GET_VAR(data__->PY_EVAL.RESULT,));

  goto __end;

__end:
  return;
} // PYTHON_GEAR_body__() 





void OVERCURRENT_FDR_init__(OVERCURRENT_FDR *data__, BOOL retain) {
  __INIT_VAR(data__->SHORT_CIRCUIT_FDR1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->SHORT_CIRCUIT_FDR2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->SHORT_CIRCUIT_FDR3,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->SHORT_CIRCUIT_FDR4,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->SHORT_CIRCUIT_22BUS1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->SHORT_CIRCUIT_22BUS2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OPEN_CB1_22KV,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OPEN_CB2_22KV,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->OPEN_CB3_22KV,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OPEN_CB_FDR1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OPEN_CB_FDR2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OPEN_CB_FDR3,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OPEN_CB_FDR4,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESET_ALL_CB,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CURRENT_22BUS1,0,retain)
  __INIT_VAR(data__->CURRENT_22BUS2,0,retain)
  __INIT_VAR(data__->CURRENT_22BUS3,0,retain)
  __INIT_VAR(data__->CURRENT_FDR1,0,retain)
  __INIT_VAR(data__->CURRENT_FDR2,0,retain)
  __INIT_VAR(data__->CURRENT_FDR3,0,retain)
  __INIT_VAR(data__->CURRENT_FDR4,0,retain)
  __INIT_VAR(data__->FAULT_ON_22BUS1_CURRENT,0,retain)
  __INIT_VAR(data__->FAULT_ON_22BUS2_CURRENT,0,retain)
  __INIT_VAR(data__->FAULT_ON_FDR1_CURRENT,0,retain)
  __INIT_VAR(data__->FAULT_ON_FDR2_CURRENT,0,retain)
  __INIT_VAR(data__->FAULT_ON_FDR3_CURRENT,0,retain)
  __INIT_VAR(data__->FAULT_ON_FDR4_CURRENT,0,retain)
  __INIT_VAR(data__->THRESHOLD,500,retain)
  __INIT_VAR(data__->GT10_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->GT4_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->GT15_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->GT20_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->GT47_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->GT51_OUT,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void OVERCURRENT_FDR_body__(OVERCURRENT_FDR *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->,OPEN_CB1_22KV,,((!(__GET_VAR(data__->RESET_ALL_CB,)) && __GET_VAR(data__->OPEN_CB1_22KV,)) || __GET_VAR(data__->SHORT_CIRCUIT_22BUS1,)));
  __SET_VAR(data__->,GT10_OUT,,GT__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->FAULT_ON_22BUS1_CURRENT,),
    (INT)__GET_VAR(data__->THRESHOLD,)));
  __SET_VAR(data__->,SHORT_CIRCUIT_22BUS1,,__GET_VAR(data__->GT10_OUT,));
  __SET_VAR(data__->,OPEN_CB3_22KV,,((!(__GET_VAR(data__->RESET_ALL_CB,)) && __GET_VAR(data__->OPEN_CB3_22KV,)) || __GET_VAR(data__->SHORT_CIRCUIT_22BUS2,)));
  __SET_VAR(data__->,GT4_OUT,,GT__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->FAULT_ON_22BUS2_CURRENT,),
    (INT)__GET_VAR(data__->THRESHOLD,)));
  __SET_VAR(data__->,SHORT_CIRCUIT_22BUS2,,__GET_VAR(data__->GT4_OUT,));
  __SET_VAR(data__->,OPEN_CB_FDR1,,((!(__GET_VAR(data__->RESET_ALL_CB,)) && __GET_VAR(data__->OPEN_CB_FDR1,)) || __GET_VAR(data__->SHORT_CIRCUIT_FDR1,)));
  __SET_VAR(data__->,GT15_OUT,,GT__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->FAULT_ON_FDR1_CURRENT,),
    (INT)__GET_VAR(data__->THRESHOLD,)));
  __SET_VAR(data__->,SHORT_CIRCUIT_FDR1,,__GET_VAR(data__->GT15_OUT,));
  __SET_VAR(data__->,OPEN_CB_FDR2,,((!(__GET_VAR(data__->RESET_ALL_CB,)) && __GET_VAR(data__->OPEN_CB_FDR2,)) || __GET_VAR(data__->SHORT_CIRCUIT_FDR2,)));
  __SET_VAR(data__->,GT20_OUT,,GT__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->FAULT_ON_FDR2_CURRENT,),
    (INT)__GET_VAR(data__->THRESHOLD,)));
  __SET_VAR(data__->,SHORT_CIRCUIT_FDR2,,__GET_VAR(data__->GT20_OUT,));
  __SET_VAR(data__->,OPEN_CB_FDR3,,((!(__GET_VAR(data__->RESET_ALL_CB,)) && __GET_VAR(data__->OPEN_CB_FDR3,)) || __GET_VAR(data__->SHORT_CIRCUIT_FDR3,)));
  __SET_VAR(data__->,GT47_OUT,,GT__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->FAULT_ON_FDR3_CURRENT,),
    (INT)__GET_VAR(data__->THRESHOLD,)));
  __SET_VAR(data__->,SHORT_CIRCUIT_FDR3,,__GET_VAR(data__->GT47_OUT,));
  __SET_VAR(data__->,OPEN_CB_FDR4,,((!(__GET_VAR(data__->RESET_ALL_CB,)) && __GET_VAR(data__->OPEN_CB_FDR4,)) || __GET_VAR(data__->SHORT_CIRCUIT_FDR4,)));
  __SET_VAR(data__->,GT51_OUT,,GT__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->FAULT_ON_FDR4_CURRENT,),
    (INT)__GET_VAR(data__->THRESHOLD,)));
  __SET_VAR(data__->,SHORT_CIRCUIT_FDR4,,__GET_VAR(data__->GT51_OUT,));

  goto __end;

__end:
  return;
} // OVERCURRENT_FDR_body__() 





