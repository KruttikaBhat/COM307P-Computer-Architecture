module carryLookAhead_tb();
reg [15:0]ain,bin;
reg cin,clk;
wire [15:0]sum;
wire cout;
carryLookAhead a(ain,bin,cin,sum,cout,clk);

initial begin
clk=0;
$dumpfile("test2.vcd");
$dumpvars(0,carryLookAhead_tb);

ain<=16'h0002;
bin<=16'h0003;
cin<=1'b0;
#2
ain<=16'b0000000000001000;
bin<=16'b0000000000010010;
#2
ain<=16'b0100010010101111;
bin<=16'b1010011111100000; //1110110010001111 cout=0
#2
ain=16'b1001010101001010; 
bin=16'b1101110101111001; //0111001011000011 cout=1
#2
ain<=16'h1234;
bin<=16'h4321;
#2
ain<=16'h6789;
bin<=16'h9876;
#2
ain<=16'h0000;
bin<=16'h0000;
#2
ain<=16'h0002;
bin<=16'h0003;
#2
ain<=16'd8;
bin<=16'd12;
#2
ain<=16'd32;
bin<=16'd32;
#2
ain<=16'd10;
bin<=16'd192;
#2
ain<=16'd11;
bin<=16'd192;
#20;

$finish;
end	

always@(clk) begin
        $display("Time : %2d Input : %d %d Output : %b %d Clock : %b",$time,ain,bin,cout,sum,clk);
end

always begin
#1 clk=~clk;
end



endmodule


