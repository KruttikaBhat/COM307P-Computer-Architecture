module regfile_tb();
reg [15:0]r1,r2,data,w;
reg clk,cr1,cr2,cw;
wire [15:0]d1,d2;

regfile i(r1,r2,w,cr1,cr2,cw,data,d1,d2,clk);

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,regfile_tb);

clk<=1'b0;
cr1<=0;
cr2<=0;
cw<=1;
w<=16'h0001;
data<=16'h0001;
#2
w<=16'h0002;
data<=16'h1401;
#2
w<=16'h0003;
data<=16'h0002;
#2
w<=16'h0004;
data<=16'habcd;
#2
w<=16'h0005;
data<=16'h0aac;
#2
cr1<=1;
cr2<=1;
r1<=16'h0001;
r2<=16'h0003;
w<=16'h1001;
data<=16'habcd;
#2
r1<=16'h0005;
r2<=16'h1001;
w<=16'h0007;
data<=16'h1111;
#10
$finish;
end

always begin
#1 clk=~clk;
end


always@(posedge clk) begin
    $display("Time : %2d r1:%h d1:%h r2:%h d2: %h  Clock: %b",$time,r1,d1,r2,d2,clk);
end

endmodule
