`include "FPA/subtractor.v"
`include "FPA/barrelShifter.v"

module muxTwoToOneThree(a,b,a1,b1,ch,fam,fbm,h);
input [15:0]a,b,a1,b1;
input ch;
output [15:0]fam,fbm;
output h;

wire chbar=~ch;

generate
   genvar i;
   
   for(i=0;i<16;i=i+1)
     begin
       assign fam[i]=~(~(a1[i]&ch)&~(a[i]&chbar));
       assign fbm[i]=~(~(b1[i]&ch)&~(b[i]&chbar));
     end
endgenerate
wire eq,neq;
assign eq=1'b1;
assign neq=1'b0;

assign h=~(~(neq&ch)&~(eq&chbar));
endmodule


module getSmall(a,b,c,sm,big);
input [15:0]a,b;
input c;
output [15:0]sm,big; 

wire cbar=~c;

generate
   genvar i;
   
   for(i=0;i<16;i=i+1)
     begin
       assign big[i]=~(~(a[i]&c)&~(b[i]&cbar));
       assign sm[i]=~(~(b[i]&c)&~(a[i]&cbar));
     end

  

endgenerate



endmodule


module muxfinal(a,b,c,out);
input [15:0]a,b;
input c,w,x,y,z;
output [14:0]out;
wire cbar=~c;

generate
   genvar i;
   
   for(i=0;i<15;i=i+1)
     begin
       assign out[i]=~(~(a[i]&cbar)&~(b[i]&c));
     end
endgenerate

endmodule 

module normalize(sh,val,s,out);
input sh,val;
input [15:0]s;

output [15:0]out;

wire [9:0]sman1;
wire [4:0]exp1,cout;

assign sman1[0]=s[1];
assign sman1[1]=s[2];
assign sman1[2]=s[3];
assign sman1[3]=s[4];
assign sman1[4]=s[5];
assign sman1[5]=s[6];
assign sman1[6]=s[7];
assign sman1[7]=s[8];
assign sman1[8]=s[9];
assign sman1[9]=val;

fullAdder fa0(s[10],1'b1,1'b0,exp1[0],cout[0]);
fullAdder fa1(s[11],1'b0,cout[0],exp1[1],cout[1]);
fullAdder fa2(s[12],1'b0,cout[1],exp1[2],cout[2]);
fullAdder fa3(s[13],1'b0,cout[2],exp1[3],cout[3]);
fullAdder fa4(s[14],1'b0,cout[3],exp1[4],cout[4]);



wire shBar=~sh;

assign out[0]=~(~(sman1[0]&sh)&~(shBar&s[0]));
assign out[1]=~(~(sman1[1]&sh)&~(shBar&s[1]));
assign out[2]=~(~(sman1[2]&sh)&~(shBar&s[2]));
assign out[3]=~(~(sman1[3]&sh)&~(shBar&s[3]));
assign out[4]=~(~(sman1[4]&sh)&~(shBar&s[4]));
assign out[5]=~(~(sman1[5]&sh)&~(shBar&s[5]));
assign out[6]=~(~(sman1[6]&sh)&~(shBar&s[6]));
assign out[7]=~(~(sman1[7]&sh)&~(shBar&s[7]));
assign out[8]=~(~(sman1[8]&sh)&~(shBar&s[8]));
assign out[9]=~(~(sman1[9]&sh)&~(shBar&s[9]));

assign out[10]=~(~(exp1[0]&sh)&~(shBar&s[10]));
assign out[11]=~(~(exp1[1]&sh)&~(shBar&s[11]));
assign out[12]=~(~(exp1[2]&sh)&~(shBar&s[12]));
assign out[13]=~(~(exp1[3]&sh)&~(shBar&s[13]));
assign out[14]=~(~(exp1[4]&sh)&~(shBar&s[14]));

assign out[15]=s[15];

endmodule


module normalizediff(in,out);
input [15:0]in;
output [15:0]out;

wire [15:0]first;
wire [7:0]second;
wire [3:0]third;
wire [1:0]fourth;
wire [3:0]shift0,shift1,shift2,shift3,shift4;
assign shift0=4'b0000;
assign first[15:10]=6'b000000;
assign first[9:0]=in[9:0];

wire [3:0]temp1,temp2,temp3,temp4,temp5;
wire [3:0]add1,copy1,add2,copy2,add3,copy3,add4,add5;
wire level1,level2,level3,level4;

//level 1

assign level1=|first[15:8];
assign add1=4'b1000;
assign copy1=shift0;
adderfour a1(shift0,add1,temp1);
generate
   genvar i;
   for(i=0;i<4;i=i+1)
     begin
       assign shift1[i]=~(~(temp1[i]&~level1)&~(copy1[i]&level1));
     end
   for(i=0;i<8;i=i+1)
     begin
       assign second[i]=~(~(first[i]&~level1)&~(first[i+8]&level1));
     end


//level 2
assign level2=|second[7:4];
assign add2=4'b0100;
assign copy2=shift1;
adderfour a2(shift1,add2,temp2);


   for(i=0;i<4;i=i+1)
     begin
       assign shift2[i]=~(~(temp2[i]&~level2)&~(copy2[i]&level2));
     end
   for(i=0;i<4;i=i+1)
     begin
       assign third[i]=~(~(second[i]&~level2)&~(second[i+4]&level2));
     end



//level 3
assign level3=|third[3:2];
assign add3=4'b0010;
assign copy3=shift2;
adderfour a3(shift2,add3,temp3);


   
   for(i=0;i<4;i=i+1)
     begin
       assign shift3[i]=~(~(temp3[i]&~level3)&~(copy3[i]&level3));
     end
   for(i=0;i<2;i=i+1)
     begin
       assign fourth[i]=~(~(third[i]&~level3)&~(third[i+2]&level3));
     end


//level 4
wire check;
assign check=fourth[0]|fourth[1]; //if zero assign out to zeroAll

wire [14:0]zeroAll=16'b000000000000000;
wire [14:0]notZero;

assign level4=fourth[1];
assign add4=4'b0010;
assign add5=4'b0001;
adderfour a4(shift3,add4,temp4);
adderfour a5(shift3,add5,temp5);


   
   for(i=0;i<4;i=i+1)
     begin
       assign shift4[i]=~(~(temp4[i]&~level4)&~(temp5[i]&level4));
     end


wire [3:0]temp,shift5;
wire [4:0]shift6;
assign temp=4'b0110;
subtractorfour s1(shift4,temp,shift5);
barrelShifterLeft s(in[9:0],shift5,notZero[9:0]);

assign shift6[4]=1'b0;
assign shift6[3:0]=shift5;
subtractorfive s2(in[14:10],shift6,notZero[14:10]);

for(i=0;i<15;i=i+1)
     begin
       assign out[i]=~(~(zeroAll[i]&~check)&~(notZero[i]&check));
     end

endgenerate

assign out[15]=in[15];
endmodule


module floatingPoint(a,b,op,s);
input [15:0]a,b;
input clk,op;
output [15:0]s;

wire [15:0] smequal,bigequal,sm,big,sm1,sm2,fam,fbm,fam1,fbm1,sum,sum1,sum2,sum3,sum4,sum5,sum6;
wire [4:0]d,d1;
wire [9:0]dman;
wire [3:0]d2;
wire c,cman,check,c1,units,seconds,cin;
wire biggerNE,biggerE,bigger,hidden,shift;

assign a=`A;
assign b=`B;
assign op=`C;

//check exponent value
subtractor diff(a[14:10],b[14:10],d,c);
subtractorMan diff2(a[9:0],b[9:0],dman,cman);

assign biggerNE=~c;
assign biggerE=~cman;

//check if difference is 0 
assign check=d[0]|d[1]|d[2]|d[3]|d[4];

getSmall cmpman(a,b,cman,smequal,bigequal);

//change start index to that which has higher exponent value

getSmall cmp(a[15:0],b[15:0],c,sm,big);

wire allZero=|sm[14:0];
wire [15:0]smZero,bigOne;
wire allOnes=&big[14:10];
assign bigOne=big;


//add zeros in the beginning of the mantissa for the number which has smaller exponent
subtractor s1(d,5'b00001,d1,c1); //removes 1 from difference

assign sm1[15]=sm[15];
assign sm1[14:10]=big[14:10];
muxTwotoOne m0(sm[9],1'b1,1'b0,sm1[9]);   //shift the 1 before the decimal to the right
generate
   genvar i;
   
   for(i=8;i>=0;i=i-1)
     begin
       muxTwotoOne m1(sm[i],sm[i+1],1'b0,sm1[i]); 
     end

endgenerate

//use barrel shifter to shift mantissa bits to the right
assign d2[0]=d1[0];
assign d2[1]=d1[1];
assign d2[2]=d1[2];
assign d2[3]=d1[3];

assign sm2[15:10]=sm1[15:10];

barrelShifter sh(sm1[9:0],d2,sm2[9:0]);

muxTwoToOneThree m1(bigequal,smequal,big,sm2,check,fam,fbm,hidden); //if exponents were same then those values are copied to fam and fbm
assign bigger=~(~(biggerNE&check)&~(biggerE&(~check)));


//perform addition
assign sum[15:10]=fam[15:10];
assign sum2[15:10]=fam[15:10];


assign cin=1'b0;
adder a0(fam[9:0],fbm[9:0],cin,sum[9:0],cout);
subtractorMan a1(fam[9:0],fbm[9:0],sum2[9:0],cout2);



assign shift=cout|hidden;
assign value=~(cout^hidden);
assign value2=cout2^hidden;

assign s[15]=(a[15]&(~bigger)) | (a[15]&b[15]&(~op)) | (b[15]&(~op)&bigger) | ((~a[15])&(~b[15])&op&bigger) | (a[15]&(~b[15])&op);

//bring the index back and get the exponent value 
normalize n(shift,value,sum,sum1); 
normalizediff n2(sum2,sum3);

generate

   
   for(i=0;i<16;i=i+1)
     begin
       assign sum4[i]=~(~(sum3[i]&~value2)&~(sum2[i]&value2));
     end

  

endgenerate
assign final= op^(a[15]^b[15]); //0 s=sum1, 1 s=sum4

muxfinal f(sum1,sum4,final,sum5[14:0]);

assign sum6[14:0]= allZero? sum5[14:0]:big[14:0]; //allZero=1, sum6=sum5 
assign s[14:0]= ~allOnes? sum6[14:0]:big[14:0];


always @ (s) begin 
$monitor("op=%b, a=%d, b=%d, s=%d",op,a,b,s);
end

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,floatingPoint);
end

endmodule
