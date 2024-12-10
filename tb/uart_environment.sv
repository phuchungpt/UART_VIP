class uart_environment extends uvm_env;
  `uvm_component_utils(uart_environment)
  
  virtual uart_if lhs_if; 
  virtual uart_if rhs_if;
  
  uart_config uart_lhs_cfg; 
  uart_config uart_rhs_cfg;
  
  uart_scoreboard uart_sb;
  uart_agent      uart_lhs_agt;
  uart_agent      uart_rhs_agt;

  function new(string name="uart_environment", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
   `uvm_info("build_phase", "Entered...", UVM_HIGH)
    
    if(!uvm_config_db# (virtual uart_if)::get(this,"","lhs_if", lhs_if))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get lhs if from uvm_config_db"))
      
    if(!uvm_config_db# (virtual uart_if)::get(this,"","rhs_if", rhs_if))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get rhs_if from uvm_config_db"))
      
    uart_sb = uart_scoreboard::type_id::create("uart_sb", this);
    uart_lhs_agt = uart_agent::type_id::create("uart_lhs_agt", this); 
    uart_rhs_agt = uart_agent::type_id::create("uart_rhs_agt", this);
    
    uvm_config_db#(virtual uart_if)::set(this, "uart_lhs_agt","lhs_if",lhs_if); 
    uvm_config_db#(virtual uart_if)::set(this, "uart_rhs_agt","rhs_if",rhs_if);
    uvm_config_db#(virtual uart_if)::set(this, "uart_lhs_agt","rhs_if", hs_if); 
    uvm_config_db# virtual uart_if)::set(this, "uart_rhs_agt","lhs_if",lhs_if);
    
    uvm_config_db#(virtual uart_if)::set(this, "uart_sb","lhs_if", lhs_if); 
    uvm_config_db#(virtual uart_if)::set(this, "uart_sb","rhs_if", rhs_if);
    
    `uvm_info("build_phase", "Exiting...", UVM_HIGH)
  endfunction: build_phase
  
  virtual function void connect_phase (uvm_phase phase); 
    super.connect_phase(phase);
    `uvm_info("connect_phase", "Entered...", UVM_HIGH)
    
    uart_lhs_agt.monitor.item_observed port.connect(uart_sb.item_collected_export);
    uart_rhs_agt.monitor.item_observed_port.connect(uart_sb.item_collected_export);
    
    `uvm_info("connect_phase", "Exiting...", UVM_HIGH)
  endfunction: connect_phase
  
endclass: uart_environment
