//====================================
// Project     : UART VIP
//====================================
// Filename    : uart_pkg.sv 
// Author      : Phuc Hung
// Date        : 2-Dec-2024
//====================================
// Description :
//
//
//====================================

`ifndef GUARD_UART_PKG_SV
`define GUARD_UART_PKG_SV

package uart_pkg;
   import uvm_pkg::*;
  
   `include "uart_error_catcher.sv" 
   `include "uart_config.sv" 
   `include "uart_define.sv"
   `include "uart_transaction.sv"
   `include "uart_sequencer.sv"
   `include "uart_driver.sv"
   `include "uart_monitor.sv"
   `include "uart_agent.sv"

endpackage: uart_pkg

`endif
