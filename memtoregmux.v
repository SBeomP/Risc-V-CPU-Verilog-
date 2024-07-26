module memtoregmux(MemtoReg, result, ReadData, rd_data, JAL, pc, JALR, LUI, AUIPC, imm);

input MemtoReg, JAL, JALR, LUI, AUIPC;
input [31:0] result, ReadData, pc, imm;
output reg [31:0] rd_data;

always @(*)
begin
	if(MemtoReg) rd_data <= ReadData;
	else if(JAL) rd_data <= pc + 4;
	else if(JALR) rd_data <= pc + 4;
	else if(LUI) rd_data <= imm;
	else if(AUIPC) rd_data <= pc + imm;
	else rd_data <= result;
end

endmodule