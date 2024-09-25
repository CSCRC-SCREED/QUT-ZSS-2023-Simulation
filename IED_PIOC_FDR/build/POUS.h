#include "beremiz.h"
#ifndef __POUS_H
#define __POUS_H

#include "accessor.h"
#include "iec_std_lib.h"

__DECLARE_ENUMERATED_TYPE(LOGLEVEL,
  LOGLEVEL__CRITICAL,
  LOGLEVEL__WARNING,
  LOGLEVEL__INFO,
  LOGLEVEL__DEBUG
)
// FUNCTION_BLOCK LOGGER
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,TRIG)
  __DECLARE_VAR(STRING,MSG)
  __DECLARE_VAR(LOGLEVEL,LEVEL)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,TRIG0)

} LOGGER;

void LOGGER_init__(LOGGER *data__, BOOL retain);
// Code part
void LOGGER_body__(LOGGER *data__);
// FUNCTION_BLOCK PYTHON_EVAL
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,TRIG)
  __DECLARE_VAR(STRING,CODE)
  __DECLARE_VAR(BOOL,ACK)
  __DECLARE_VAR(STRING,RESULT)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(DWORD,STATE)
  __DECLARE_VAR(STRING,BUFFER)
  __DECLARE_VAR(STRING,PREBUFFER)
  __DECLARE_VAR(BOOL,TRIGM1)
  __DECLARE_VAR(BOOL,TRIGGED)

} PYTHON_EVAL;

void PYTHON_EVAL_init__(PYTHON_EVAL *data__, BOOL retain);
// Code part
void PYTHON_EVAL_body__(PYTHON_EVAL *data__);
// FUNCTION_BLOCK PYTHON_POLL
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,TRIG)
  __DECLARE_VAR(STRING,CODE)
  __DECLARE_VAR(BOOL,ACK)
  __DECLARE_VAR(STRING,RESULT)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(DWORD,STATE)
  __DECLARE_VAR(STRING,BUFFER)
  __DECLARE_VAR(STRING,PREBUFFER)
  __DECLARE_VAR(BOOL,TRIGM1)
  __DECLARE_VAR(BOOL,TRIGGED)

} PYTHON_POLL;

void PYTHON_POLL_init__(PYTHON_POLL *data__, BOOL retain);
// Code part
void PYTHON_POLL_body__(PYTHON_POLL *data__);
// FUNCTION_BLOCK PYTHON_GEAR
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(UINT,N)
  __DECLARE_VAR(BOOL,TRIG)
  __DECLARE_VAR(STRING,CODE)
  __DECLARE_VAR(BOOL,ACK)
  __DECLARE_VAR(STRING,RESULT)

  // FB private variables - TEMP, private and located variables
  PYTHON_EVAL PY_EVAL;
  __DECLARE_VAR(UINT,COUNTER)
  __DECLARE_VAR(UINT,ADD10_OUT)
  __DECLARE_VAR(BOOL,EQ13_OUT)
  __DECLARE_VAR(UINT,SEL15_OUT)
  __DECLARE_VAR(BOOL,AND7_OUT)

} PYTHON_GEAR;

void PYTHON_GEAR_init__(PYTHON_GEAR *data__, BOOL retain);
// Code part
void PYTHON_GEAR_body__(PYTHON_GEAR *data__);
// PROGRAM OVERCURRENT_FDR
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,SHORT_CIRCUIT_FDR1)
  __DECLARE_VAR(BOOL,SHORT_CIRCUIT_FDR2)
  __DECLARE_VAR(BOOL,SHORT_CIRCUIT_FDR3)
  __DECLARE_VAR(BOOL,SHORT_CIRCUIT_FDR4)
  __DECLARE_VAR(BOOL,SHORT_CIRCUIT_22BUS1)
  __DECLARE_VAR(BOOL,SHORT_CIRCUIT_22BUS2)
  __DECLARE_VAR(BOOL,OPEN_CB1_22KV)
  __DECLARE_VAR(BOOL,OPEN_CB2_22KV)
  __DECLARE_VAR(BOOL,OPEN_CB3_22KV)
  __DECLARE_VAR(BOOL,OPEN_CB_FDR1)
  __DECLARE_VAR(BOOL,OPEN_CB_FDR2)
  __DECLARE_VAR(BOOL,OPEN_CB_FDR3)
  __DECLARE_VAR(BOOL,OPEN_CB_FDR4)
  __DECLARE_VAR(BOOL,RESET_ALL_CB)
  __DECLARE_VAR(INT,CURRENT_22BUS1)
  __DECLARE_VAR(INT,CURRENT_22BUS2)
  __DECLARE_VAR(INT,CURRENT_22BUS3)
  __DECLARE_VAR(INT,CURRENT_FDR1)
  __DECLARE_VAR(INT,CURRENT_FDR2)
  __DECLARE_VAR(INT,CURRENT_FDR3)
  __DECLARE_VAR(INT,CURRENT_FDR4)
  __DECLARE_VAR(INT,FAULT_ON_22BUS1_CURRENT)
  __DECLARE_VAR(INT,FAULT_ON_22BUS2_CURRENT)
  __DECLARE_VAR(INT,FAULT_ON_FDR1_CURRENT)
  __DECLARE_VAR(INT,FAULT_ON_FDR2_CURRENT)
  __DECLARE_VAR(INT,FAULT_ON_FDR3_CURRENT)
  __DECLARE_VAR(INT,FAULT_ON_FDR4_CURRENT)
  __DECLARE_VAR(INT,THRESHOLD)
  __DECLARE_VAR(BOOL,GT10_OUT)
  __DECLARE_VAR(BOOL,GT4_OUT)
  __DECLARE_VAR(BOOL,GT15_OUT)
  __DECLARE_VAR(BOOL,GT20_OUT)
  __DECLARE_VAR(BOOL,GT47_OUT)
  __DECLARE_VAR(BOOL,GT51_OUT)

} OVERCURRENT_FDR;

void OVERCURRENT_FDR_init__(OVERCURRENT_FDR *data__, BOOL retain);
// Code part
void OVERCURRENT_FDR_body__(OVERCURRENT_FDR *data__);
#endif //__POUS_H
