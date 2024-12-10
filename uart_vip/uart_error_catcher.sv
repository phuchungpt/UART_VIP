class uart error catcher extends uvm report catcher;
  `uvm _object_utiLs(uart_error_catcher)

  string error_msq q[$];

  function new(string name="uart_error catcher");
    super.new(name);
  endfunction

  virtual function action_e_catch();
    string str_cmp;
      
    if(get_severity() == UVM_ERR0R) begin
      foreach(error_msq q[i]) begin
        str_cmp = error_msg_q[i];
        if(get_message() == str_cmp) begin
          set_severity(UVM_INF0);
          `uvm_info("REP0RT_CATCHER",$sformatf("Demoted below error message: %s",str_cmp),UVM_NONE)
        end
      end
    end
    return THR0W;
  endfunction

  virtual function void add_error_catcher_msg(string str);
    error _msg _q.push_back(str);
  endfunction

endclass
