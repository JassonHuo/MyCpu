module id_ex(
  //from id
  input [31: 0] pc_in,
  input [6: 0] opcode_in,
  input [4: 0] rd_in,
  input [2: 0] funct3_in,
  input [6: 0] funct7_in,
  input [11: 0] Iimm_in,
  input [11: 0] Simm_in,
  input [12: 0] Bimm_in,
  input [19: 0] Uimm_in,
  input [20: 0] Jimm_in,

  //from gpr
  input [31: 0] rs1num_in,
  input [31: 0] rs2num_in,

  //to ex
  output reg [31: 0] pc_out,
  output reg[6: 0] opcode_out,
  output reg [4: 0] rd_out,
  output reg [2: 0] funct3_out,
  output reg [6: 0] funct7_out,
  output reg [11: 0] Iimm_out,
  output reg [11: 0] Simm_out,
  output reg [12: 0] Bimm_out,
  output reg [19: 0] Uimm_out,
  output reg [20: 0] Jimm_out,

  output reg [31: 0] rs1num_out,
  output reg [31: 0] rs2num_out,

  //from clk
  input clk
);

  always@(posedge clk)begin
	pc_out <= pc_in;
	opcode_out <= opcode_in;
	rd_out <= rd_in;
	funct3_out <= funct3_in;
	funct7_out <= funct7_in;
	Iimm_out <= Iimm_in;
	Simm_out <= Simm_in;
	Bimm_out <= Bimm_in;
	Uimm_out <= Uimm_in;
	Jimm_out <= Jimm_in;
	rs1num_out <= rs1num_in;
	rs2num_out <= rs2num_in;
  end

endmodule
