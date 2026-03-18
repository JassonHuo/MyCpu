module barrel_shifter(
  input [31: 0] x_in,
  input [4: 0] shiftbit_in,
  input [3: 0] sel_in,
  output [31: 0] z_out
);


  parameter SLL = 4'd5, SRL = 4'd6, SRA = 4'd7;
  wire full;
  assign full = (sel_in == SRA && x_in[31] == 1);

  wire [31: 0] out_1, out_2, out_3, out_4;
  	  
  assign out_1 = (shiftbit_in[0] == 1 ? (sel_in == SLL ? ({x_in[30: 0], 1'b0}): ((sel_in == SRL | sel_in == SRA) ? ({full, x_in[31: 1]}):32'b0)): x_in);

  assign out_2 = (shiftbit_in[1] == 1 ? (sel_in == SLL ? ({out_1[29: 0], 2'b0}): ((sel_in == SRL | sel_in == SRA) ? ({{2{full}}, out_1[31: 2]}): 32'b0)): out_1);

  assign out_3 = (shiftbit_in[2] == 1 ? (sel_in == SLL ? ({out_2[27: 0], 4'b0}): ((sel_in == SRL | sel_in == SRA) ? ({{4{full}}, out_2[31: 4]}): 32'b0)): out_2);

  assign out_4 = (shiftbit_in[3] == 1 ? (sel_in == SLL ? ({out_3[23: 0], 8'b0}): ((sel_in == SRL | sel_in == SRA) ? ({{8{full}}, out_3[31: 8]}): 32'b0)): out_3);

  assign z_out = (shiftbit_in[4] == 1 ? (sel_in == SLL ? ({out_4[15: 0], 16'b0}): ((sel_in == SRL | sel_in == SRA) ? ({{16{full}}, out_4[31: 16]}): 32'b0)): out_4);

endmodule
