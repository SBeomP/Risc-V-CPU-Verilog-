module inst_mem(inst, pc, clk, rst_n);

input clk, rst_n;
input [31:0] pc;
output [31:0] inst;

reg [31:0] inst_reg [0:400];
reg [31:0] temp_reg [0:400];

integer i,j;

assign inst = inst_reg[pc];

always @(*) 
begin
    if (!rst_n) 
	begin
		for(i=0;i<=400;i=i+1)
		begin
			inst_reg[i] <= 32'b0;
			temp_reg[i] <= 32'b0;
		end
    end
    else begin
		for(j=0;j<=400;j=j+1)
		begin
			inst_reg[j*4] <= temp_reg[j];
		end
	end
end


endmodule
