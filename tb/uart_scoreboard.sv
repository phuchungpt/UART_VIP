class uart_scoreboard extends uvm_scoreboard; 
  `uvm_component_utils (uart_scoreboard)
  
  virtual uart_if lhs_if;
  virtual uart_if rhs_if;
  
  int rhs_parity_mode; 
  int rhs_data_width;
  
  uart_transaction exp_trans;
  
  uvm_analysis_imp#(uart_transaction, uart_scoreboard) item_collected_export;
  
  function new(string name="uart_scoreboard", uvm_component parent); 
    super.new(name, parent);
  endfunction: new
  
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase", "Entered...", UVM_HIGH)
    
    if(!uvm_config_db# (virtual uart_if)::get(this,' "","lhs_if", lhs_if))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get lhs_if from uvm_config_db!"))
      
    if(!uvm_config_db# (virtual uart_if)::get(this,"","rhs_if", rhs_if))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get rhs_if from uvm_config_db!"))
      
    if(!uvm_config_db#(int)::get(null,"*","rhs_parity_mode", rhs_parity_mode))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get rhs_parity_mode from uvm_config_db!"))
      
    if(!uvm_config_db#(int)::get(null,"*","rhs_data_width", rhs_data_width))
      `uvm_fatal (get_type_name(), $sformatf("Fail to get rhs_data_width from uvm_config_db!"))
      
    item_collected_export = new("item_collected_export", this);
    
    `uvm_info("build_phase", "Exiting...", UVM_HIGH)
  endfunction: build_phase
    
  virtual task run_phase (uvm_phase phase);
  endtask: run_phase
    
  virtual function void write(uart_transaction trans);
    uart_transaction exp_trans;
    bit [8:0] exp_data = 9'b0;
    bit [8:0] act_data = 9'b0;
    `uvm_info(get_type_name(), $sformatf("uart_scoreboard: Get packet from UART: \n %s", trans.sprint()),UVM_HIGH);

    if(!uvm_config_db#(uart_transaction)::get(null,"*", "exp_trans", exp_trans)) 
      `uvm_fatal (get_type_name(), $sformatf("Fail to get exp_trans from uvm_config_db"))

    case (rhs_data_width)
      5: begin
        act_data[5:0] = trans.receive_data[5:0];
        exp_data[5:0] = {exp_trans.parity_bit,exp_trans.send_data[4:0]};
      end
      6: begin
        act_data[6:0] = trans.receive_data[6:0];
        exp_data[6:0] = {exp_trans.parity_bit,exp_trans.send_data[5:0]};
      end
      7: begin
        act_data[7:0] = trans.receive_data[7:0];
        exp_data[7:0] = {exp_trans.parity_bit,exp_trans.send_data[6:0]};
      end
      9: begin
        act_data[8:0] = trans.receive_data[8:0];
        exp_data[8:0] = {exp_trans.parity_bit,exp_trans.send_data[8:0]};
      end
      default: begin
        act_data[8:0] = trans.receive_data[8:0];
        exp_data[8:0] = {exp_trans.parity_bit, exp_trans.send_data[7:0]};
      end
    endcase
    
    if(exp_data != act_data) begin
      `uvm_error(get_type_name(), $sformatf("Data mismatch!"))
      `uvm_info(get_type_name(), $sformatf("Exp_data = %b, Act_data = %b", exp_data, act_data), UVM_LOW)
    end
    else begin
      `uvm_info(get_type_name(), $sformatf("Data matching: exp_data = %b, act_data = %b", exp_data, act_data), UVM_LOW)
    end
  endfunction: write
    
endclass: uart_scoreboard
