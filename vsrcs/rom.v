module rom(
  //from if
  input [31: 0] romaddr_in,
  //to if
  output [31: 0] romdata_out
);

  initial begin
	$readmemb("sum.bin", rom_reg;
  end

  reg [31: 0] rom_reg [0: 1023];

  assign romdata_out = rom_reg[romaddr_in[11: 2]];   //地址宽度需随情况修改

endmodule
