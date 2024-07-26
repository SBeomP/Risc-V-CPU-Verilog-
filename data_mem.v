module data_mem(ReadData, result, WriteData, clk, rst_n, MemWrite, funct3, MemRead);

input [31:0] result, WriteData;
input clk, rst_n, MemWrite, MemRead;
input [2:0] funct3;
output reg [31:0] ReadData;

reg [7:0] Mem_Data [0:65535*4];
integer i;


always @ (posedge clk) 
begin
	if (MemWrite) 
	begin
		case(funct3)
			3'b000 : Mem_Data[result+0] <= WriteData[7-:8]; //SB
					
			3'b001 : begin // SH
						Mem_Data[result+1] <= WriteData[15-:8];
						Mem_Data[result+0] <= WriteData[7-:8];
					 end
			3'b010 : begin // SW
						Mem_Data[result+3] <= WriteData[31-:8];
						Mem_Data[result+2] <= WriteData[23-:8];
						Mem_Data[result+1] <= WriteData[15-:8];
						Mem_Data[result+0] <= WriteData[7-:8];
					 end
			default : ;
		endcase
    end
	else;
end


always @(*) // LOAD 출력 결정
begin
	if(MemRead)
	begin
		case(funct3)
			3'b000 : ReadData = {{24{Mem_Data[result +0][7]}},Mem_Data[result +0]};
			3'b001 : ReadData = {{16{Mem_Data[result +1][7]}},Mem_Data[result +1],Mem_Data[result +0]};
			3'b010 : ReadData = {Mem_Data[result +3], Mem_Data[result+2], Mem_Data[result +1], Mem_Data[result +0]};
			3'b100 : ReadData = {24'b0,Mem_Data[result +0]};
			3'b101 : ReadData = {16'b0,Mem_Data[result +1],Mem_Data[result +0]};
			default : ;
		endcase
	end
	else
		ReadData = 32'bx;
end


endmodule
