module gpr(
  //from clk
  input clk,
  //from id
  input [4: 0] readaddr1_in,
  input [4: 0] readaddr2_in,
  //from wb
  input wen,
  input [4: 0] wriaddr_in,
  input [31: 0] wridata_in,
  //to ex
  output [31: 0] readdata1_out,
  output [31: 0] readdata2_out
);

  (* verilator public_flat_rw *) reg [31: 0] gpr_reg [0: 31];

  assign readdata1_out = (readaddr1_in == 0 ? 32'b0: gpr_reg[readaddr1_in]);
  assign readdata2_out = (readaddr2_in == 0 ? 32'b0: gpr_reg[readaddr2_in]);

  always@(posedge clk)begin
	if(wen == 1 && wriaddr_in != 0)
		gpr_reg[wriaddr_in] <= wridata_in;
  end

endmodule
