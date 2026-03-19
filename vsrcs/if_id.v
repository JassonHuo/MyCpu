module if_id(
  //from if
  input [31: 0] inst_in,
  input [31: 0] pc_in,
  
  //to id
  output reg [31: 0] inst_out,
  output reg [31: 0] pc_out,

  //from clk
  input clk
);

  always@(posedge clk)begin
	inst_out <= inst_in;
	pc_out <= pc_in;
  end

endmodule
