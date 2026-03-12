module ex(
  input [31: 0] inst_in,
  input [31: 0] pc_in,
  input [6: 0] opcode_in,
  input [4: 0] rd_in,
  input [2: 0] funct3_in,
  input [31: 0] rs1num_in,
  input [31: 0] rs2num_in,
  input [6: 0] funct7_in,
  input [11: 0] Iimm_in,
  input [11: 0] Simm_in,
  input [12: 0] Bimm_in,
  input [19: 0] Uimm_in,
  input [20: 0] Jimm_in,
  output reg wen,
  output reg [31: 0] rs1num_out,
  output reg [31: 0] rs2num_out,
  input [31: 0] alunum_in,
  output reg [31: 0] rdnum_out,
  output reg bt0en_out,
  output reg bt1en_out,
  output reg bt2en_out,
  output reg bt3en_out,
  output reg readen_out,
  output reg [31: 0] ramaddr_out,
  output reg [31: 0] ramdata_out,
  output reg [4: 0] rd_out,
  output reg pcen_out,	
  output reg [31: 0]pcchan_out,
  output reg [31: 0] pc_out,
  output reg [31: 0] inst_out
);

  always@(*)begin
	wen = 1'b0;
	rs1num_out = 32'b0;
	rs2num_out = 32'b0;
	rdnum_out = 32'b0;
	bt0en_out = 1'b0;
	bt1en_out = 1'b0;
	bt2en_out = 1'b0;
	bt3en_out = 1'b0;
	readen_out = 1'b0;
	ramaddr_out = 32'b0;
	ramdata_out = 32'b0;
	rd_out = 5'b0;
	pcen_out = 1'b0;
	pcchan_out = 32'b0;
	case(opcode_in)
	  //LUI
	  7'b0110111:begin
		rd_out = rd_in;
		rdnum_out = {Uimm_in, 12'b0};
		wen = 1;
	  end
	  //AUIPC
	  
	  //JAL
	  
	  //JALR
	  7'b1100111:begin
		pcchan_out = {{20{Iimm_in[11]}}, Iimm_in[11: 1], 1'b0};
		pcen_out = 1;
		wen = 1;
		rdnum_out = pc_in + 4;
		rd_out = rd_in;
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

	  default:begin
	  end

	endcase
  end

endmodule
