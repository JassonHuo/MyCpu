module rom(
  input [31: 0] romaddr_in,
  input clk,
  output [31: 0] romdata_out
);

  reg [31: 0] rom_reg [0: 1023];

  assign data = rom_reg[romaddr_in[31: 2]];

endmodule
