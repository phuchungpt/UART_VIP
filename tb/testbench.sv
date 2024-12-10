module testbench; 
  import uvm_pkg::*; 
  import test_pkg::*;

/** Instantiate UART Interface */ 
uart_if lhs_if();
uart_if rhs_if();

/** Interconnect */
uart_dut dut(.tx_lhs(lhs_if.rx),
             .rx_lhs(lhs_if.tx), 
             .tx_rhs (rhs_if.rx), 
             .rx_rhs(rhs_if.tx)
            );

initial begin
  lhs_if.tx = 1;
  rhs_if.tx = 1;
end

/** Set the VIP interface on the environment */
initial begin
    uvm_config_db#(virtual uart_if)::set(uvm_root::get(), "uvm_test_top", "lhs_if", lhs_if); 
    uvm_config_db# (virtual uart_if)::set(uvm_root::get(), "uvm_test_top","rhs_if", rhs_if);

    /** Start the UVM test */
    run_test();
  end
endmodule
