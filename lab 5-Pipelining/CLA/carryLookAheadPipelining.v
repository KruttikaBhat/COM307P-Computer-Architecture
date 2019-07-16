

module carryLookAhead(a,b,cin,s,co,clk);
input [15:0]a;
input [15:0]b;
input cin,clk;
output [15:0] s; 
output co;

wire [15:0]a,b,s;
wire cin;

reg [15:0]stemp,y0,y1,l11,l10,l21,l20,l31,l30,l41,l40,l51,l50;
reg [16:0]zeroth,zero1,zero2,zero3,zero4,zero5;


always @(posedge clk) begin
   y0<=a^b;   //This is the inital kpg values if you consider k=00, p=01 and g=10 where lsb is y0 and msb is y1 
   y1<= a&b; 
   zeroth[15:0] <=a^b;
   zeroth[16]<=cin;
end

generate
  genvar i;

//level 1
  for (i = 15; i > 0; i = i - 1) begin
    always @(posedge clk) begin
      l10[i]<= (~y1[i-1]) & y0[i-1] & (~y1[i]) & y0[i];
      l11[i]<= (y1[i-1] & y0[i]) | (y1[i] & (~y0[i]));
    end
  end

  always @(posedge clk) begin
    l10[0]<= (~zeroth[16]) & zeroth[16] & (~y1[0]) & y0[0];
    l11[0]<= (zeroth[16] & y0[0]) | (y1[0] & (~y0[0]));
    zero1<=zeroth;
  end

//level 2
  for (i = 15; i > 1; i = i - 1) begin
    always @(posedge clk) begin
      l20[i]<= (~l11[i-2]) & l10[i-2] & (~l11[i]) & l10[i];
      l21[i]<= (l11[i-2] & l10[i]) | (l11[i] & (~l10[i]));
      //kpg two(l11[i],l10[i],l11[i-2],l10[i-2],l21[i],l20[i]);  
    end 
  end

  always @(posedge clk) begin
    l20[1]<= (~zero1[16]) & zero1[16] & (~l11[1]) & l10[1];
    l21[1]<= (zero1[16] & l10[1]) | (l11[1] & (~l10[1]));
    //kpg two0(l11[1],l10[1],cin,cin,l21[1],l20[1]);
    l21[0]<=l11[0];
    l20[0]<=l10[0];
    zero2<=zero1; 
  end
  
//level 3
  for (i = 15; i > 3; i = i - 1) begin
    always @(posedge clk) begin 
      l30[i]<= (~l21[i-4]) & l20[i-4] & (~l21[i]) & l20[i];
      l31[i]<= (l21[i-4] & l20[i]) | (l21[i] & (~l20[i]));
    end
  end
  
  always @(posedge clk) begin 
    l30[3]<= (~zero2[16]) & zero2[16] & (~l21[3]) & l20[3];
    l31[3]<= (zero2[16] & l20[3]) | (l21[3] & (~l20[3]));
    zero3<=zero2;
  end

  for (i = 2; i >= 0; i = i - 1)begin
    always @(posedge clk) begin
      l31[i]<=l21[i];
      l30[i]<=l20[i];
    end
  end

//level four
  for (i = 15; i > 7; i = i - 1) begin
    always @(posedge clk) begin
      l40[i]<= (~l31[i-8]) & l30[i-8] & (~l31[i]) & l30[i];
      l41[i]<= (l31[i-8] & l30[i]) | (l31[i] & (~l30[i]));
    end
  end
  
  always @(posedge clk) begin
    l40[7]<= (~zero3[16]) & zero3[16] & (~l31[7]) & l30[7];
    l41[7]<= (zero3[16] & l30[7]) | (l31[7] & (~l30[7]));
    zero4<=zero3; 
  end

  for (i = 6; i >=0; i = i - 1) begin
    always @(posedge clk) begin
      l41[i]<=l31[i];
      l40[i]<=l30[i];
    end
  end

//level 5
  always @(posedge clk) begin
    l50[15]<= (~zero4[16]) & zero4[16] & (~l41[15]) & l40[15];
    l51[15]<= (zero4[16] & l40[15]) | (l41[15] & (~l40[15]));
    zero5<=zero4;
  end
  for (i = 14; i >= 0; i = i - 1)begin
    always @(posedge clk) begin
      l51[i]<=l41[i];
      l50[i]<=l40[i];
    end
  end

  
 
  assign s[0]=zero5[0]^zero5[16];
  assign s[15:1]=zero5[15:1]^l51[14:0];
  assign co=l51[15];
  
  endgenerate
endmodule





















