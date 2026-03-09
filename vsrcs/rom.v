module rom(
  input [31: 0] romaddr_in,
  output reg [31: 0] romdata_out
);

  reg [31: 0] rom_reg [0: 4294967295];
  always@(pc_in)
	romdata_out = rom_reg[romaddr_in >> 2];

endmodule
