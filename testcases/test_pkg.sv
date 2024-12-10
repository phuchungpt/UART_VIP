//=======================================================
// Project: UART VIP
//=======================================================
// Filename: test_pkg.sv
// Author: Phuc Hung
// Date: 2-Dec-2021
//=======================================================
// Description :
//
//
//========================================================
`ifndef GUARD UART TEST PKG SV
`define GUARD_UART_TEST_PKG_SV

package test_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;
  import seq_pkg::*;
  import env_pkg::*;
  
  `include "uart_base_test.sv"
  `include "uart_lhs_baud_4800_test.sv" 
  `include "uart_lhs_baud_9600_test.sv" 
  `include "uart_lhs_baud_19200_test.sv" 
  `include "uart lhs baud 57600 test.sv" 
  `include "uart_lhs_baud_115200_test.sv" 
  `include "uart_lhs_no_parity_test.sv" 
  `include "uart_lhs_odd_parity_test.sv" 
  `include "uart_lhs_even_parity_test.sv" 
  `include "uart_lhs_data_width_5_test.sv" 
  `include "uart_lhs_data_width_6_test.sv"
  `include "uart lhs data width 7 test.sv" 
  `include "uart lhs data width 8 test.sv" 
  `include "uart_lhs_data_width_9_test.sv" 
  `include "uart_lhs_stop_bit_1_test.sv" 
  `include "uart_lhs_stop_bit_2_test.sv" 
  `include "uart_lhs_115200_no_9_test.sv" 
  `include "uart_lhs_4800_odd_8_test.sv" 
  `include "uart_lhs_9600_no_6_test.sv" 
  `include "uart_lhs_19200_even_7_test.sv" 
  `include "uart_rhs_baud_4800_test.sv" 
  `include "uart_rhs_baud_9600_test.sv" 
  `include "uart_rhs_baud_19200_test.sv" 
  `include "uart rhs baud 57600 test.sv" 
  `include "uart_rhs_baud_115200_test.sv" 
  `include "uart_rhs_no_parity_test.sv" 
  `include "uart_rhs_odd_parity_test.sv" 
  `include "uart_rhs_even_parity_test.sv" 
  `include "uart_rhs_data_width_5_test.sv" 
  `include "uart_rhs_data_width_6_test.sv"
  `include "uart_rhs_data_width_7_test.sv" 
  `include "uart_rhs_data_width_8_test.sv" 
  `include "uart_rhs_data_width_9_test.sv" 
  `include "uart_rhs_stop_bit_1_test.sv" 
  `include "uart_rhs_stop_bit_2_test.sv" 
  `include "uart_rhs_115200_no_9_test.sv" 
  `include "uart_rhs_4800_odd_8_test.sv" 
  `include "uart_rhs_9600_no_6_test.sv" 
  `include "uart_rhs_19200_even_7_test.sv" 
  `include "uart_baud_4800_test.sv" 
  `include "uart_baud_9600_test.sv" 
  `include "uart_baud_19200_test.sv" 
  `include "uart_baud_57600 test.sv" 
  `include "uart_baud_115200_test.sv" 
  `include "uart_no_parity_test.sv" 
  `include "uart_odd_parity_test.sv" 
  `include "uart_even_parity_test.sv" 
  `include "uart_data_width_5_test.sv" 
  `include "uart_data_width_6_test.sv"
  `include "uart_data_width_7_test.sv" 
  `include "uart_data_width_8_test.sv" 
  `include "uart_data_width_9_test.sv" 
  `include "uart_stop_bit_1_test.sv" 
  `include "uart_stop_bit_2_test.sv" 
  `include "uart_115200_no_9_test.sv" 
  `include "uart_4800_odd_8_test.sv" 
  `include "uart_9600_no_6_test.sv" 
  `include "uart_19200_even_7_test.sv" 
  `include "uart_different_baud_rate_test"
  `include "uart_different_data_width_test"
  `include "uart_different_parity_bit_test"
  `include "uart_different_stop_bit_test"
endpackage
`endif
