module RISCV(clk, rst_n, start);

input clk, rst_n, start;
reg [31:0] pc;

wire RegWrite, MemWrite, MemRead, MemtoReg, ALUSrc, branch, JAL, AUIPC, LUI, JALR, N, Z, C, V;
wire [31:0] imm, b, ReadData, result, inst, rd_data, rs1_data, rs2_data;
wire [4:0] rs1, rs2, rd, ALUcontrol;
wire [2:0] immtype;
wire [2:0] funct3;

wire beq, bne, blt, bge, bltu, bgeu;
wire beq_taken, bne_taken, blt_taken, bge_taken, bltu_taken, bgeu_taken, btaken;


assign funct3  = inst[14:12];

assign beq  = (funct3 == 3'b000);
assign bne  = (funct3 == 3'b001);
assign blt  = (funct3 == 3'b100);
assign bge  = (funct3 == 3'b101);
assign bltu = (funct3 == 3'b110);
assign bgeu = (funct3 == 3'b111);

assign beq_taken  =  branch & beq & Z;
assign bne_taken  =  branch & bne & ~Z;
assign blt_taken  =  branch & blt & (N!=V);
assign bge_taken  =  branch & bge & (N==V);
assign bltu_taken =  branch & bltu & ~C;
assign bgeu_taken =  branch & bgeu & C;
assign btaken =  beq_taken  | bne_taken | blt_taken | bge_taken | bltu_taken | bgeu_taken;
assign rs1 = inst[19:15];
assign rs2 = inst[24:20];
assign rd = inst[11:7];

inst_mem im (.clk(clk), .rst_n(rst_n), .pc(pc), .inst(inst));
regfile rf (.clk(clk), .RegWrite(RegWrite), .rs1(rs1), .rs2(rs2), .rd(rd), .rd_data(rd_data), .rs1_data(rs1_data), .rs2_data(rs2_data), .rst_n(rst_n));
control ct (.inst(inst), .RegWrite(RegWrite), .MemWrite(MemWrite), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUSrc(ALUSrc), .branch(branch), .JAL(JAL), .AUIPC(AUIPC), .LUI(LUI), .JALR(JALR), .ALUcontrol(ALUcontrol), .immtype(immtype));
alumux am (.ALUSrc(ALUSrc), .rs2_data(rs2_data), .imm(imm), .b(b));
alu au (.ALUcontrol(ALUcontrol), .a(rs1_data), .b(b), .result(result), .N(N), .Z(Z), .C(C), .V(V));
data_mem dm (.clk(clk), .rst_n(rst_n), .MemWrite(MemWrite), .result(result), .WriteData(rs2_data), .ReadData(ReadData), .funct3(funct3), .MemRead(MemRead));
memtoregmux mm(.MemtoReg(MemtoReg), .result(result), .ReadData(ReadData), .rd_data(rd_data), .JAL(JAL), .pc(pc), .JALR(JALR), .imm(imm), .JAL(JAL), .AUIPC(AUIPC));
immgen ig (.immtype(immtype), .inst(inst), .imm(imm));





always @(posedge clk) // branch, JAL, JALR , pc블록
begin
	if(!rst_n) pc <= 32'b0;

	else if(start)
	begin
		if(btaken) pc <= pc + imm;
		else if(JAL) pc <= pc + imm;
		else if(JALR) pc <= rs1_data + imm;
		else pc <= pc + 4;
	end
	
	else;
end

endmodule
