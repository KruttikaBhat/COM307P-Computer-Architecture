`include "FPM/wallaceMultiplier.v"
`include "FPM/adder.v"


module round(a,out);
input [20:0]a;
output [9:0]out;

wire [20:0]sm,mid,big;
wire [9:0]add,cout;
assign sm[20:11]=a[20:11];
assign sm[10:0]=11'b00000000000;

assign mid[20:11]=sm[20:11];
assign mid[10]=1;
assign mid[9:0]=sm[9:0];

assign add=10'b0000000001;

generate
   genvar i;
   halfAdder h(sm[11],add[0],big[11],cout[0]);
   for(i=1;i<10;i=i+1)
     begin
       fullAdder f(sm[i+11],add[i],cout[i-1],big[i+11],cout[i]);
     end
   

wire b;
wire [20:0]d;
subtractorMan s(a,mid,d,b);
//if b=1-> a>mid round to big, if b=0->a<mid round to small

     for(i=0;i<10;i=i+1)
       begin
         assign out[i]=~(~(sm[i+11]&~b)&~(big[i+11]&b)); 
       end
   
endgenerate

endmodule


module multiplier(a,b,p,clk);
input [15:0]a,b;
input clk;
output [15:0]p;

wire [4:0]bias,after,exp,ePlusone,temp;
wire [21:0]prod;
wire [15:0]NaN,zero,inf,p1;

assign a=`A;
assign b=`B;

assign NaN[14:0]=15'b111111111111111;
assign inf[14:0]=15'b111110000000000;
assign zero[14:0]=15'b000000000000000;

wire aNaN,bNaN,aZero,bZero,aInf,bInf,temp2,temp3,temp4;
assign aNaN=(&a[14:10])&(|a[9:0]);
assign bNaN=(&b[14:10])&(|b[9:0]);
assign aZero=~(|a); //1 if a is zero
assign bZero=~(|b);
assign aInf=(&a[14:10])&(~(|a[9:0])); //1 if a is infinity
assign bInf=(&b[14:10])&(~(|b[9:0]));

assign bias=5'b01111;
subtractorfive s1(a[14:10],bias,after);
adder a1(after,b[14:10],exp);

wallace w(a[9:0],b[9:0],prod,clk);
wire [4:0]one;
assign one=5'b00001;
adder a2(exp,one,ePlusone);

wire [20:0]man1,man2,man;
assign man1[20:1]=prod[19:0];
assign man1[0]=0;
assign man2[20:0]=prod[20:0];

generate
   genvar i;
   
   for(i=0;i<5;i=i+1)
     begin
      assign temp[i]=~(~(exp[i]&~prod[21])&~(ePlusone[i]&prod[21])); //0->previous exp; 1->exp+1
     end
   for(i=0;i<21;i=i+1)
     begin
      assign man[i]=~(~(man1[i]&~prod[21])&~(man2[i]&prod[21])); //0->man1; 1->man2
     end


assign temp2= (aNaN&bNaN) | (aInf&bNaN) | (aNaN&bInf) | (aZero&bNaN) | (aNaN&bZero) | (aInf&bZero) | (aZero&bInf); //if output should be NaN
assign temp3= (aInf&bInf) | (aInf& ~bInf & ~bZero & ~bNaN) | (bInf& ~aInf & ~aZero & ~aNaN); //if output should be infinity
assign temp4= (aZero&bZero) | (aZero& ~bInf & ~bZero & ~bNaN) | (bZero& ~aInf & ~aZero & ~aNaN); //if output should be zero



assign p1[15]=a[15]^b[15];
assign p1[14:10]=temp;

round r(man,p1[9:0]);

for(i=0;i<15;i=i+1)
     begin
      assign p[i]= temp2&NaN[i] | temp3&inf[i] | temp4&zero[i] | ~(temp2|temp3|temp4)&p1[i];
     end

endgenerate
assign p[15]=p1[15];

always @ (p) begin 
$monitor("a=%d, b=%d, p=%d",a,b,p);
end

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,multiplier);
end

endmodule
