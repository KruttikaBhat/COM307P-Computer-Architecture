module multiplier_tb();
reg [15:0]a,b;
reg clk;
wire [15:0]p;

multiplier m(a,b,p,clk);

initial begin
a=16'b0100010110101101; //0100111000101011
b=16'b0100010001011001;
#5
a=16'b1100011100000000; //0101001100000000; 7*8=56
b=16'b1100100000000000;
//infinity*0=NaN
//infinity*infinity=infinity
//infinity*NaN=NaN
//0*NaN=NaN
//0*0=0
//NaN*NaN=NaN
//normal*infinity=infinity
//normal*0=0
//a=16'b0000000000000000; //0100111000101011
//b=16'b0000000000000000;
end


initial begin
clk=0;
#1 clk=~clk;
end

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,multiplier_tb);
$monitor("time=%2d a=%b, b=%b, p=%b",$time,a,b,p);
end


endmodule
