  class uart_agent extends uvm_agent; 
  `uvm_component_utils (uart_agent)
  
  virtual uart_if lhs_if; 
  virtual uart_if rhs_if;
  
  uart_config uart_lhs_cfg;
  uart_config uart_rhs_cfg;
  
  uart_monitor monitor;
  uart_driver  driver
  uart_sequencer sequencer;
  
  function new(string name="uart_agent", uvm_component parent); 
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if(!uvm_config_db# (virtual uart_if)::get(this,"","lhs_if",lhs_if))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get lhs_if from uvm_config_db!"))
      
    if(!uvm_config_db# (virtual uart_if)::get(this,"","rhs_if", rhs_if))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get rhs_if from uvm_config_db!"))
      
    if(is_active == UVM_ACTIVE) begin
      `uvm_info(get_type_name(), $sformatf("Active agent is configued"), UVM_LOW) 
      
      driver = uart_driver::type_id::create("driver", this);
      sequencer = uart_sequencer::type_id::create("sequecer", this); 
      monitor = uart_monitor::type_id::create("monitor", this);
      
      uvm_config_db#(virtual uart_if)::set(this, "driver", "lhs_if",lhs_if); uvm_config_db# (virtual uart_if)::set(this, "driver","rhs_if", rhs_if);
      uvm_config_db#(virtual uart_if)::set(this, "monitor","lhs_if",lhs_if); uvm_config_db# (virtual uart_if)::set(this, "monitor","rhs_if", rhs_if);
    end
    else begin
      `uvm_info(get_type_name(), $sformatf("Passive agent is configued"), UVM_LOW) 
      monitor = uart_monitor::type_id::create("monitor", this);
      uvm_config_db#(virtual uart_if)::set(this, "monitor","lhs_if",lhs_if); uvm_config_db# (virtual uart_if)::set(this, "monitor","rhs_if", rhs_if);
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase); 
    super.connect_phase(phase); 
    if(get_is_active() == UVM_ACTIVE) begin 
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction 
endclass
      
