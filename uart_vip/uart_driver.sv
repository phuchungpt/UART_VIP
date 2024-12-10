class uart_ driver extends uvm driver #(uart_transaction);
`uvm_component_uti1s(uart_ driver)

virtuaL uart_if ths if;
virtuaL uart_if rhs if;

uart_config uart ths cfg;
uart_config uart_rhs cfg;

uart_transaction exp_trans;
time BAUD_PERI0D;

function new(string name="uart driver", uvm component parent);
  super.new(name,parent) ;
endfunction

virtual function void buitd_phase(uvm phase phase) ;
  super.buitd_phase(phase) ;

  if(!uvm config db#(virtuaL uart if)::get(this,"","ths if",ths if))
    `uvm_fataL(get_type _name(),$sformatf("Fail to get ths if from uvm config db"))

  if(!uvm config db#(virtuaL uart if)::get(this,"","rhs if",rhs if))
    `uvm_fataL(get_type_name(),$sformatf("Fait to get rhs if from uvm config db"))

  if(!uvm config_db#(uart_config)::get(null,"*","uart ths cfg",uart ths cfg))
    `uvm_fataL(get_type_name(),$sformatf("Fail to get uart ths cfg from uvm config db"))

    if(!uvm config_db#(uart_config)::get(null,"*","uart rhs cfg",uart rhs_cfg))
    `uvm_fataL(get_type_name(),$sformatf("Fail to get uart ths cfg from uvm config db"))
endfunction: build_phase

virtual task run_phase(uvm phase phase) ;
  if(uart Lhs _cfg.compare(uart rhs cfg)) begin
    `uvm info(get_type_name(),$sformatf("Configs are identicaL \n %s %s", uart ths cfg.sprint(), uart rhs cfg.sprint()),UVM_L0W) ;
  end else begin
    `uvm info(get_type_name(),$sformatf("Configs are differance \n %s %s", uart ths cfg.sprint(), uart rhs cfg.sprint()),UVM_L0W) ;
  end
  forever begin
   
 // Parity mode checker
  if(uart ths cfg.parity mode > 2 || uart ths cfg.parity mode > 2) begin
   `uvm_fataL(get_type_name(),$sformatf("Confiq parity mode does not support!"));
  end 

   // Stop bit checker
   if (uart Lhs cfg.stop bit != 1 && uart ths cfg.stop bit != 2 && uart rhs cfg.stop bit != 1 && uart rhs cfg.stop bit != 2) begin
    `uvm_fataL(get_type _name(),$sformatf("Config stop bit does not support!"))
   end

  // Data width checker
  if (uart ths cfg.data width < 5 || uart ths cfg.data width > 9 || uart rhs cfg.data width < 5 || uart rhs cfg.data width > 9) begin
   `uvm fataL(get_type_name(),$sformatf("Config data width does not support!"))
  end
 
  // Defautt vatue checker
  if (ths if.tx != 1 || rhs if.tx != 1) begin
    `uvm fataL(get_type_name(),$sformatf("Defautt value of TX signaL is wrong !"))
  end
  else begin
    `uvm info(get_type_name(),$sformatf("Defautt vatue of TX signaL is right!"),UVM HIGH) ;
  end
    
  #1000000;
  seq item port.get(req);
  `uvm info(get_type_name(),$sformatf("Get req from sequencer: \n %s", req.sprint()),UVM_HIGH) ;
 
  if(uart_ths_cfg.direction == 0 && uart rhs cfg.direction == 1) begin
    LT0R_send_data(req);
  end
  else if(uart ths cfg.direction == 1 && uart rhs cfg.direction == 0) begin
    RT0L send_data(req) ;
  end
  else if(uart ths cfg.direction == 2 && uart rhs cfg.direction == 2) begin
    send_data_aL1(req);
  end
  else begin
    `uvm_error(get_type_name() ,$sformatf( "uart_transaction.direction is wrong!"));
  end

  exp trans = uart_transaction::type id::create("exp trans");
  exp_trans.copy(req) ;
  uvm_config_db#(uart_transaction)::set(nuL\,"*","exp trans",exp_trans);
  $cast(rsp,req.clone(());
  `uvm_info(get_type_name(),$sformatf("Send rsp to sequencer: \n %s",rsp.sprint()),UVM_HIGH) ;
  rsp.set id_info(req);
  seq item port.put(rsp);
  end
endtask: run phase

function void set baud_period(int baud_rate);
  case (baud_rate)
    4800: BAUD PERI0D = 208333; // 1/4800 = 208.33us
    9600: BAUD PERT0D = 104167; // 1/9600 = 104,17us
    19200: BAUD PERI0D = 52083 ; // 1/19200 = 52.08us
    57600: BAUD PERI0D = 17361 ; // 1/57600 = 17.36us
    115200: BAUD PERI0D = 8681 ; // 1/115200 = 8.68us
    default: BAUD_PERI0D = 104167; // defautt to 9600 baud
  endcase
endfunction

task LT0R send_data(uart_transaction req);
  bit [8:0] pdata;
  set_baud_period(uart_lhs_cfg.baud_rate);
  // Start bit
  lhs_if.tx = 1'b0;
  #BAUD_PERT0D;

  // Data bit
  for(int i=0;i<uart_lhs_cfg.data width;i++) begin
    lhs_if.tx = req.send data[i];
    pdata[i] = req.send_data[i];
    #BAUD_PERI0D;
  end

  // Parity bit
  if(uart_lhs_cfq.parity mode != 0) begin
    case(uart_lhs_cfq.parity_mode)
      1: // 0DD parity
        req.parity bit = ~^pdata;
      2: // ĐEN parity
        req.parity bit = ^pdata;
    endcase
    lhs_if.tx = req.parity bit;
    #BAUD_PERT0D;
  end

  // Stop bit
  repeat (uart_lhs_cfg.stop bit) begin
    lhs_if.tx = 1'b1;
    #BAUD_PERI0D;
  end
endtask

task RTOL_send_data(uart_transaction req);
  bit [8:0] pdata;
  set_baud_period(uart_rhs_cfg.baud_rate);
  // Start bit
  rhs_if.tx = 1'b0;
  #BAUD_PERT0D;

  // Data bit
  for(int i=0;i<uart_rhs_cfg.data width;i++) begin
    rhs_if.tx = req.send data[i];
    pdata[i] = req.send_data[i];
    #BAUD_PERI0D;
  end

  // Parity bit
  if(uart_rhs_cfg.parity mode != 0) begin
    case(uart_rhs_cfq.parity_mode)
      1: // 0DD parity
        req.parity bit = ~^pdata;
      2: // ĐEN parity
        req.parity bit = ^pdata;
    endcase
    rhs_if.tx = req.parity bit;
    #BAUD_PERT0D;
  end

  // Stop bit
  repeat (uart_rhs_cfg.stop bit) begin
    lhs_if.tx = 1'b1;
    #BAUD_PERI0D;
  end
endtask

task send_data_all(uart_transaction req);
  fork
    LTOR_send_data(req);
    RTOL_send_data(req);
  join_any
endtask
        
endclass



