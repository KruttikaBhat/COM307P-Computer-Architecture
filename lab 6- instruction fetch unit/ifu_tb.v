module ifu_tb();
wire [15:0]instr;
reg set,clk;

ifu a(set,instr,clk);

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,ifu_tb);

 
clk<=1'b0;
set<=1'b1;
#2
set<=1'b0;
#100
$finish;
end

always begin
#1 clk=~clk;
end

always@(instr) begin
    $display("Time : %2d Set:%b Instruction : %h  Clock : %b",$time,set,instr,clk);
end


endmodule
