class uart_trans_sequence extends uvm_sequence #(uart_transaction);
  `uvm_object_utils(uart_trans_sequence)

  uvm_event done_event;

  function new(string name="uart_trans_sequence");
    super.new(name);
  endfunction

  virtual task pre_body();
    if(!uvm_config_db# (uvm_event)::get(null,"*", "done_event", done_event))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get done_event from uvm_config_db!"))
  endtask

  virtual task body();
    for(int i=0;i<2;i=i+2) begin
      // Write LEFT, read RIGHT
      req = uart_transaction::type_id::create("req");
      start_item(req);
      if (req.randomize()) begin
        `uvm_info(get_type_name(), $sformatf("Send req to driver: \n %s", req.sprint()),UVM_HIGH);
      end
      else begin
        `uvm_fatal (get_type_name(), "Randomize failure!");
      end
      finish_item(req);
      get_response(rsp);
      done_event.wait_trigger();
    end
  endtask
endclass
