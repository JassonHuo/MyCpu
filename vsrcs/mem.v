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

);



endmodule
