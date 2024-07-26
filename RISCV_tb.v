`timescale 1ns/1ns
module RISCV_tb();

reg clk, rst_n, start;

RISCV rv (.clk(clk), .rst_n(rst_n), .start(start));

initial
begin 
	rst_n = 0;
	clk = 1;
	start = 0;
    #21
    rst_n = 1;
	#1
	start = 1;
	$readmemh("machine_for_test.txt", rv.im.temp_reg);
end

always
	#10 clk=~clk;

endmodule