class uart_stop_bit_2_test extends uart_base_test; 
  `uvm_component_utils (uart_stop_bit_2_test)
  
  uart_trans_sequence lhs_seq; 
  uart_trans_sequence rhs_seq;
  
  function new(string name="uart_stop_bit_2_test", uvm_component parent);
    super.new(name, parent);
    super.set_lhs_baud_rate (4800);
    super.set_lhs_parity_mode(1);
    super.set_lhs_data_width(6);
    super.set_lhs_stop_bit(2);
    super.set_rhs_baud_rate (4800);
    super.set_rhs_parity_mode(1);
    super.set_rhs_data_width(6);
    super.set_rhs_stop_bit(2);
    super.set_lhs_directory(2);
    super.set_rhs_directory(2);
    uvm_config_db#(int)::set(null,"*","rhs_parity_mode", rhs_parity_mode); 
    uvm_config_db# (int)::set(null,"*","rhs_data_width", rhs_data_width); 
  endfunction
  
  virtual task run_phase (uvm_phase phase); 
    phase.raise_objection(this);
    
    lhs_seq= uart_lhs_trans_sequence::type_id::create("lhs_seq"); 
    rhs_seq= uart_lhs_trans_sequence::type_id::create("rhs_seq");
    lhs_seq.start(uart_env.uart_lhs_agt.sequencer);
    rhs_seq.start(uart_env.uart_rhs_agt.sequencer);
      
    phase.drop_objection(this);
  endtask
endclass: uart_stop_bit_2_test
