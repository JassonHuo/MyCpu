module rom(
  //from if
  input [31: 0] romaddr_in,
  //to if
  output [31: 0] romdata_out
);

  initial begin
	$readmemb("sum.bin", rom_reg);
  end

  reg [31: 0] rom_reg [0: 131072];

  assign romdata_out = rom_reg[romaddr_in[19: 2]];   //地址宽度需随情况修改

endmodule
