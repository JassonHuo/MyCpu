module wb(
  //from mem
  input [31: 0] pc_in,
  input [31: 0] inst_in,
  input wen_in,
  input [31: 0] rdnum_in,
  input [4: 0] rd_in,
  input pcen_in,
  input [31: 0] pcchan_in,
  input [31: 0] data_from_ram_in,
  input isfromram_in,

  //to gpr
  output wen_out,
  output [31: 0] rdnum_out,
  output [4: 0] rd_out,
  //to pc
  output pcen_out,
  output [31: 0] pcchan_out	
);

  assign wen_out = wen_in;
  assign rdnum_out = (isfromram_in == 1 ? data_from_ram_in: rdnum_in); 
  assign rd_out = rd_in;

  assign pcen_out = pcen_in;
  assign pcchan_out = pcchan_in;

endmodule
