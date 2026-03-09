module inst_fetch(
  input [31: 0] pc_in,
  output [31: 0] inst_out,
  output [31: 0] romaddr_out,
  input [31: 0] romdata_in
);

  assign romaddr_out = pc_in;
  assign inst_out = romdata_in;

endmodule
