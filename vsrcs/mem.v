module mem(
  //from ex
  input bt0en_in,
  input bt1en_in,
  input bt2en_in,
  input bt3en_in,
  input readen_in,
  input [31: 0] ramaddr_in,
  input [31: 0] ramdata_in,

  input wen,
  input [31: 0] rdnum_in,
  input [4: 0] rd_in,
  input pcen_in,
  input [31: 0] pcchan_in,
  input [31: 0] pc_in,
  input [31: 0] inst_in,

  //to wb
  output [31: 0] pc_out,
  output [31: 0] inst_out,
  output wen_out,
  output [31: 0] rdnum_out,
  output [4: 0] rd_out,
  output pcen_out,
  output [31: 0] pcchan_out,

  output [31: 0] data_from_ram_out, 
  output isfromram_out
  //to ram
  output bt0en_out,
  output bt1en_out,
  output bt2en_out,
  output bt3en_out,
  output readen_out, 
  output [31: 0] ramaddr_out,
  output [31: 0] ramdata_out, 
  //from ram
  input [31: 0] data_from_ram_in
);

  assign pc_out = pc_in;
  assign inst_out = inst_in;
  assign wen_out = wen;
  assign rdnum_out = rdnum_in;
  assign rd_out = rd_in;
  assign pcen_out = pcen_in;
  assign pcchan_out = pcchan_in;

  assign bt0en_out = bt0en_in;
  assign bt1en_out = bt1en_in;
  assign bt2en_out = bt2en_in;
  assign bt3en_out = bt3en_in;
  assign readen_out = readen_in;
  assign ramaddr_out = ramaddr_in;
  assign ramdata_out = ramdata_in;
  assign data_from_ram_out = data_from_ram_in;

endmodule
