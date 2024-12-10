// ================================================
// Project : UART VIP
// ================================================
// Filename: env_pkg.sv
// Author: Phuc Hung 
// Date: 2-Dec-2021
// ================================================
`ifndef GUARD UART ENV PKG SV 
`define GUARD_UART_ENV_PKG_SV

package env_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;
  
    `include "uart_scoreboard.sv" 
    `include "uart_environment.sv"
  
endpackage: env_pkg

`endif
