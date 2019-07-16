module setInitial();
endmodule

module inst_cache_tb();
wire getnewblock;
wire [15:0]instr;
reg newblockloaded;
reg signal,clk;
reg [15:0]pc;
reg [255:0] newblock;
reg [15:0]mainmem[0:4095][0:15];
inst_cache a(pc,signal,clk,newblock,newblockloaded,getnewblock,instr);

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,inst_cache_tb);
clk<=1'b0;

//hit
pc<=16'h7c58;    //0111 1100 0101 1000
signal<=1;
newblockloaded<=0;
a.hit=1'bx;
#8
//miss
pc<=16'h0001;   
signal<=1;         
newblockloaded<=0;
a.hit=1'bx;
mainmem[0][0] <=16'h1001;
mainmem[0][1] <=16'h1001;
mainmem[0][2] <=16'h1001;
mainmem[0][3] <=16'h1001;
mainmem[0][4] <=16'h1001;
mainmem[0][5] <=16'h1001;
mainmem[0][6] <=16'h1001;
mainmem[0][7] <=16'h1001;
mainmem[0][8] <=16'h1001;
mainmem[0][9] <=16'h1001;
mainmem[0][10] <=16'h1001;
mainmem[0][11] <=16'h1001;
mainmem[0][12] <=16'h1001;
mainmem[0][13] <=16'h1001;
mainmem[0][14] <=16'h1001;
mainmem[0][15] <=16'h1001;
#8




$finish;
end


always begin
#1 clk=~clk;
end

always@(posedge clk) begin
    $display("Time : %2d pc: %h signal:%b newblock:%h newblockloaded:%b getnewblock:%b Instruction : %h  hit:%b",$time,pc,signal,newblock,newblockloaded,getnewblock,instr,a.hit);
end

always@(getnewblock) begin
  newblock<={mainmem[pc[15:4]][15],mainmem[pc[15:4]][14],mainmem[pc[15:4]][13],mainmem[pc[15:4]][12],mainmem[pc[15:4]][11],
             mainmem[pc[15:4]][10],mainmem[pc[15:4]][9],mainmem[pc[15:4]][8],mainmem[pc[15:4]][7],mainmem[pc[15:4]][6],
             mainmem[pc[15:4]][5],mainmem[pc[15:4]][4],mainmem[pc[15:4]][3],mainmem[pc[15:4]][2],mainmem[pc[15:4]][1],mainmem[pc[15:4]][0]};
  newblockloaded<=1;
  //setInitial();
  //getnewblock<=0;

end

endmodule

