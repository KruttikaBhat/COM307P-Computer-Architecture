module ifu(set,instr,clk);
input set,clk;
output [15:0]instr;
reg [15:0]imem[0:1023];

reg [15:0]pc,s;

//reg [15:0]p,s,g;
//reg [16:0]c;


always@(posedge clk & set) begin
  pc<=0;
  imem[0]<=16'h0001;
  imem[1]<=16'h0022;
  imem[2]<=16'h0100;
  imem[3]<=16'h0004;
  imem[4]<=16'h0605;
  imem[5]<=16'h0709;		
  imem[6]<=16'h0111;
  imem[7]<=16'h0518;
  imem[8]<=16'h1009;
  imem[9]<=16'h0d10;
  imem[10]<=16'ha011;
  imem[11]<=16'h0c12;
  imem[12]<=16'h0e00;
  imem[13]<=16'h00f1;
  imem[14]<=16'h0000;
  imem[15]<=16'h000c;

end

  
  always@(posedge clk & ~set)begin
  /*c[0]=1'b0;
  p=pc^10'b0000000001; //a^1=~a; a^0=a
  g=pc&10'b0000000001; //a&1=a; a&0=0 ; g[0]=pc[0]
  c[1]=pc[0];// c[1]=g[0]
  c[2]=&pc[1:0];// | p[1]&p[0]&c[0]; 
  c[3]=&pc[2:0];// | p[2]&p[1]&p[0]&c[0];
  c[4]=&pc[3:0];// | p[3]&p[2]&p[1]&p[0]&c[0];
  c[5]=&pc[4:0];//| p[4]&p[3]&p[2]&p[1]&p[0]&c[0];
  c[6]=&pc[5:0];// | p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&c[0];
  c[7]=&pc[6:0];// | p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&c[0];
  c[8]=&pc[7:0];// | p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&c[0];
  c[9]=&pc[8:0];// | p[8]&p[7]&p[6]&p[5]&p[4]&p[3]&p[2]&p[1]&p[0]&c[0];*/
  s[0]=~pc[0];
  s[1]=pc[1]^pc[0];
  s[2]=pc[2]^(&pc[1:0]);
  s[3]=pc[3]^(&pc[2:0]);
  s[4]=pc[4]^(&pc[3:0]);
  s[5]=pc[5]^(&pc[4:0]);
  s[6]=pc[6]^(&pc[5:0]);
  s[7]=pc[7]^(&pc[6:0]);
  s[8]=pc[8]^(&pc[7:0]);
  s[9]=pc[9]^(&pc[8:0]);
  s[10]=pc[10]^(&pc[9:0]);
  s[11]=pc[11]^(&pc[10:0]);
  s[12]=pc[12]^(&pc[11:0]);
  s[13]=pc[13]^(&pc[12:0]);
  s[14]=pc[14]^(&pc[13:0]);
  s[15]=pc[15]^(&pc[14:0]);
  pc<=s;
  end
  
  //pc<=pc+1'b1;


assign instr=imem[(pc & 16'b0000001111111111)];
endmodule
