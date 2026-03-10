module alu(
  input [31: 0] x,
  input [31: 0] y,
  input [: 0] sel,
  output [31: 0] z,

);

  always@(*)begin
	case(sel)
	  4'b0000: z = x + y;
	  4'b0001: z = x - y;
	  4'b0010: z = x & y;
	  4'b0011: z = x | y;
	  4'b0100: z = x ^ y;
	  4'b0101: z = 


endmodule
