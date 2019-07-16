`include "WM/partialProduct.v"
`include "WM/carrySaveAdder.v"
`include "WM/carryLookAhead.v"
module wallace(a,b,p,clk);
input [15:0]a,b;
input clk;
output [31:0]p;

wire [15:0] m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15;
wire [17:0] l10,l12,l14,l16,l18;
wire [15:0] l11,l13,l15,l17,l19;
wire [17:0] l21,l23,l25;
wire [18:0] l22;
wire [20:0] l20,l24;
wire [23:0] l30;
wire [19:0] l31;
wire [22:0] l32;
wire [20:0] l33;
wire [29:0] l40;
wire [25:0] l41;
wire [20:0] l42;
wire [16:0] l43;
wire [30:0] l50;
wire [25:0] l51;
wire [31:0] l60;
wire [25:0] l61;

assign a=`A;
assign b=`B;


//generate all the partial products

partialprod one0(a,b[0],m0);
partialprod one1(a,b[1],m1);
partialprod one2(a,b[2],m2);
partialprod one3(a,b[3],m3);
partialprod one4(a,b[4],m4);
partialprod one5(a,b[5],m5);
partialprod one6(a,b[6],m6);
partialprod one7(a,b[7],m7);
partialprod one8(a,b[8],m8);
partialprod one9(a,b[9],m9);
partialprod one10(a,b[10],m10);
partialprod one11(a,b[11],m11);
partialprod one12(a,b[12],m12);
partialprod one13(a,b[13],m13);
partialprod one14(a,b[14],m14);
partialprod one15(a,b[15],m15);


//level one
carrySaveOne cs0(m0,m1,m2,l10,l11);
carrySaveOne cs1(m3,m4,m5,l12,l13);
carrySaveOne cs2(m6,m7,m8,l14,l15);
carrySaveOne cs3(m9,m10,m11,l16,l17);
carrySaveOne cs4(m12,m13,m14,l18,l19);


//level two
carrySaveTwoOne cs5(l10,l11,l12,l20,l21);
carrySaveTwoTwo cs6(l13,l14,l15,l22,l23);
carrySaveTwoOne cs7(l16,l17,l18,l24,l25);



//level three
carrySaveThreeOne cs8(l20,l21,l22,l30,l31);
carrySaveThreeTwo cs9(l23,l24,l25,l32,l33);


//level four
carrySaveFourOne cs10(l30,l31,l32,l40,l41);
carrySaveFourTwo cs11(l33,l19,m15,l42,l43);



//level five
carrySaveFive cs12(l40,l41,l42,l50,l51);


//level six
carrySaveSix cs13(l50,l51,l43,l60,l61);


wire [31:0] a1,b1;
wire cout,cin;
assign cin=0;

assign a1=l60;
generate
   genvar i;
   for(i=0;i<7;i=i+1)
     begin
       assign b1[i]=0; 
     end
   for(i=7;i<32;i=i+1)
     begin
       assign b1[i]=l61[i-7]; 
     end
        
endgenerate


carryLookAhead cla(a1,b1,cin,p,cout,clk);


always @ (p) begin 
$monitor("a=%d, b=%d, product=%d",a,b,p);
end

initial begin
$dumpfile("test1.vcd");
$dumpvars(0,wallace);
end

endmodule
