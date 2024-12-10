      class uart_monitor extends uvm monitor;
  `uvm_component_uti1s(uart_monitor)

  virtuaL uart_if lhs_if;
  virtuaL uart_if rhs_if;

  uart_config uart_lhs cfg;
  uart_config uart_rhs cfg;

  uvm_event done_event;
  uart_transaction trans = new();
  
  time BAUD_PERI0D;

  /* AnatLysis port, send the transaction to scoreboard */
  uvm_analysis_port #(uart_transaction) item_observed_port;

  function new(string name="uart _monitor", uvm_component parent);
    super.new(name,parent);
    item_observed_port = new("item observed port",thiS);
  endfunction: new

  virtual function void buitd_phase(uvm phase phase) ;
    super.build_phase(phase) ;
    if(!uvm_config_db#(virtual uart_if)::get(this,"","lhs if",lhs_if))
      `uvm_fataL(get_type_name(),$sformatf("FaiL to get Lhs if from uvm config db"))

    if(!uvm_config_db#(virtual uart if)::get(this,"","rhs_if",rhs_if))
      `uvm_fataL(get_type_name(),$sformatf("FaiL to get rhs if from uvm config db"))

    if(!uvm_config_db#(uart_config)::get(null,"*","uart_1hs_cfg",uart_lhs_cfg))
      `uvm_fataL(get_type_name(),$sformatf("FaiL to get uart ths cfq from uvm_config_db"))

    if(!uvm_config_db#(uart_config)::get(null,"*","uart_rhs_cfg",uart_rhs_cfg))
      `uvm_fataL(get_type_name(),$sformatf("FaiL to get uart ths cfq from uvm_config_db"))

    done_event = new("done event");

    uvm_config_db#(uvm_event)::set(null,"*","done event",done_event);
  endfunction: build_phase

  virtual task run phase(uvm_phase phase);
    forever begin
      if(uart_lhs_cfg.direction == 0 && uart_rhs_cfg.direction == 1) begin
        LT0R_receive_data(trans);
      end
      else if(uart_lhs_cfg.direction == 1 && uart_rhs_cfg.direction == 0) begin
        RT0L_receive_data(trans);
      end
      else if(uart_lhs_cfg.direction == 2 && uart_rhs_cfg.direction == 2) begin
        receive_data_all(trans);
      end
      `uvm_info(get_type_name(),$sformatf("0bserved transaction: \n %s", trans.sprint()),UVM_HIGH);
      /* Send trans (transaction) to scoreboard */
      item_observed_port.write(trans);
      done_event.trigger();
    end
  endtask: run phase

  function void set_baud_period(int baud_rate);
    case (baud_rate)
      4800: BAUD_PERI0D = 208333; // 1/4800 = 208.33us
      9600: BAUD_PERI0D = 104167; // 1/9600 = 104,17us
      19200: BAUD_PERI0D = 52083 ; // 1/19200 = 52.08us
      57600: BAUD_PERI0D = 17361 ; // 1/57600 = 17.36us
      115200: BAUD_PERI0D = 8681 ; // 1/115200 = 8.68us
      default: BAUD_PERI0D = 104167; // defauLt to 9600 baud
    endcase
  endfunction

  task LT0R_receive_data(uart_transaction trans);
    bit [8:0] pdata;
    set_baud_period(uart_rhs_cfg.baud_rate);
    // Start bit
    @(negedge rhs_if.rx);
    #BAUD_PERI0D;
    #1;

    // Parity bit
    if (uart_rhs_cfq.parity mode != 0) begin
    // Data bit if have parity mode
      for(int i=0;i<=uart_rhs_cfq.data width;i++) begin
        trans.receive_data[i] = rhs_if.rx;
        pdata[i] = rhs_if.rx;
        #BAUD_PERI0D;
    end
    else begin 
      for(int i=0;i<uart_rhs_cfq.data width;i++) begin
        trans.receive_data[i] = rhs_if.rx;
        pdata[i] = rhs_if.rx;
        #BAUD_PERI0D;
    end 

    repeat (uart_rhs_cfg.stop_bit) begin 
      #BAUD_PERIOR;
    end
  endtask
      
  task RTOL_receive_data(uart_transaction trans);
    bit [8:0] pdata;
    set_baud_period(uart_lhs_cfg.baud_rate);
    // Start bit
    @(negedge lhs_if.rx);
    #BAUD_PERI0D;
    #1;

    // Parity bit
    if (uart_lhs_cfq.parity mode != 0) begin
    // Data bit if have parity mode
      for(int i=0;i<=uart_lhs_cfq.data width;i++) begin
        trans.receive_data[i] = lhs_if.rx;
        pdata[i] = lhs_if.rx;
        #BAUD_PERI0D;
    end
    else begin 
      for(int i=0;i<uart_lhs_cfq.data width;i++) begin
        trans.receive_data[i] = lhs_if.rx;
        pdata[i] = lhs_if.rx;
        #BAUD_PERI0D;
    end 

    repeat (uart_lhs_cfg.stop_bit) begin 
      #BAUD_PERIOR;
    end
  endtask

  task receive_data_all(uart_transaction trans);
    fork 
      RTOL_receive_data(trans);
      LTOR_receive_data(trans);
    join_any
  endtask
endclass
      

