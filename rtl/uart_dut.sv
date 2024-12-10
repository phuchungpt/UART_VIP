module uart_dut(rx_lhs,
                tx_lhs,
                rx_rhs,
                tx_rhs,
               );
  output wire tx_lhs;
  input  wire rx_lhs;

  output wire tx_rhs;
  input  wire rx_rhs; 

  // Pass through assignment 
  assign tx_lhs = rx_rhs;
  assign tx_rhs = rx_lhs;

endmodule
