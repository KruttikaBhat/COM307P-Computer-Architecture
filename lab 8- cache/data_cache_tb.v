module data_cache_tb();
wire getnewblock;
wire [255:0]changedblock;
wire [15:0]readdata;
wire [5:0]dirtytag;
reg signal,clk,newblockloaded;
reg [15:0]pc;
reg [15:0]writedata;
reg [255:0] newblock;
reg [15:0]mainmem[0:4095][0:15];

data_cache a(pc,signal,clk,writedata,newblockloaded,newblock,changedblock,dirtytag,getnewblock,readdata);

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,data_cache_tb);
clk<=1'b0;

//write hit
pc<=16'h0001;
signal<=1;
newblockloaded<=0;
writedata<=16'h0011;
a.hit<=1'bx;
#8
//read hit
pc<=16'h0001;
signal<=0;
newblockloaded<=0;
writedata<=16'hxxxx;
a.hit<=1'bx;
#8
//read miss 
pc<=16'h0401; //0000 0100 0000 0001 , change the tag value so that we need to update the dirty block to main mem
signal<=0;
newblockloaded<=0;
a.hit<=1'bx;
mainmem[64][0] <=16'h1a01;
mainmem[64][1] <=16'h10b1;
mainmem[64][2] <=16'h1901;
mainmem[64][3] <=16'h0101;
mainmem[64][4] <=16'h1001;
mainmem[64][5] <=16'h1001;
mainmem[64][6] <=16'h1001;
mainmem[64][7] <=16'h1001;
mainmem[64][8] <=16'h1001;
mainmem[64][9] <=16'h1001;
mainmem[64][10] <=16'h1001;
mainmem[64][11] <=16'h1001;
mainmem[64][12] <=16'h1001;
mainmem[64][13] <=16'h1001;
mainmem[64][14] <=16'h1001;
mainmem[64][15] <=16'h1001;
#8
//write miss
pc<=16'h0001; //0000 0000 0000 0001 , change the tag value so that we need to update the dirty block to main mem
signal<=1;
newblockloaded<=0;
writedata<=16'h0197;
a.hit<=1'bx;

#8
//read hit
pc<=16'h0001;
signal<=0;
newblockloaded<=0;
writedata<=16'hxxxx;
a.hit<=1'bx;
#8
$finish;
end


always begin
#1 clk=~clk;
end

always@(posedge clk) begin
    $display("\nTime : %2d pc: %h signal:%b writedata:%h newblockloaded:%b newblock:%h changedblock:%h dirtybit:%b hit:%b dirtytag:%b getnewblock:%b readdata: %h",$time,pc,signal,writedata,newblockloaded,newblock,changedblock,a.dirty[pc[9:4]],a.hit,dirtytag,getnewblock,readdata);
end

always@(getnewblock) begin
  newblock<={mainmem[pc[15:4]][15],mainmem[pc[15:4]][14],mainmem[pc[15:4]][13],mainmem[pc[15:4]][12],mainmem[pc[15:4]][11],
             mainmem[pc[15:4]][10],mainmem[pc[15:4]][9],mainmem[pc[15:4]][8],mainmem[pc[15:4]][7],mainmem[pc[15:4]][6],
             mainmem[pc[15:4]][5],mainmem[pc[15:4]][4],mainmem[pc[15:4]][3],mainmem[pc[15:4]][2],mainmem[pc[15:4]][1],mainmem[pc[15:4]][0]};
  if(~(&(~(dirtytag^pc[15:10])))) begin
    mainmem[{dirtytag,pc[9:4]}][0]<=changedblock[15:0];
    mainmem[{dirtytag,pc[9:4]}][1]<=changedblock[31:16];
    mainmem[{dirtytag,pc[9:4]}][2]<=changedblock[47:32];
    mainmem[{dirtytag,pc[9:4]}][3]<=changedblock[63:48];
    mainmem[{dirtytag,pc[9:4]}][4]<=changedblock[79:64];
    mainmem[{dirtytag,pc[9:4]}][5]<=changedblock[95:80];
    mainmem[{dirtytag,pc[9:4]}][6]<=changedblock[111:96];
    mainmem[{dirtytag,pc[9:4]}][7]<=changedblock[127:112];
    mainmem[{dirtytag,pc[9:4]}][8]<=changedblock[143:128];
    mainmem[{dirtytag,pc[9:4]}][9]<=changedblock[159:144];
    mainmem[{dirtytag,pc[9:4]}][10]<=changedblock[175:160];
    mainmem[{dirtytag,pc[9:4]}][11]<=changedblock[191:176];
    mainmem[{dirtytag,pc[9:4]}][12]<=changedblock[207:192];
    mainmem[{dirtytag,pc[9:4]}][13]<=changedblock[223:208];
    mainmem[{dirtytag,pc[9:4]}][14]<=changedblock[239:224];
    mainmem[{dirtytag,pc[9:4]}][15]<=changedblock[255:240];
  end
  newblockloaded<=1;

end

endmodule

