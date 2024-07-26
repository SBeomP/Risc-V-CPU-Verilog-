module regfile( input clk, rst_n,
				input RegWrite,
				input [4:0] rs1, rs2, rd,
				input [31:0] rd_data,
				output reg [31:0] rs1_data, rs2_data);
			
reg [31:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10;
reg [31:0] x11, x12, x13, x14, x15, x16, x17, x18, x19, x20;
reg [31:0] x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31;

always @(negedge rst_n)
begin
		x0 <= 32'b0;
		x1 <= 32'b0;
		x2 <= 32'b0;
		x3 <= 32'b0;
		x4 <= 32'b0;
		x5 <= 32'b0;
		x6 <= 32'b0;
		x7 <= 32'b0;
		x8 <= 32'b0;
		x9 <= 32'b0;
		x10 <= 32'b0;
		x11 <= 32'b0;
		x12 <= 32'b0;		
		x13 <= 32'b0;
		x14 <= 32'b0;
		x15 <= 32'b0;
		x16 <= 32'b0;
		x17 <= 32'b0;
		x18 <= 32'b0;
		x19 <= 32'b0;
		x20 <= 32'b0;
		x21 <= 32'b0;
		x22 <= 32'b0;
		x23 <= 32'b0;
		x24 <= 32'b0;		
		x25 <= 32'b0;
		x26 <= 32'b0;
		x27 <= 32'b0;
		x28 <= 32'b0;
		x29 <= 32'b0;
		x30 <= 32'b0;
		x31 <= 32'b0;
end


always @(posedge clk)
begin
	if(RegWrite)
	begin
		case(rd[4:0])
			5'd0: ;
			5'd1: x1 <= rd_data;
			5'd2: x2 <= rd_data;
			5'd3: x3 <= rd_data;
			5'd4: x4 <= rd_data;
			5'd5: x5 <= rd_data;
			5'd6: x6 <= rd_data;
			5'd7: x7 <= rd_data;
			5'd8: x8 <= rd_data;
			5'd9: x9 <= rd_data;
			5'd10: x10 <= rd_data;
			5'd11: x11 <= rd_data;
			5'd12: x12 <= rd_data;		
			5'd13: x13 <= rd_data;
			5'd14: x14 <= rd_data;
			5'd15: x15 <= rd_data;
			5'd16: x16 <= rd_data;
			5'd17: x17 <= rd_data;
			5'd18: x18 <= rd_data;
			5'd19: x19 <= rd_data;
			5'd20: x20 <= rd_data;
			5'd21: x21 <= rd_data;
			5'd22: x22 <= rd_data;
			5'd23: x23 <= rd_data;
			5'd24: x24 <= rd_data;		
			5'd25: x25 <= rd_data;
			5'd26: x26 <= rd_data;
			5'd27: x27 <= rd_data;
			5'd28: x28 <= rd_data;
			5'd29: x29 <= rd_data;
			5'd30: x30 <= rd_data;
			5'd31: x31 <= rd_data;
		endcase
	end
end



always @(*)
begin
	case(rs1[4:0])
		5'd0: rs1_data = 32'b0;
		5'd1: rs1_data = x1;
		5'd2: rs1_data = x2;
		5'd3: rs1_data = x3;
		5'd4: rs1_data = x4;
		5'd5: rs1_data = x5;
		5'd6: rs1_data = x6;
		5'd7: rs1_data = x7;
		5'd8: rs1_data = x8;
		5'd9: rs1_data = x9;
		5'd10: rs1_data = x10;
		5'd11: rs1_data = x11;
		5'd12: rs1_data = x12;		
		5'd13: rs1_data = x13;
		5'd14: rs1_data = x14;
		5'd15: rs1_data = x15;
		5'd16: rs1_data = x16;
		5'd17: rs1_data = x17;
		5'd18: rs1_data = x18;
		5'd19: rs1_data = x19;
		5'd20: rs1_data = x20;
		5'd21: rs1_data = x21;
		5'd22: rs1_data = x22;
		5'd23: rs1_data = x23;
		5'd24: rs1_data = x24;		
		5'd25: rs1_data = x25;
		5'd26: rs1_data = x26;
		5'd27: rs1_data = x27;
		5'd28: rs1_data = x28;
		5'd29: rs1_data = x29;
		5'd30: rs1_data = x30;
		5'd31: rs1_data = x31;
	endcase
end

always @(*)
begin
	case(rs2[4:0])
		5'd0: rs2_data = 32'b0;
		5'd1: rs2_data = x1;
		5'd2: rs2_data = x2;
		5'd3: rs2_data = x3;
		5'd4: rs2_data = x4;
		5'd5: rs2_data = x5;
		5'd6: rs2_data = x6;
		5'd7: rs2_data = x7;
		5'd8: rs2_data = x8;
		5'd9: rs2_data = x9;
		5'd10: rs2_data = x10;
		5'd11: rs2_data = x11;
		5'd12: rs2_data = x12;		
		5'd13: rs2_data = x13;
		5'd14: rs2_data = x14;
		5'd15: rs2_data = x15;
		5'd16: rs2_data = x16;
		5'd17: rs2_data = x17;
		5'd18: rs2_data = x18;
		5'd19: rs2_data = x19;
		5'd20: rs2_data = x20;
		5'd21: rs2_data = x21;
		5'd22: rs2_data = x22;
		5'd23: rs2_data = x23;
		5'd24: rs2_data = x24;		
		5'd25: rs2_data = x25;
		5'd26: rs2_data = x26;
		5'd27: rs2_data = x27;
		5'd28: rs2_data = x28;
		5'd29: rs2_data = x29;
		5'd30: rs2_data = x30;
		5'd31: rs2_data = x31;
	endcase
end

endmodule