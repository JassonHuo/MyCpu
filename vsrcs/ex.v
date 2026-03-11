module ex(
  input [31: 0] opcode_in,
  input [6: 0] rd_in,
  input [2: 0] funct3_in,
  input [31: 0] rs1num_in,
  input [31: 0] rs2num_in,
  input [6: 0] funct7_in,
  input [11: 0] Iimm_in,
  input [11: 0] Simm_in,
  input [12: 0] Bimm_in,
  input [19: 0] Uimm_in,
  input [20: 0] Jimm_in
);

  always@(*)begin
	case(opcode)
	  //LUI
	  7'b0110111:begin
	  end
	  //AUIPC
	  
	  //JAL
	  
	  //JALR
	  7'b1100111:begin
	  end 
	  //BEQ-BGEU

	  //LB-LHU
	  7'b0000011:begin
	  end
	  //SB-SW
	  7'b0100011:begin
	  end
	  //ADDI-ANDI
	  7'b0010011:begin
	  end
	  //SLLI-SRAI

	  //ADD-AND
	  7'b0110011:begin
	  end
	  //FENCE-PAUSE

	  //ECALL-EBREAK

	  default:

	endcase
  end

endmodule
