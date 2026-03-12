module top(
  input clk,
  input rst
);

  wire [31: 0] pc;
  wire [31: 0] inst1;
  wire [31: 0] inst2;
  wire [31: 0] inst3;
  wire [31: 0] romaddr;
  wire [32: 0] romdata;
  wire [31: 0] pc_inst1;
  wire [31: 0] pc_inst2;
  wire [31: 0] pc_inst3;
  wire [31: 0] pc_chan;
  wire pcen;
  wire [31: 0] pc;
  wire [6: 0] opcode;
  wire [4: 0] rd;
  wire [2: 0] funct3;
  wire [4: 0] rs1;
  wire [4: 0] rs2;
  wire [6: 0] funct7;
  wire [11: 0] Iimm;
  wire [11: 0] Simm;
  wire [12: 0] Bimm;
  wire [19: 0] Uimm;
  wire [20: 0] Jimm;
  wire wen;
  wire [4: 0] wriaddr;
  wire [31: 0] wridata;
  wire [31: 0] readdata1;
  wire [31: 0] readdata2;
  wire [31: 0] rs1num;
  wire [31: 0] rs2num;
  wire [31: 0] alunum;
  wire [31: 0] rdnum;
  wire bt0en;
  wire bt1en;
  wire bt2en;
  wire bt3en;

  wire readen;
  wire [31: 0] ramaddr;
  wire [31: 0] ramdata;
  wire [4: 0] rdtomem;

  pc_reg pc(
	.clk(clk),
	.rst(rst),
	.pcchan_in(pc_chan),
	.pcen_in(pcen),
	.pc_out(pc)
  );

  inst_fetch if0(
	.pc_in(pc),
	.inst_out(inst1),
	.romaddr_out(romaddr),
	.romdata_in(romdata),
	.pc_out(pc_inst1)
  );

  rom romem(
	.romaddr_in(romaddr),
	.romdata_out(romdata)
  );	

  inst_decoder id(
	.inst_in(inst1),
	.pc_in(pc_inst1),
	.pc_out(pc_inst2),
	.inst_out(inst2),
	.opcode_out(opcode),
	.rd_out(rd),
	.funct3_out(funct3),
	.rs1_out(rs1),
	.rs2_out(rs2),
	.funct7_out(funct7),
	.Iimm_out(Iimm),
	.Simm_out(Simm),
	.Bimm_out(Bimm),
	.Uimm_out(Uimm),
	.Jimm_out(Jimm)
  );

  gpr gpr0(
	.clk(clk),
	.readaddr1_in(rs1),
	.readaddr2_in(rs2),
	.wen(wen),
	.wriaddr_in(wriaddr),
	.wridata_in(wridata),
	.readdata1_out(readdata1),
	.readdata2_out(readdata2)
  );

  ex ex0(
	.inst_in(inst2),
	.pc_in(pc_inst2),
	.opcode_in(opcode),
	.rd_in(rd),
	.funct3_in(funct3),
	.rs1num_in(readdata1),
	.rs2num_in(readdata2),
	.funct7_in(funct7),
	.Iimm_in(Iimm),
	.Simm_in(Simm),
	.Bimm_in(Bimm),
	.Uimm_in(Uimm),
	.Jimm_in(Jimm),
	.wen(wen),
	.rs1num_out(rs1num),
	.rs2num_out(rs2num),
	.alunum_in(alunum),
	.rdnum_out(rdnum),
	.bt0en_out(bt0en),
	.bt1en_out(bt1en),
	.bt2en_out(bt2en),
	.bt3en_out(bt3en),
	.readen_out(readen),
	.ramaddr_out(ramaddr),
	.ramdata_out(ramdata),
	.rd_out(rdtomem),
	.pcen_out(pcen),
	.pcchan_out(pc_chan)
  );	

endmodule
