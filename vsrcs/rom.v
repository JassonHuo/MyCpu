module rom(
  input [31: 0] romaddr_in,
  input clk,
  output [31: 0] romdata_out
);

  reg [31: 0] rom_reg [0: 1023];

  assign romdata_out = rom_reg[romaddr_in[11: 2]];   //地址宽度需随情况修改

endmodule
