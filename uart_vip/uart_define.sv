// ==================================================
// project : uart vip
// ==================================================
// fiLename : uart_define.sv
// author   : phuchung
// emaiL    : phuchung12tn4@gmai.com
// date     : 6-dec-2024
// ==================================================
// description : define can override by environment
//
// =================================================

`ifndef quard uart define_ sv
`define quard_uart define_ sv

  `ifndef fork_quard_begin
    `define fork_quard_begin fork begin
  `endif
    
  `ifndef fork_quard_end
    `define fork_quard_end fork end
  `endif
`endif
