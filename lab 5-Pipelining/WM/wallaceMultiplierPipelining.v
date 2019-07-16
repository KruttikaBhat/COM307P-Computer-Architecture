
module wallace(a,b,p,clk);
input [15:0]a,b;
input clk;
output [31:0]p;

wire [15:0] m0,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15;

reg [17:0] l10,l12,l14,l16,l18;
reg [15:0] l11,l13,l15,l17,l19,l191,l192,m151,m152,m153;
reg [17:0] l21,l23,l25;
reg [18:0] l22;
reg [20:0] l20,l24;
reg [23:0] l30;
reg [19:0] l31;
reg [22:0] l32;
reg [20:0] l33;
reg [29:0] l40;
reg [25:0] l41;
reg [20:0] l42;
reg [16:0] l43,l431;
reg [30:0] l50;
reg [25:0] l51;
reg [31:0] l60;
reg [31:0] l61;

reg [31:0] y0,y1,c11,c10,c21,c20,c31,c30,c41,c40,c51,c50,c61,c60;
reg [32:0]zeroth,zero1,zero2,zero3,zero4,zero5,zero6;

//generate all the partial products


assign m0[15:0]=b[0]?a[15:0]:16'b0; 
assign m1[15:0]=b[1]?a[15:0]:16'b0;
assign m2[15:0]=b[2]?a[15:0]:16'b0; 
assign m3[15:0]=b[3]?a[15:0]:16'b0; 
assign m4[15:0]=b[4]?a[15:0]:16'b0; 
assign m5[15:0]=b[5]?a[15:0]:16'b0; 
assign m6[15:0]=b[6]?a[15:0]:16'b0; 
assign m7[15:0]=b[7]?a[15:0]:16'b0; 
assign m8[15:0]=b[8]?a[15:0]:16'b0; 
assign m9[15:0]=b[9]?a[15:0]:16'b0; 
assign m10[15:0]=b[10]?a[15:0]:16'b0; 
assign m11[15:0]=b[11]?a[15:0]:16'b0; 
assign m12[15:0]=b[12]?a[15:0]:16'b0; 
assign m13[15:0]=b[13]?a[15:0]:16'b0; 
assign m14[15:0]=b[14]?a[15:0]:16'b0; 
assign m15[15:0]=b[15]?a[15:0]:16'b0; 
always @(posedge clk) begin  
//level one

l10[0]<=m0[0];
l12[0]<=m3[0];
l14[0]<=m6[0];
l16[0]<=m9[0];
l18[0]<=m12[0];
//half adder
l10[1]<=m0[1]^m1[0];
l11[0]<=m0[1]&m1[0];
l12[1]<=m3[1]^m4[0];
l13[0]<=m3[1]&m4[0];
l14[1]<=m6[1]^m7[0];
l15[0]<=m6[1]&m7[0];
l16[1]<=m9[1]^m10[0];
l17[0]<=m9[1]&m10[0];
l18[1]<=m12[1]^m13[0];
l19[0]<=m12[1]&m13[0];
//full adder
l10[15:2]<=m0[15:2]^m1[14:1]^m2[13:0];
l11[14:1]<=m0[15:2]&m1[14:1] | m1[14:1]&m2[13:0] | m0[15:2]&m2[13:0];
l12[15:2]<=m3[15:2]^m4[14:1]^m5[13:0];
l13[14:1]<=m3[15:2]&m4[14:1] | m4[14:1]&m5[13:0] | m3[15:2]&m5[13:0];
l14[15:2]<=m6[15:2]^m7[14:1]^m8[13:0];
l15[14:1]<=m6[15:2]&m7[14:1] | m7[14:1]&m8[13:0] | m6[15:2]&m8[13:0];
l16[15:2]<=m9[15:2]^m10[14:1]^m11[13:0];
l17[14:1]<=m9[15:2]&m10[14:1] | m10[14:1]&m11[13:0] | m9[15:2]&m11[13:0];
l18[15:2]<=m12[15:2]^m13[14:1]^m14[13:0];
l19[14:1]<=m12[15:2]&m13[14:1] | m13[14:1]&m14[13:0] | m12[15:2]&m14[13:0];
//half adder
l10[16]<=m1[15]^m2[14];
l11[15]<=m1[15]&m2[14];
l12[16]<=m4[15]^m5[14];
l13[15]<=m4[15]&m5[14];
l14[16]<=m7[15]^m8[14];
l15[15]<=m7[15]&m8[14];
l16[16]<=m10[15]^m11[14];
l17[15]<=m10[15]&m11[14];
l18[16]<=m13[15]^m14[14];
l19[15]<=m13[15]&m14[14];
//
l10[17]<=m2[15];
l12[17]<=m5[15];
l14[17]<=m8[15];
l16[17]<=m11[15];
l18[17]<=m14[15];
m151<=m15;


//level two
l20[1:0]<=l10[1:0];
l22[0]<=l13[0];
l24[1:0]<=l16[1:0];
//half adder
l20[2]<=l10[2]^l11[0];
l21[0]<=l10[2]&l11[0];

l22[2:1]<=l13[2:1]^l14[1:0];
l23[1:0]<=l13[2:1]&l14[1:0];

l24[2]<=l16[2]^l17[0];
l25[0]<=l16[2]&l17[0];
//full adder
l20[17:3]<=l10[17:3]^l11[15:1]^l12[14:0];
l21[15:1]<=l10[17:3]&l11[15:1] | l11[15:1]&l12[14:0] | l10[17:3]&l12[14:0];

l22[15:3]<=l13[15:3]^l14[14:2]^l15[12:0];
l23[14:2]<=l13[15:3]&l14[14:2] | l14[14:2]&l15[12:0] | l13[15:3]&l15[12:0];

l24[17:3]<=l16[17:3]^l17[15:1]^l18[14:0];
l25[15:1]<=l16[17:3]&l17[15:1] | l17[15:1]&l18[14:0] | l16[17:3]&l18[14:0];
//half adder
l22[18:16]<=l14[17:15]^l15[15:13];
l23[17:15]<=l14[17:15]&l15[15:13];
//
l20[20:18]<=l12[17:15];
l21[17:16]<=0;
l24[20:18]<=l18[17:15];
l25[17:16]<=0;
l191<=l19;
m152<=m151;


//level 3

//
l30[2:0]<=l20[2:0];
l32[1:0]<=l23[1:0];
//half adder
l30[4:3]<=l20[4:3]^l21[1:0];
l31[1:0]<=l20[4:3]&l21[1:0];

l32[4:2]<=l23[4:2]^l24[2:0];
l33[2:0]<=l23[4:2]&l24[2:0];

//full adder
l30[20:5]<=l20[20:5]^l21[17:2]^l22[15:0];
l31[17:2]<=l20[20:5]&l21[17:2] | l21[17:2]&l22[15:0] | l20[20:5]&l22[15:0];

l32[17:5]<=l23[17:5]^l24[15:3]^l25[12:0];
l33[15:3]<=l23[17:5]&l24[15:3] | l24[15:3]&l25[12:0] | l23[17:5]&l25[12:0];
//half adder
l32[22:18]<=l24[20:16]^l25[17:13];
l33[20:16]<=l24[20:16]&l25[17:13];
//
l30[23:21]<=l22[18:16];
l31[19:18]<=0;
l192<=l191;
m153<=m152;



//level four

//
l40[3:0]<=l30[3:0];
l42[3:0]<=l33[3:0];
//half adder
l40[6:4]<=l30[6:4]^l31[2:0];
l41[2:0]<=l30[6:4]&l31[2:0];
l42[4]<=l33[4]^l192[0];
l43[0]<=l33[4]&l192[0];
//full adder
l40[23:7]<=l30[23:7]^l31[20:3]^l32[16:0];
l41[19:3]<=l30[23:7]&l31[20:3] | l31[20:3]&l32[16:0] | l30[23:7]&l32[16:0];
l42[19:5]<=l33[19:5]^l192[15:1]^m153[14:0];
l43[15:1]<=l33[19:5]&l192[15:1] | l192[15:1]&m153[14:0] | l33[19:5]&m153[14:0];
//half adder
l42[20]<=l33[20]^m153[15];
l43[16]<=l33[20]&m153[15];
//
l40[29:24]<=l32[22:17];
l41[25:20]<=0;


//level five

//
l50[4:0]<=l40[4:0];
//half adder
l50[9:5]<=l40[9:5]^l41[4:0];
l51[4:0]<=l40[9:5]&l41[4:0];
//full adder
l50[29:10]<=l40[29:10]^l41[24:5]^l42[19:0];
l51[24:5]<=l40[29:10]&l41[24:5] | l41[24:5]&l42[19:0] | l40[29:10]&l42[19:0];
//half adder
l50[30]<=l41[25]^l42[20];
l51[25]<=l41[25]&l42[20];
l431<=l43;



//level six

//
l60[5:0]<=l50[5:0];
l61[6:0]<=0;
//half adder
l60[14:6]<=l50[14:6]^l51[8:0];
l61[15:7]<=l50[14:6]&l51[8:0];
//full adder
l60[30:15]<=l50[30:15]^l51[24:9]^l431[15:0];
l61[31:16]<=l50[30:15]&l51[24:9] | l51[24:9]&l431[15:0] | l50[30:15]&l431[15:0];
//half adder
l60[31]<=l51[25]^l431[16];

   
   y0<=l60^l61;   //This is the inital kpg values if you consider k=00, p=01 and g=10 where lsb is y0 and msb is y1 
   y1<= l60&l61; 
   zeroth[31:0] <=l60^l61;
   zeroth[32]<=cin;
end

wire cout,cin;
assign cin=0;


generate
  genvar i;

//level 1
  for (i = 31; i > 0; i = i - 1) begin
    always @(posedge clk) begin
      c10[i]<= (~y1[i-1]) & y0[i-1] & (~y1[i]) & y0[i];
      c11[i]<= (y1[i-1] & y0[i]) | (y1[i] & (~y0[i]));
    end
  end

  always @(posedge clk) begin
    c10[0]<= (~zeroth[32]) & zeroth[32] & (~y1[0]) & y0[0];
    c11[0]<= (zeroth[32] & y0[0]) | (y1[0] & (~y0[0]));
    zero1<=zeroth;
  end

//level 2
  for (i = 31; i > 1; i = i - 1) begin
    always @(posedge clk) begin
      c20[i]<= (~c11[i-2]) & c10[i-2] & (~c11[i]) & c10[i];
      c21[i]<= (c11[i-2] & c10[i]) | (c11[i] & (~c10[i]));
      //kpg two(l11[i],l10[i],l11[i-2],l10[i-2],l21[i],l20[i]);  
    end 
  end

  always @(posedge clk) begin
    c20[1]<= (~zero1[32]) & zero1[32] & (~c11[1]) & c10[1];
    c21[1]<= (zero1[32] & c10[1]) | (c11[1] & (~c10[1]));
    //kpg two0(l11[1],l10[1],cin,cin,l21[1],l20[1]);
    c21[0]<=c11[0];
    c20[0]<=c10[0];
    zero2<=zero1; 
  end
  
//level 3
  for (i = 31; i > 3; i = i - 1) begin
    always @(posedge clk) begin 
      c30[i]<= (~c21[i-4]) & c20[i-4] & (~c21[i]) & c20[i];
      c31[i]<= (c21[i-4] & c20[i]) | (c21[i] & (~c20[i]));
    end
  end
  
  always @(posedge clk) begin 
    c30[3]<= (~zero2[32]) & zero2[32] & (~c21[3]) & c20[3];
    c31[3]<= (zero2[32] & c20[3]) | (c21[3] & (~c20[3]));
    zero3<=zero2;
  end

  for (i = 2; i >= 0; i = i - 1)begin
    always @(posedge clk) begin
      c31[i]<=c21[i];
      c30[i]<=c20[i];
    end
  end

//level four
  for (i = 31; i > 7; i = i - 1) begin
    always @(posedge clk) begin
      c40[i]<= (~c31[i-8]) & c30[i-8] & (~c31[i]) & c30[i];
      c41[i]<= (c31[i-8] & c30[i]) | (c31[i] & (~c30[i]));
    end
  end
  
  always @(posedge clk) begin
    c40[7]<= (~zero3[32]) & zero3[32] & (~c31[7]) & c30[7];
    c41[7]<= (zero3[32] & c30[7]) | (c31[7] & (~c30[7]));
    zero4<=zero3; 
  end

  for (i = 6; i >=0; i = i - 1) begin
    always @(posedge clk) begin
      c41[i]<=c31[i];
      c40[i]<=c30[i];
    end
  end

//level 5
  for (i = 31; i > 15; i = i - 1) begin
    always @(posedge clk) begin
      c50[i]<= (~c41[i-16]) & c40[i-16] & (~c41[i]) & c40[i];
      c51[i]<= (c41[i-16] & c40[i]) | (c41[i] & (~c40[i]));
    end
  end
  always @(posedge clk) begin
    c50[15]<= (~zero4[32]) & zero4[32] & (~c41[15]) & c40[15];
    c51[15]<= (zero4[32] & c40[15]) | (c41[15] & (~c40[15]));
    zero5<=zero4;
  end
  for (i = 14; i >= 0; i = i - 1)begin
    always @(posedge clk) begin
      c51[i]<=c41[i];
      c50[i]<=c40[i];
    end
  end


//level 6
  always @(posedge clk) begin
    c60[31]<= (~zero5[32]) & zero5[32] & (~c51[31]) & c50[31];
    c61[31]<= (zero5[32] & c50[31]) | (c51[31] & (~c50[31]));
    zero6<=zero5;
  end
  for (i = 30; i >= 0; i = i - 1)begin
    always @(posedge clk) begin
      c61[i]<=c51[i];
      c60[i]<=c50[i];
    end
  end

endgenerate


  assign p[0]=zero6[0]^zero6[32];
  assign p[31:1]=zero6[31:1]^c61[30:0];
  assign co=c61[31];
  
endmodule
