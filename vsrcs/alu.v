module alu(
  //from ex
  input [31: 0] x_in,
  input [31: 0] y_in,
  input [3: 0] sel_in,
  input [4: 0] shiftbit_in,
  //to ex
  output reg [31: 0] z_out,
  output overflow_out,
  output zero_out
);

  parameter ADD = 4'd0, SUB = 4'd1, AND = 4'd2, OR = 4'd3, XOR = 4'd4, SLL = 4'd5, SRL = 4'd6, SRA = 4'd7, 
	SLT = 4'd8, SLTU = 4'd9;

  assign zero_out = (z_out == 0);
  wire [31: 0] shift_result;

  barrel_shifter bs(
	.x_in(x_in),
	.shiftbit_in(shiftbit_in),
	.sel_in(sel_in),
	.z_out(shift_result)
  );

  always@(*)begin
	case(sel_in)
	  ADD: z_out = x_in + y_in;
	  SUB: z_out = x_in - y_in;
	  AND: z_out = x_in & y_in;
	  OR: z_out = x_in | y_in;
	  XOR: z_out = x_in ^ y_in;
	  SLL, SRL, SRA: z_out = shift_result;
	  SLT: z_out = {31'b0, ($signed(x_in) < $signed(y_in))};
	  SLTU: z_out = {31'b0, (x_in < y_in)};
	  default: z_out = 32'b0;

	endcase
  end

endmodule
