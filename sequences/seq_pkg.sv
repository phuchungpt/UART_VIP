//====================================
// Project     : UART VIP
//====================================
// Filename    : seq_pkg.sv 
// Author      : Phuc Hung
// Date        : 2-Dec-2024
//====================================
// Description :
//
//
//====================================

`ifndef GUARD_UART_SEQ_PKG_SV
`define GUARD_UART_SEQ_PKG_SV

package seq_pkg;
   import uvm_pkg::*;
   import uart_pkg::*;

   `include "uart_lhs_trans_sequence.sv" 
   `include "uart_rhs_trans_sequence.sv" 
   `include "uart_trans_sequence.sv"

endpackage: seq_pkg

`endif
