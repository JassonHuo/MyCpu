module inst_fetch(
  //from pc
  input [31: 0] pc_in,
  //to if_id
  output [31: 0] inst_out,
  output [31: 0] pc_out,
  //to rom
  output [31: 0] romaddr_out,
  //from rom
  input [31: 0] romdata_in
);

  assign romaddr_out = pc_in;
  assign inst_out = romdata_in;
  assign pc_out = pc_in;

endmodule
