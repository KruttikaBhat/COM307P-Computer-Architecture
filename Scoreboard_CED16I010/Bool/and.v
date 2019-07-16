module andBoolean(a,b,y);
input [31:0]a,b;
output [31:0]y;
assign a=`A;
assign b=`B;
assign y=a&b;

always @ (y) begin 
$monitor("a=%b, b=%b, AND=%b",a,b,y);
end

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,andBoolean);
end

endmodule
