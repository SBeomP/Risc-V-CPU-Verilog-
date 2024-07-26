module alumux(ALUSrc, rs2_data, imm, b);

input ALUSrc;
input [31:0] rs2_data, imm;
output [31:0] b;

assign b = ALUSrc ? imm : rs2_data;

endmodule