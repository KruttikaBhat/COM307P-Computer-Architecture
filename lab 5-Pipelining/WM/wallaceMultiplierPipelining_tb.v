module wallaceMultiplier_tb();
reg [15:0]ain,bin;
reg clk;
wire [31:0]p;
wallace a(ain,bin,p,clk);

initial begin
clk=0;

ain<=16'h0002;
bin<=16'h0003;
#2
ain<=16'd8;
bin<=16'd12;

#2
ain=16'b1001010101001010; 
bin=16'b1101110101111001; //812771fa or 2166845946 (decimal)

#2
ain<=16'd32;
bin<=16'd32;
#2
ain<=16'd10;
bin<=16'd192;
#2
ain<=16'd11;
bin<=16'd192;

/*
    ain<=16'habcd;
    bin<=16'hbcde;
    #2;
    ain<=16'hffff;
    bin<=16'hffff;
    #2;
    ain<=16'hb29d;
    bin<=16'hffff;
    #2;
    ain<=16'h6540;
    bin<=16'h3216;
    #2;
    ain<=16'h3265;
    bin<=16'h2656;
    #2;
    ain<=16'h0000;
    bin<=16'h0000;
    #2;
    ain<=16'habce;
    bin<=16'hbcde;
    #2;
    ain<=16'hfffe;
    bin<=16'hffff;
    #2;
    ain<=16'hb29e;
    bin<=16'hffff;
    #2;
    ain<=16'h654e;
    bin<=16'h3216;
    #2;
    ain<=16'h326e;
    bin<=16'h2656;
    #2;
    ain<=16'h000e;
    bin<=16'h0000;
*/
/*#2
ain<=16'b0100010010101111;
bin<=16'b1010011111100000; 
#2
ain=16'b1001010101001010; 
bin=16'b1101110101111001;
#2
ain<=16'h1234;
bin<=16'h4321;
#2
ain<=16'h6789;
bin<=16'h9876;
#2
ain<=16'h0000;
bin<=16'h0000;
*/#40;

$finish;
end	

always begin
#1 clk=~clk;
end

always@(clk) begin
    $display("Time : %2d Input : %d %d Output : %d  Clock : %b",$time,ain,bin,p,clk);
end


initial begin
$dumpfile("test2.vcd");
$dumpvars(0,wallaceMultiplier_tb);
end

endmodule


