module regfile(r1,r2,w,cr1,cr2,cw,data,d1,d2,clk);
input [15:0]r1,r2,w,data;
input clk,cr1,cr2,cw;
output [15:0]d1,d2;

reg [15:0]mem[0:15];
reg [15:0]d1reg,d2reg;
  
  

always@(posedge clk & (|w[15:4]==0) & cw==1) begin
  mem[w]<=data;
end

always@(posedge clk & cr1==1) begin
  d1reg<=mem[r1];
end

always@(posedge clk & cr2==1) begin
  d2reg<=mem[r2];
end  

assign d1=d1reg;
assign d2=d2reg;


endmodule
