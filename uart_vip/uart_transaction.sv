class uart_transaction extends uvm sequence_item;

  rand bit [8:0] send_data;
  bit      [8:0] receive_data;
  bit            parity_bit;

  `uvm_object_utils_begin (uart_transaction)
    `uvm_field_int (send_data            , UVM_ALL_ON |UVM_BIN)
    `uvm_field_int (receive_data         , UVM_ALL_ON |UVM_BIN)
    `uvm_field_int (parity_bit           , UVM_ALL_ON |UVM_BIN)
  `uvm_object_utils_end

  function new(string name="uart_transaction");
    super.new(name);
  endfunction: new

endclass: uart_transaction
