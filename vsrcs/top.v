module top(
  input clk,
  input rst
);

  wire [31: 0] pcchan_wbpc;
  wire pcen_wbpc;
  wire [31: 0] pc_pcif;
  wire [31: 0] inst_ifid;
  wire [31: 0] pc_ifid;
  wire [31: 0] romaddr_ifrom;
  wire [31: 0] romdata_romif;
  wire [31: 0] pc_idex;
  wire [6: 0] opcode_idex;
  wire [4: 0] rd_idex;
  wire [2: 0] funct3_idex;
  wire [6: 0] funct7_idex;
  wire [11: 0] Iimm_idex;
  wire [11: 0] Simm_idex;
  wire [12: 0] Bimm_idex;
  wire [19: 0] Uimm_idex;
  wire [20: 0] Jimm_idex;
  wire [4: 0] rs1_idgpr;
  wire [4: 0] rs2_idgpr;
  wire [31: 0] rs1num_gprex;
  wire [31: 0] rs2num_gprex;
  wire bt0en_exmem;
  wire bt1en_exmem;
  wire bt2en_exmem;
  wire bt3en_exmem;
  wire readen_exmem;
  wire [31: 0] ramaddr_exmem;
  wire [31: 0] ramdata_exmem;
  wire [1: 0] load_width_exmem;
  wire is_sign_extend_exmem;

  wire wen_exmem;
  wire [31: 0] rdnum_exmem;
  wire [4: 0] rd_exmem;
  wire pcen_exmem;
  wire [31: 0] pcchan_exmem;
  wire isfromram_exmem;

  wire [31: 0] opnum1_exalu;
  wire [31: 0] opnum2_exalu;
  wire [3: 0] sel_exalu;
  wire [4: 0] shiftbit_exalu;

  wire [31: 0] alunum_aluex;
  wire wen_memwb;
  wire [31: 0] rdnum_memwb;
  wire [4: 0] rd_memwb;
  wire pcen_memwb;
  wire [31: 0] pcchan_memwb;
  wire [31: 0] data_from_ram_memwb;
  wire isfromram_memwb;
  wire bt0en_memram;
  wire bt1en_memram;
  wire bt2en_memram;
  wire bt3en_memram; 
  wire readen_memram;
  wire [31: 0] ramaddr_memram;
  wire [31: 0] ramdata_memram;
  wire [31: 0] data_from_ram_rammem;

  wire wen_wbgpr;
  wire [31: 0] rdnum_wbgpr;
  wire [4: 0] rd_wbgpr;


  pc_reg pc0(
	.clk(clk),
	.rst(rst),
	.pcchan_in(pcchan_wbpc),
	.pcen_in(pcen_wbpc),
	.pc_out(pc_pcif)
  );

  inst_fetch if0(
	.pc_in(pc_pcif),
	.inst_out(inst_ifid),
	.pc_out(pc_ifid),
	.romaddr_out(romaddr_ifrom),
	.romdata_in(romdata_romif)
  );

  rom rom0(
	.romaddr_in(romaddr_ifrom),
	.romdata_out(romdata_romif)
  );

  inst_decoder id(
	.inst_in(inst_ifid),
	.pc_in(pc_ifid),
	.pc_out(pc_idex),
	.opcode_out(opcode_idex),
	.rd_out(rd_idex),
	.funct3_out(funct3_idex),
	.funct7_out(funct7_idex),
	.Iimm_out(Iimm_idex),
	.Simm_out(Simm_idex),
	.Bimm_out(Bimm_idex),
	.Uimm_out(Uimm_idex),
	.Jimm_out(Jimm_idex),
	.rs1_out(rs1_idgpr),
	.rs2_out(rs2_idgpr)
  );

  ex ex0(
	.pc_in(pc_idex),
	.opcode_in(opcode_idex),
	.rd_in(rd_idex),
	.funct3_in(funct3_idex),
	.funct7_in(funct7_idex),
	.Iimm_in(Iimm_idex),
	.Simm_in(Simm_idex),
	.Bimm_in(Bimm_idex),
	.Uimm_in(Uimm_idex),
	.Jimm_in(Jimm_idex),
	.rs1num_in(rs1num_gprex),
	.rs2num_in(rs2num_gprex),
	.bt0en_out(bt0en_exmem),
	.bt1en_out(bt1en_exmem),
	.bt2en_out(bt2en_exmem),
	.bt3en_out(bt3en_exmem),
	.readen_out(readen_exmem),
	.ramaddr_out(ramaddr_exmem),
	.ramdata_out(ramdata_exmem),
	.load_width_out(load_width_exmem),
	.is_sign_extend_out(is_sign_extend_exmem),
	.wen(wen_exmem),
	.rdnum_out(rdnum_exmem),
	.rd_out(rd_exmem),
	.pcen_out(pcen_exmem),
	.pcchan_out(pcchan_exmem),
	.isfromram_out(isfromram_exmem),
	.opnum1_out(opnum1_exalu),
	.opnum2_out(opnum2_exalu),
	.sel_out(sel_exalu),
	.shiftbit_out(shiftbit_exalu),
	.alunum_in(alunum_aluex)
  );

  mem mem0(
	.bt0en_in(bt0en_exmem),
	.bt1en_in(bt1en_exmem),
	.bt2en_in(bt2en_exmem),
	.bt3en_in(bt3en_exmem),
	.readen_in(readen_exmem),
	.ramaddr_in(ramaddr_exmem),
	.ramdata_in(ramdata_exmem),
	.load_width_in(load_width_exmem),
	.is_sign_extend_in(is_sign_extend_exmem),
	.wen(wen_exmem),
	.rdnum_in(rdnum_exmem),
	.rd_in(rd_exmem),
	.pcen_in(pcen_exmem),
	.pcchan_in(pcchan_exmem),
	.isfromram_in(isfromram_exmem),
	.wen_out(wen_memwb),
	.rdnum_out(rdnum_memwb),
	.rd_out(rd_memwb),
	.pcen_out(pcen_memwb),
	.pcchan_out(pcchan_memwb),
	.data_from_ram_out(data_from_ram_memwb),
	.isfromram_out(isfromram_memwb),
	.bt0en_out(bt0en_memram),
	.bt1en_out(bt1en_memram),
	.bt2en_out(bt2en_memram),
	.bt3en_out(bt3en_memram),
	.readen_out(readen_memram),
	.ramaddr_out(ramaddr_memram),
	.ramdata_out(ramdata_memram),
	.data_from_ram_in(data_from_ram_rammem)
  );

  ram ram0(
	.clk(clk),
	.ramaddr_in(ramaddr_memram),
	.ramdata_in(ramdata_memram),
	.bt0en_in(bt0en_memram),
	.bt1en_in(bt1en_memram),
	.bt2en_in(bt2en_memram),
	.bt3en_in(bt3en_memram),
	.readen_in(readen_memram),
	.ramdata_out(data_from_ram_rammem)
  );

  wb wb0(
	.wen_in(wen_memwb),
	.rdnum_in(rdnum_memwb),
	.rd_in(rd_memwb),
	.pcen_in(pcen_memwb),
	.pcchan_in(pcchan_memwb),
	.data_from_ram_in(data_from_ram_memwb),
	.isfromram_in(isfromram_memwb),
	.wen_out(wen_wbgpr),
	.rdnum_out(rdnum_wbgpr),
	.rd_out(rd_wbgpr),
	.pcen_out(pcen_wbpc),
	.pcchan_out(pcchan_wbpc)
  );

  gpr gpr0(
	.clk(clk),
	.readaddr1_in(rs1_idgpr),
	.readaddr2_in(rs2_idgpr),
	.wen(wen_wbgpr),
	.wriaddr_in(rd_wbgpr),
	.wridata_in(rdnum_wbgpr),
	.readdata1_out(rs1num_gprex),
	.readdata2_out(rs2num_gprex)
  );

  alu alu0(
	.x_in(opnum1_exalu),
	.y_in(opnum2_exalu),
	.sel_in(sel_exalu),
	.shiftbit_in(shiftbit_exalu),
	.z_out(alunum_aluex)
  );
endmodule
