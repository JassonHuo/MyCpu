module alu(
  input [31: 0] x,
  input [31: 0] y,
  input [3: 0] sel,
  output reg [31: 0] z,
  output overflow,
  output zero
);

  parameter ADD = 4'd0, SUB = 4'd1, AND = 4'd2, OR = 4'd3, XOR = 4'd4, SLL = 4'd5, SRL = 4'd6, SRA = 4'd7;

  assign zero = (z == 0);

  always@(*)begin
	case(sel)
	  ADD: z <= x + y;
	  SUB: z <= x - y;
	  AND: z <= x & y;
	  OR: z <= x | y;
	  XOR: z <= x ^ y;
	  SLL: z <= ;
	  SRL: z <= ;
	  SRA: z <= ;
	  default: z <= 0;

	endcase
  end

endmodule
