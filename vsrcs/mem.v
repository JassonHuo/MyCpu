module mem(
  input wen,
  input [31: 0] rdnum_in,
  input bt0en_in,
  input bt1en_in,
  input bt2en_in,
  input bt3en_in,
  input readen_in,
  input [31: 0] ramaddr_in,
  input [31: 0] ramdata_in,
  input [4: 0] rd_in,
  input pcen_in,
  input pcchan_in,
  input [31: 0] pc_in,
  input [31: 0] inst_in,
  output reg [31: 0] pc_out,
  output reg [31: 0] inst_out,
  output reg [31: 0] memaddr_out,
  output reg bt0en_out,
  output reg bt1en_out,
  output reg bt2en_out,
  output reg bt3en_out,
  output reg readen_out,
  output reg [31: 0] ramaddr_out,
  input [31: 0] ramreadnum_in
);

  assign pc_out = pc_in;
  assign inst_out = inst_in;
  assign bt0en_out = bt0en_in;
  assign bt1en_out = bt1en_in;
  assign bt2en_out = bt2en_in;
  assign bt3en_out = bt3en_in;
  assign readen_out = readen_in;
  assign ramaddr_out = ramaddr_in;  

endmodule
