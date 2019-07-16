module data_cache(pc,signal,clk,writedata,newblockloaded,newblock,changedblock,dirtytag,getnewblock,readdata);   //signal 0->read, 1->write
input [15:0]pc,writedata;
input signal,newblockloaded,clk;
input [255:0]newblock;
output [255:0]changedblock;
output [5:0]dirtytag;
output [15:0]readdata;
output getnewblock;

reg hit,miss;
reg [15:0]cache[0:63][0:15];
reg [15:0]readdata;
reg [5:0]tag[0:63];
reg [255:0]changedblock;
reg [5:0]dirtytag;
reg dirty[0:63],valid[0:63];
reg getnewblock;



//cache assignment
initial begin
  //block 0, word 1  
  tag[0]<=6'b000000;
  valid[0]<=1'b1;
  //cache[0][1]<=16'h0ac1;
end




always@(posedge clk & ~hit & newblockloaded)begin
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
      tag[pc[9:4]]<=pc[15:10];
      getnewblock<=0; 
      dirty[pc[9:4]]<=0;
      if(~getnewblock & ~signal) begin   //read miss
        readdata<=cache[pc[9:4]][pc[3:0]];   
      end
      else if(~getnewblock & signal)begin  //write miss
        cache[pc[9:4]][pc[3:0]]<=writedata; 
        dirty[pc[9:4]]<=1;  
      end 
end 
  
  


always@(posedge clk) begin
  // checks if the the tag for the block in cache matches with the tag part of the address and will return 1 if it matches and the block is valid 
  hit<= (&(~(tag[pc[9:4]] ^ pc[15:10]))) & valid[pc[9:4]];
  
  if(hit & ~signal & ~newblockloaded) begin  //read hit
    readdata<=cache[pc[9:4]][pc[3:0]];
  end  
  else if(hit & signal & ~newblockloaded) begin //write hit
    cache[pc[9:4]][pc[3:0]]<=writedata;
    dirty[pc[9:4]]<=1;
  end
  else if(~hit) begin //miss
    getnewblock<=1;
    valid[pc[9:4]]<=0;
    if(dirty[pc[9:4]]) begin  //if dirty bit is 1 then we need to send block to the main memory before overwriting
      changedblock<={cache[pc[9:4]][15],cache[pc[9:4]][14],cache[pc[9:4]][13],cache[pc[9:4]][12],cache[pc[9:4]][11],cache[pc[9:4]][10],
                     cache[pc[9:4]][9],cache[pc[9:4]][8],cache[pc[9:4]][7],cache[pc[9:4]][6],cache[pc[9:4]][5],cache[pc[9:4]][4],
                     cache[pc[9:4]][3],cache[pc[9:4]][2],cache[pc[9:4]][1],cache[pc[9:4]][0]};
      dirtytag<=tag[pc[9:4]]; 
      dirty[pc[9:4]]<=0;              
                     
    end    
  end
  else if((hit & signal) || (miss & signal)) begin
    readdata<=16'hxxxx;
  end
 
end

endmodule
