module ex(
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
  //to mem
  output reg bt0en_out,
  output reg bt1en_out,
  output reg bt2en_out,
  output reg bt3en_out,
  output reg readen_out,
  output reg [31: 0] ramaddr_out,
  output reg [31: 0] ramdata_out,    //when change ram num
  output reg [1: 0] load_width_out,			//0: byte 1: half 2:full
  output reg is_sign_extend_out,			//judge the sign-extend or not
 
  output reg wen,
  output reg [31: 0] rdnum_out,
  output reg [4: 0] rd_out,
  output reg pcen_out,	
  output reg [31: 0]pcchan_out,
  output reg isfromram_out,

  //to alu
  output reg [31: 0] opnum1_out,
  output reg [31: 0] opnum2_out,
  output reg [3: 0] sel_out,
  output reg [4: 0] shiftbit_out, 
  //from alu
  input [31: 0] alunum_in,
  input equal_in,
  input signedless_in,
  input unsignedless_in,
  input signedbig_in,
  input unsignedbig_in
);

  parameter ADD = 4'd0, SUB = 4'd1, AND = 4'd2, OR = 4'd3, XOR = 4'd4, SLL = 4'd5, SRL = 4'd6, SRA = 4'd7, 
	SLT = 4'd8, SLTU = 4'd9;

  always@(*)begin
	wen = 1'b0;
	opnum1_out = 32'b0;
	opnum2_out = 32'b0;
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
	sel_out = 4'b0;
	shiftbit_out = 5'b0;
	isfromram_out = 1'b0;
	load_width_out = 2'b0;
	is_sign_extend_out = 1'b0;
	case(opcode_in)
	  //LUI
	  7'b0110111:begin
		rd_out = rd_in;
		rdnum_out = {Uimm_in, 12'b0};
		wen = 1;
	  end
	  //AUIPC
	  7'b0010111:begin
		sel_out = ADD;
		opnum1_out = {Uimm_in, 12'b0};
		opnum2_out = pc_in;
		rdnum_out = {alunum_in};
		rd_out = rd_in;
		wen = 1'b1;
	  end
	  //JAL
	  7'b1101111:begin
		opnum1_out = {{11{Jimm_in[20]}}, Jimm_in};
		opnum2_out = pc_in;
		wen = 1'b1;
		rdnum_out = pc_in + 32'd4;
		rd_out = rd_in;
		pcen_out = 1'b1;
		pcchan_out = alunum_in;
		sel_out = ADD;
	  end		
	  //JALR
	  7'b1100111:begin
		opnum1_out = rs1num_in;
		opnum2_out = {{20{Iimm_in[11]}}, Iimm_in} & 32'hFFFFFFFE;
		sel_out = ADD;
		pcchan_out = alunum_in;
		pcen_out = 1;
		wen = 1;
		rdnum_out = pc_in + 4;
		rd_out = rd_in;
	  end 
	  //BEQ-BGEU
	  7'b1100011:begin
		pcen_out = 1'b0;
		pcchan_out = 32'b0;
		opnum1_out = rs1num_in;
		opnum2_out = rs2num_in;
		pcchan_out = {{19{Bimm_in[12]}}, Bimm_in} + pc_in;
		case(funct3_in)
		  3'b000:begin    //beq
			if(equal_in)
			  pcen_out = 1'b1;
		  end
		  3'b001:begin	  //bnq
			if(!equal_in)
			  pcen_out = 1'b1;
		  end
		  3'b100:begin	  //blt
			if(signedless_in)
			  pcen_out = 1'b1;
		  end
		  3'b101:begin	  //bge
			if(signedbig_in)
			  pcen_out = 1'b1;
		  end
		  3'b110:begin	  //bltu
			if(unsignedless_in)
			  pcen_out = 1'b1;
		  end
		  3'b111:begin	  //bgeu
			if(unsignedbig_in)
			  pcen_out = 1'b1;
		  end
		  default:begin
		  end
		endcase
	  end
	  //LB-LHU
	  7'b0000011:begin
		  readen_out = 1'b1;
		  opnum1_out = rs1num_in;
		  opnum2_out = {{20{Iimm_in[11]}}, Iimm_in};
		  sel_out = ADD;
		  ramaddr_out = alunum_in;	
		  wen = 1'b1;
		  isfromram_out = 1'b1;
		  is_sign_extend_out = 1'b0;
		  rd_out = rd_in;
		case(funct3_in)		  
		  3'b000: begin	  //lb
			load_width_out = 2'b0;
			is_sign_extend_out = 1'b1;
		  end
		  3'b001: begin   //lh
			load_width_out = 2'b01;
			is_sign_extend_out = 1'b1;
		  end
		  3'b010: begin	  //lw
			load_width_out = 2'b10;
			is_sign_extend_out = 1'b1;
		  end
		  3'b100: begin	  //lbu
			load_width_out = 2'b00;
			is_sign_extend_out = 1'b0;
		  end
		  3'b101: begin	  //lhu
			load_width_out = 2'b01;
			is_sign_extend_out = 1'b0;
		  end
		  default: begin
		  end
		endcase
	  end
	  //SB-SW
	  7'b0100011:begin
		opnum1_out = rs1num_in;
		opnum2_out = {{20{Simm_in[11]}}, Simm_in};
		sel_out = ADD;
		ramaddr_out = alunum_in;
		bt0en_out = 1'b0;
		bt1en_out = 1'b0;
		bt2en_out = 1'b0;
		bt3en_out = 1'b0;
		case(funct3_in)
		  3'b000:begin	//sb
			ramdata_out = {4{rs2num_in[7: 0]}};
			case(ramaddr_out[1: 0])
			  2'b00: bt0en_out = 1'b1;
			  2'b01: bt1en_out = 1'b1;
			  2'b10: bt2en_out = 1'b1;
			  2'b11: bt3en_out = 1'b1;
			  default:begin
				bt0en_out = 1'b0;
				bt1en_out = 1'b0;
				bt2en_out = 1'b0;
				bt3en_out = 1'b0;
			  end
			endcase	  
		  end
		  3'b001:begin  //sh
			ramdata_out = {2{rs2num_in[15: 0]}};
			case(ramaddr_out[1])
			  1'b0:begin
				bt0en_out = 1'b1;
				bt1en_out = 1'b1;
			  end
			  1'b1:begin
				bt2en_out = 1'b1;
				bt3en_out = 1'b1;
			  end
			endcase
		  end
		  3'b010:begin  //sw
			bt0en_out = 1'b1;
			bt1en_out = 1'b1;
			bt2en_out = 1'b1;
			bt3en_out = 1'b1;
			ramdata_out = rs2num_in;
		  end
		  default:begin
		  end
		endcase
	  end
	  //ADDI-SRAI
	  7'b0010011:begin
		rd_out = rd_in;
		wen = 1;
		opnum1_out = rs1num_in;
		opnum2_out = {{20{Iimm_in[11]}}, Iimm_in};
		rdnum_out = alunum_in;
		case(funct3_in)
		  3'b000: begin //addi
			sel_out = ADD;
		  end
		  3'b010: begin //slti
			sel_out = SLT;
		  end	
		  3'b011: begin	//sltiu
			sel_out = SLTU;
		  end
		  3'b100: begin  //xori
			sel_out = XOR;
		  end
		  3'b110: begin  //ori
			sel_out = OR;
		  end
		  3'b111: begin //andi
			sel_out = AND;
		  end
		  3'b001: begin //slli
			sel_out = SLL;
			shiftbit_out = Iimm_in[4: 0];
		  end
		  3'b101: begin
			shiftbit_out = Iimm_in[4: 0];
			if(Iimm_in[11: 5] == 7'b0)
			  sel_out = SRL;
			else
			  sel_out = SRA;
		  end
		  default: begin
			sel_out = 0;
			shiftbit_out = 0;
			rdnum_out = 0;
		  end
		endcase
	  end
	  //ADD-AND
	  7'b0110011:begin
		opnum1_out = rs1num_in;
		opnum2_out = rs2num_in;
		rdnum_out = alunum_in;
		rd_out = rd_in;
		wen = 1'b1;
		case(funct3_in)
		  3'b000:begin  //add sub
			if(funct7_in == 7'b0)
			  sel_out = ADD;
			else 
			  sel_out = SUB;
		  end 
		  3'b001:begin	//sll
			sel_out = SLL;
			shiftbit_out = rs2num_in[4: 0];
		  end
		  3'b010:begin	//slt
			sel_out = SLT;
		  end
		  3'b011:begin  //sltu
			sel_out = SLTU;
		  end
		  3'b100:begin	//xor
			sel_out = XOR;
		  end
		  3'b101:begin	//srl sra
			shiftbit_out = rs2num_in[4: 0];
			if(funct7_in == 7'b0)
			  sel_out = SRL;
			else
			  sel_out = SRA;
		  end
		  3'b110:begin //or
			sel_out = OR;
		  end
		  3'b111:begin	  //and
			sel_out = AND;
		  end
		  default:begin
		  end
		endcase
	  end
	  //FENCE-PAUSE

	  //ECALL-EBREAK

	  default:begin
	  end

	endcase
  end

endmodule
