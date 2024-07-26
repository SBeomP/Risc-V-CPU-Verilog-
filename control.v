module control(inst, RegWrite, MemWrite, ALUcontrol, MemtoReg, ALUSrc, branch, JAL, AUIPC, LUI, JALR, immtype, MemRead);

input [31:0] inst;
output reg RegWrite, MemWrite, MemtoReg, ALUSrc, branch, JAL, AUIPC, LUI, JALR, MemRead;
output reg [4:0] ALUcontrol;
output reg [2:0] immtype;

wire [6:0] opcode;
wire [6:0] funct7;
wire [2:0] funct3;

assign opcode = inst[6:0];
assign funct7 = inst[31:25];
assign funct3 = inst[14:12];

always @(*) // RegWrite ,immtype
begin
	case(opcode)
		7'b011_0011: RegWrite <= 1'b1; // R-type
		7'b001_0011: begin
						immtype <= 3'b000;
						RegWrite <= 1'b1; // I-type Arithmetic
					 end
		7'b000_0011: begin
						immtype <= 3'b000;
						RegWrite <= 1'b1; // I-type Load
					 end
		7'b110_0111: begin
						immtype <= 3'b000;
						RegWrite <= 1'b1; // I-type JALR
					 end
		7'b010_0011: begin
						immtype <= 3'b001;
						RegWrite <= 1'b0; // S-type Store
					 end
		7'b110_0011: begin
						immtype <= 3'b010;
						RegWrite <= 1'b0; // B-type Branch
					 end
		7'b011_0111: begin
						immtype <= 3'b011;
						RegWrite <= 1'b1; // LUI
					 end
		7'b001_0111: begin
						immtype <= 3'b011;
						RegWrite <= 1'b1; // AUIPC
					 end
		7'b110_1111: begin
						immtype <= 3'b100;
						RegWrite <= 1'b1; // JAL 
					 end
		default: begin
					immtype <= 3'bx;
					RegWrite <= 1'b0;
				 end
	endcase
end

always @(*) // ALUcontrol
begin
	case(opcode)
		7'b011_0011:case({funct7,funct3}) // R-type 
						10'b000_0000_000: ALUcontrol <= 5'b00000; // ADD
						10'b010_0000_000: ALUcontrol <= 5'b10000; // SUB
						10'b000_0000_001: ALUcontrol <= 5'b00100; // SLL
						10'b000_0000_010: ALUcontrol <= 5'b10111; // SLT
						10'b000_0000_011: ALUcontrol <= 5'b11000; // SLTU
						10'b000_0000_100: ALUcontrol <= 5'b00011; // XOR
						10'b000_0000_101: ALUcontrol <= 5'b00101; // SRL
						10'b010_0000_101: ALUcontrol <= 5'b00110; // SRA
						10'b000_0000_110: ALUcontrol <= 5'b00010; // OR
						10'b000_0000_111: ALUcontrol <= 5'b00001; // AND
					    default: ALUcontrol <= 5'bxxxxx;
					endcase
		
		7'b110_0011: ALUcontrol <= 5'b10000; // B-type
		
		7'b001_0011:casex({funct7,funct3}) // I-type
						10'bxxx_xxxx_000: ALUcontrol <= 5'b00000; // ADDI
						10'bxxx_xxxx_010: ALUcontrol <= 5'b10111; // SLTI
						10'bxxx_xxxx_011: ALUcontrol <= 5'b11000; // SLTIU
						10'bxxx_xxxx_100: ALUcontrol <= 5'b00011; // XORI
						10'bxxx_xxxx_110: ALUcontrol <= 5'b00010; // ORI
						10'bxxx_xxxx_111: ALUcontrol <= 5'b00001; // ANDI
						10'b000_0000_001: ALUcontrol <= 5'b00100; // SLLI
						10'b000_0000_101: ALUcontrol <= 5'b00101; // SRLI
						10'b010_0000_101: ALUcontrol <= 5'b00110; // SRAI
						default: ALUcontrol <= 5'bxxxxx;
					endcase
		
		7'b000_0011:ALUcontrol <= 5'b00000; // I-type Load
		7'b110_0111:ALUcontrol <= 5'b00000; // I-type JALR
		7'b010_0011:ALUcontrol <= 5'b00000; // S-type
		7'b011_0111:ALUcontrol <= 5'b00000; // U-type LUI
		7'b001_0111:ALUcontrol <= 5'b00000; // U-type AUIPC
		default: ALUcontrol <= 5'bxxxxx; //                                           
    endcase  
end

always @(*) // ALUSrc
begin
	case(opcode)
		7'b011_0011: ALUSrc <= 1'b0; // R-type
		7'b001_0011: ALUSrc <= 1'b1; // I-type Arithmetic
		7'b000_0011: ALUSrc <= 1'b1; // I-type Load
		7'b110_0111: ALUSrc <= 1'b1; // I-type JALR
		7'b010_0011: ALUSrc <= 1'b1; // S-type Store
		7'b110_0011: ALUSrc <= 1'b0; // B-type Branch
		7'b011_0111: ALUSrc <= 1'b1; // LUI
		7'b001_0111: ALUSrc <= 1'b0; // AUIPC
		7'b110_1111: ALUSrc <= 1'b1; // JAL 
		default: ALUSrc <= 1'bx;
	endcase
end

always @(*) // MemtoReg
begin
	case(opcode)
		7'b011_0011: MemtoReg <= 1'b0; // R-type
		7'b001_0011: MemtoReg <= 1'b0; // I-type Arithmetic
		7'b000_0011: MemtoReg <= 1'b1; // I-type Load
		7'b110_0111: MemtoReg <= 1'b0; // I-type JALR
		7'b010_0011: MemtoReg <= 1'b0; // S-type Store
		7'b110_0011: MemtoReg <= 1'b0; // B-type Branch
		7'b011_0111: MemtoReg <= 1'b0; // LUI
		7'b001_0111: MemtoReg <= 1'b0; // AUIPC
		7'b110_1111: MemtoReg <= 1'b0; // JAL 
		default: MemtoReg <= 1'bx;
	endcase
end

always @(*) // MemWrite
begin
	case(opcode)
		7'b011_0011: MemWrite <= 1'b0; // R-type
		7'b001_0011: MemWrite <= 1'b0; // I-type Arithmetic
		7'b000_0011: MemWrite <= 1'b0; // I-type Load
		7'b110_0111: MemWrite <= 1'b0; // I-type JALR
		7'b010_0011: MemWrite <= 1'b1; // S-type Store
		7'b110_0011: MemWrite <= 1'b0; // B-type Branch
		7'b011_0111: MemWrite <= 1'b0; // LUI
		7'b001_0111: MemWrite <= 1'b0; // AUIPC
		7'b110_1111: MemWrite <= 1'b0; // JAL 
		default: MemWrite <= 1'bx;
	endcase
end

always @(*)
begin
	if(opcode == 7'b0000011)
		MemRead <= 1'b1;
	else
		MemRead <= 1'b0;
end





always @(*) // branch
begin
	case(opcode)
		7'b011_0011: branch <= 1'b0; // R-type
		7'b001_0011: branch <= 1'b0; // I-type Arithmetic
		7'b000_0011: branch <= 1'b0; // I-type Load
		7'b110_0111: branch <= 1'b0; // I-type JALR
		7'b010_0011: branch <= 1'b0; // S-type Store
		7'b110_0011: branch <= 1'b1; // B-type Branch
		7'b011_0111: branch <= 1'b0; // LUI
		7'b001_0111: branch <= 1'b0; // AUIPC
		7'b110_1111: branch <= 1'b0; // JAL 
		default: branch <= 1'bx;
	endcase
end

always @(*) // JAL
begin
	case(opcode)
		7'b011_0011: JAL <= 1'b0; // R-type
		7'b001_0011: JAL <= 1'b0; // I-type Arithmetic
		7'b000_0011: JAL <= 1'b0; // I-type Load
		7'b110_0111: JAL <= 1'b0; // I-type JALR
		7'b010_0011: JAL <= 1'b0; // S-type Store
		7'b110_0011: JAL <= 1'b0; // B-type Branch
		7'b011_0111: JAL <= 1'b0; // LUI
		7'b001_0111: JAL <= 1'b0; // AUIPC
		7'b110_1111: JAL <= 1'b1; // JAL 
		default: JAL <= 1'bx;
	endcase
end

always @(*) // AUIPC
begin
	case(opcode)
		7'b011_0011: AUIPC <= 1'b0; // R-type
		7'b001_0011: AUIPC <= 1'b0; // I-type Arithmetic
		7'b000_0011: AUIPC <= 1'b0; // I-type Load
		7'b110_0111: AUIPC <= 1'b0; // I-type JALR
		7'b010_0011: AUIPC <= 1'b0; // S-type Store
		7'b110_0011: AUIPC <= 1'b0; // B-type Branch
		7'b011_0111: AUIPC <= 1'b0; // LUI
		7'b001_0111: AUIPC <= 1'b1; // AUIPC
		7'b110_1111: AUIPC <= 1'b0; // JAL 
		default: AUIPC <= 1'bx;
	endcase
end

always @(*) // LUI
begin
	case(opcode)
		7'b011_0011: LUI <= 1'b0; // R-type
		7'b001_0011: LUI <= 1'b0; // I-type Arithmetic
		7'b000_0011: LUI <= 1'b0; // I-type Load
		7'b110_0111: LUI <= 1'b0; // I-type JALR
		7'b010_0011: LUI <= 1'b0; // S-type Store
		7'b110_0011: LUI <= 1'b0; // B-type Branch
		7'b011_0111: LUI <= 1'b1; // LUI
		7'b001_0111: LUI <= 1'b0; // AUIPC
		7'b110_1111: LUI <= 1'b0; // JAL 
		default: LUI <= 1'bx;
	endcase
end

always @(*) // JALR
begin
	case(opcode)
		7'b011_0011: JALR <= 1'b0; // R-type
		7'b001_0011: JALR <= 1'b0; // I-type Arithmetic
		7'b000_0011: JALR <= 1'b0; // I-type Load
		7'b110_0111: JALR <= 1'b1; // I-type JALR
		7'b010_0011: JALR <= 1'b0; // S-type Store
		7'b110_0011: JALR <= 1'b0; // B-type Branch
		7'b011_0111: JALR <= 1'b0; // LUI
		7'b001_0111: JALR <= 1'b0; // AUIPC
		7'b110_1111: JALR <= 1'b0; // JAL 
		default: JALR <= 1'bx;
	endcase
end


endmodule