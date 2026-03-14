module pc_reg(
  //from btm clk
  input clk,
  input rst,
  //from wb
  input [31: 0] pcchan_in,
  input pcen_in,
  //to if
  output reg[31: 0] pc_out
);

  always@(posedge clk or posedge rst)begin
	if(rst == 1)
	  pc_out <= 0;
	else if(pcen_in == 1)
	  pc_out <= pcchan_in;
	else
	  pc_out <= pc_out + 32'd4;
  end
	  	  

endmodule
