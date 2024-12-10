class uart_base_test extends uvm_test; 
  `uvm_component_utils (uart_base_test);
  virtual uart_if lhs_if; 
  virtual uart_if rhs_if;
  
  uart_config uart_lhs_cfg;
  uart_config uart_rhs_cfg; 
  uart_environment uart_env; 
  uart_error_catcher err_catcher;
  
  time usr_timeout=1s;
  int lhs_direction = 0;
  int lhs_baud_rate = 115200;
  int lhs_data_width = 8;
  int lhs_stop_bit = 1; 
  int lhs_parity_mode = 1;
  
  int rhs_direction = 1 ;
  int rhs_baud_rate = 115200; 
  int rhs_data_width = 8
  int rhs_stop_bit = 1; 
  int rhs_parity_mode = 1;
  
  virtual function void set_lhs_direction(int lhs_direction); 
    this.lhs_direction = lhs_direction;
  endfunction: set_lhs_direction
  
  virtual function void set_rhs_direction(int rhs_direction); 
    this.rhs_direction = rhs_direction;
  endfunction: set_rhs_direction
  
  virtual function void set_lhs_baud_rate(int lhs_baud rate); 
    this.lhs_baud rate = lhs_baud_rate;
  endfunction: set_lhs_baud_rate
    
  virtual function void set_lhs_data_width (int lhs_data_width); 
    this.lhs_data_width = lhs_data_width;
  endfunction: set_lhs_data_width
    
  virtual function void set_lhs_stop_bit(int lhs_stop_bit); 
    this.lhs_stop_bit = lhs_stop_bit;
  endfunction: set_lhs_stop_bit
  
  virtual function void set_lhs_parity_mode (int lhs_parity_mode); 
    this.lhs_parity_mode = lhs_parity_mode;
  end function: set_lhs_parity_mode

  virtual function void set_rhs_baud_rate(int rhs_baud_rate); 
    this.rhs_baud rate = rhs_baud_rate;
  endfunction: set_rhs_baud_rate
    
  virtual function void set_rhs_data_width (int rhs_data_width); 
    this.rhs_data_width = rhs_data_width;
  endfunction: set_rhs_data_width
    
  virtual function void set_rhs_stop_bit(int rhs_stop_bit); 
    this.rhs_stop_bit = rhs_stop_bit;
  endfunction: set_rhs_stop_bit
    
  virtual function void set_rhs_parity_mode(int rhs_parity_mode); 
    this.rhs_parity_mode = rhs_parity_mode; 
  endfunction: set_rhs_parity_mode
    
  function new(string name="uart_base_test", uvm_component parent); 
    super.new(name, parent);
  endfunction: new
    
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase", "Entered...", UVM_HIGH)
    if(!uvm_config_db# (virtual uart_if)::get(this,"","lhs_if",lhs_if))
      uvm_fatal (get_type_name(), $sformatf("Fail to get lhs_if from uvm_config_db"))
      
    if(!uvm_config_db# (virtual uart_if)::get(this," ‚"","rhs_if", rhs_if))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get rhs_if from uvm_config_db!"))
                                              
    uart_lhs_cfg = uart_config::type_id::create("uart_lhs_cfg", this); 
    uart_rhs_cfg = uart_config::type_id::create("uart_rhs_cfg", this); 
    uart_env = uart_environment::type_id::create("uart_env", this);
                                              
    err_catcher = uart_error_catcher::type_id::create("err_catcher");
    uvm_report_cb::add(null,err_catcher);
                                              
    uart_lhs_cfg.direction = lhs_direction;
    uart_lhs_cfg.baud_rate = lhs_baud_rate;
    uart_lhs_cfg.data_width = lhs_data_width; 
    uart_lhs_cfg.stop_bit = lhs_stop_bit;
    uart_lhs_cfg.parity_mode = lhs_parity_mode;

    uart_rhs_cfg.direction = rhs_direction;
    uart_rhs_cfg.baud_rate = rhs_baud_rate;
    uart_rhs_cfg.data_width = rhs_data_width; 
    uart_rhs_cfg.stop_bit = rhs_stop_bit;
    uart_rhs_cfg.parity_mode = rhs_parity_mode; 
    
    uvm_config_db#(virtual uart_if)::set(this, "uart_env", "lhs_if",lhs_if); 
    uvm_config_db#(virtual uart_if)::set(this, "uart_env","rhs_if", rhs_if); 
    uvm_config_db#(uart_config)::set(null,"*", "uart_lhs_cfg", uart_lhs_cfg); 
    uvm_config_db#(uart_config)::set(null,"*", "uart_rhs_cfg", uart_rhs_cfg);
                                              
    uvm_top.set_timeout(usr_timeout);
    `uvm_info("build_phase", "Exiting...", UVM_HIGH)
  endfunction: build_phase
                                              
  virtual function void start_of_simulation_phase(uvm_phase phase); 
    `uvm_info("start_of_simulation_phase", "Entered...", UVM_HIGH)
    uvm_top.print_topology();
    `uvm_info("start_of_simulation_phase", "Exiting...", UVM_HIGH)
  endfunction
                                                  
  virtual function void final_phase(uvm_phase phase);
    uvm_report_server svr;
    super.final_phase (phase);
    `uvm_info("final_phase", "Entered...", UVM_HIGH)
    svr = uvm_report_server::get_server();
    if(svr.get_severity_count (UVM_FATAL) + svr.get_severity_count (UVM_ERROR) > 0) begin
      $display("\n======================================");
      $display("     ###Status: TEST FAILED###          ");
      $display("=======================================\n");
    end
    else begin
      $display("\n=======================================");
      $display("    ###Status: TEST PASSED###            ");
      $display("=======================================\n");
    end
    `uvm_info("final_phase", "Exiting...",UVM_HIGH)
  endfunction: final_phase
endclass

