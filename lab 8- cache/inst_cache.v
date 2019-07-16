module inst_cache(pc,signal,clk,newblock,newblockloaded,getnewblock,instr);
input [15:0]pc; //pc will have the instruction address 
input signal,clk;
input [255:0]newblock;
input newblockloaded; 
output [15:0]instr;
output getnewblock;


reg [15:0]instr;
reg getnewblock;
//wire newblockloaded;
reg newblocksignal;

reg [15:0]cache[0:63][0:15]; //64 blocks, 16 words per block, 1 word is 16 bits
reg [5:0]tag[0:63];
reg valid[0:63];


reg hit,miss;

//cache assignment
initial begin
  //block 0, word 1  
  tag[0]<=6'b000010;
  valid[0]<=1'b1;
  cache[0][1]<=16'h0ac1;
  //block 5, word 8
  tag[5]<=6'b011111;  //31  
  valid[5]<=1'b1;
  cache[5][8]<=16'h0050;


end


  always@(posedge clk & ~hit & signal & newblockloaded)begin
      cache[pc[9:4]][0]<=newblock[15:0];
      cache[pc[9:4]][1]<=newblock[31:16];
      cache[pc[9:4]][2]<=newblock[47:32];
      cache[pc[9:4]][3]<=newblock[63:48];
      cache[pc[9:4]][4]<=newblock[79:64];
      cache[pc[9:4]][5]<=newblock[95:80];
      cache[pc[9:4]][6]<=newblock[111:96];
      cache[pc[9:4]][7]<=newblock[127:112];
      cache[pc[9:4]][8]<=newblock[143:128];
      cache[pc[9:4]][9]<=newblock[159:144];
      cache[pc[9:4]][10]<=newblock[175:160];
      cache[pc[9:4]][11]<=newblock[191:176];
      cache[pc[9:4]][12]<=newblock[207:192];
      cache[pc[9:4]][13]<=newblock[223:208];
      cache[pc[9:4]][14]<=newblock[239:224];
      cache[pc[9:4]][15]<=newblock[255:240];
      valid[pc[9:4]]<=1;
      getnewblock<=0; 
      if(~getnewblock) begin
        instr<=cache[pc[9:4]][pc[3:0]];   
      end
  end  

always@(posedge clk) begin
  
  // checks if the the tag for the block in cache matches with the tag part of the address and will return 1 if it matches and the block is valid 
  hit<= (&(~(tag[pc[9:4]] ^ pc[15:10]))) & valid[pc[9:4]];
  //miss<=~((&(~(tag[pc[9:4]] ^ pc[15:11]))) & valid[pc[9:4]]);
  if(hit & signal) begin  //we got a hit and control signal is 1->fetch instruction
    instr<=cache[pc[9:4]][pc[3:0]];
  end  
  else if(~hit & signal) begin //we got a miss and control signal is 1->fetch instruction
    getnewblock<=1;
    valid[pc[9:4]]<=0;
    tag[pc[9:4]]<=pc[15:10];
  end
  else if((hit & ~signal) || (~hit & ~signal)) begin
    instr<=16'hxxxx;
  end
 
end



endmodule
