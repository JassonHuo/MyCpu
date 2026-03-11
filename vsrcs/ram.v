module ram(
  input [31: 0] ramaddr_in,
  input [31: 0] ramdata_in,
  input bt0en_in,
  input bt1en_in,
  input bt2en_in,
  input bt3en_in,
  input clk,
  input readen_in,
  output reg [31: 0] ramdata_out
);

  reg [31: 0] ram_reg [0: 1023];   //需根据需求调整
  
  always@(*)begin
	if(readen_in)
	  ramdata_out = ram_reg[ramaddr_in[11: 2]];
	else
	  ramdata_out = 32'b0;
  end

  always@(posedge clk)begin
	if(bt0en_in)
	  ram_reg[ramaddr_in[11: 2]][7: 0] <= ramdata_in[7: 0];
	if(bt1en_in)
	  ram_reg[ramaddr_in[11: 2]][15: 8] <= ramdata_in[15: 8];
	if(bt2en_in)
	  ram_reg[ramaddr_in[11: 2]][23: 16] <= ramdata_in[23: 16];
	if(bt3en_in)
	  ram_reg[ramaddr_in[11: 2]][31: 24] <= ramdata_in[31: 24];
  end


endmodule
