module mem(
  //from ex
  input bt0en_in,
  input bt1en_in,
  input bt2en_in,
  input bt3en_in,
  input readen_in,
  input [31: 0] ramaddr_in,
  input [31: 0] ramdata_in,
  input [1: 0] load_width_in,
  input is_sign_extend_in,

  input wen,
  input [31: 0] rdnum_in,
  input [4: 0] rd_in,
  input pcen_in,
  input [31: 0] pcchan_in,
  input isfromram_in,
  //to wb
  output wen_out,
  output [31: 0] rdnum_out,
  output [4: 0] rd_out,
  output pcen_out,
  output [31: 0] pcchan_out,

  output reg [31: 0] data_from_ram_out, 
  output isfromram_out,

  //to ram
  output bt0en_out,
  output bt1en_out,
  output bt2en_out,
  output bt3en_out,
  output readen_out, 
  output [31: 0] ramaddr_out,
  output [31: 0] ramdata_out, 
  //from ram
  input [31: 0] data_from_ram_in
);

  assign wen_out = wen;
  assign rdnum_out = rdnum_in;
  assign rd_out = rd_in;
  assign pcen_out = pcen_in;
  assign pcchan_out = pcchan_in;

  assign bt0en_out = bt0en_in;
  assign bt1en_out = bt1en_in;
  assign bt2en_out = bt2en_in;
  assign bt3en_out = bt3en_in;
  assign readen_out = readen_in;
  assign ramaddr_out = ramaddr_in;
  assign ramdata_out = ramdata_in;
  assign isfromram_out = isfromram_in;

  always@(*)begin
	case(load_width_in)
	  2'b0:begin
		case(ramaddr_in[1: 0])
		  2'b00: data_from_ram_out = {{24{is_sign_extend_in && data_from_ram_in[7]}}, data_from_ram_in[7: 0]};
		  2'b01: data_from_ram_out = {{24{is_sign_extend_in && data_from_ram_in[15]}}, data_from_ram_in[15: 8]};
		  2'b10: data_from_ram_out = {{24{is_sign_extend_in && data_from_ram_in[23]}}, data_from_ram_in[23: 16]};
		  2'b11: data_from_ram_out = {{24{is_sign_extend_in && data_from_ram_in[31]}}, data_from_ram_in[31: 24]};
		  default: data_from_ram_out = 32'b0;
		endcase
	  end		
	  2'b1:begin
		case(ramaddr_in[1])
		  1'b0: data_from_ram_out = {{16{is_sign_extend_in && data_from_ram_in[15]}}, data_from_ram_in[15: 0]};
		  1'b1: data_from_ram_out = {{16{is_sign_extend_in && data_from_ram_in[31]}}, data_from_ram_in[31: 16]};	  
		  default: data_from_ram_out = 32'b0;
		endcase
	  end
	  2'b10: data_from_ram_out = data_from_ram_in;
	  default: data_from_ram_out = 32'b0;
	endcase
  end

endmodule
