`include "carryLookAhead.v"
module carryLookAhead_tb();
reg [15:0]ain,bin;
reg cin,clk;
wire [15:0]sum;
wire cout;
carryLookAhead a(ain,bin,cin,sum,cout,clk);

initial begin
cin=0;
ain=16'b1001010101001010; bin=16'b1101110101111001;
#5 ain=24; bin=1000;

end	

initial begin
clk=0;
#1 clk=~clk;

end

initial begin
$dumpfile("test2.vcd");
$dumpvars(0,carryLookAhead_tb);
$monitor("time=%2d a=%b, b=%b, s=%b, c=%b",$time, ain,bin,sum,cout);
end
endmodule


