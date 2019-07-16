//`include "wallaceMultiplier.v"
module wallaceMultiplier_tb();
reg [15:0]ain,bin;
reg clk;
wire [31:0]p;
wallace a(ain,bin,p,clk);

initial begin
ain=16'b1001010101001010; bin=16'b1101110101111001; //812771fa
#5 ain=32; bin=64;
end	

initial begin
clk=0;
#1 clk=~clk;

end

initial begin
$dumpfile("test2.vcd");
$dumpvars(0,wallaceMultiplier_tb);
$monitor("time=%2d a=%h, b=%h, product=%h",$time, ain,bin,p);
end
endmodule


