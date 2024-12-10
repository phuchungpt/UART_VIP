class uart_config extends uvm_object;
  
  int direction = 0; // 0: send, 1: receive, 2: send & receive
  int parity_mode = 0; // 0: no_parity, 1: odd_parity
  int stop_bit = 1 // 1: one_stop_bit, 2: two_stop_bit
  int baud rate = 4800; // 4800, 9600, 19200, 57600, 115200
  int data_width = 5; // 5-8 if parity bit is used, 9 if no parity
  
  `uvm_object_utils_begin (uart_config)
      `uvm_field_int (direction            , UVM NOCOMPARE| UVM_DEC)
      `uvm_field_int (parity_mode          , UVM_ALL_ON | UVM_DEC)
      `uvm_field_int (stop_bit             , UVM_ALL_ON | UVM_DEC)
      `uvm_field_int (baud_rate            , UVM_ALL_ON | UVM_DEC)
      `uvm_field_int (data_width,          , UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  function new(string name="uart_config");
    super.new(name);
  endfunction: new
  
endclass: uart_config
