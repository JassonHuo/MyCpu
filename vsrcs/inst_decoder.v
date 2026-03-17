module inst_decoder(
  //from if
  input [31: 0] inst_in,
  input [31: 0] pc_in,
  //to ex
  output [31: 0] pc_out,
  output [6: 0] opcode_out,
  output [4: 0] rd_out,
  output [2: 0] funct3_out,
  output [6: 0] funct7_out,
  output [11: 0] Iimm_out,
  output [11: 0] Simm_out,
  output [12: 0] Bimm_out,
  output [19: 0] Uimm_out,
  output [20: 0] Jimm_out,
  //to gpr
  output [4: 0] rs1_out,
  output [4: 0] rs2_out
);


  assign opcode_out = inst_in[6: 0];
  assign rd_out = inst_in[11: 7];
  assign funct3_out = inst_in[14: 12];
  assign rs1_out = inst_in[19: 15];
  assign rs2_out = inst_in[24: 20];
  assign funct7_out = inst_in[31: 25];
  assign Iimm_out = inst_in[31: 20];
  assign Simm_out = {inst_in[31: 25], inst_in[11: 7]};
  assign Bimm_out = {inst_in[31], inst_in[7], inst_in[30: 25], inst_in[11: 8], 1'b0};
  assign Uimm_out = inst_in[31: 12];
  assign Jimm_out = {inst_in[31], inst_in[19: 12], inst_in[20], inst_in[30: 21], 1'b0};

  assign pc_out = pc_in;

endmodule
