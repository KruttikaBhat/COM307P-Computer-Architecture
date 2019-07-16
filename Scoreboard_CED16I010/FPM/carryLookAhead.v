`include "FPM/kpg.v"
module carryLookAhead(a,b,cin,s,co,clk);
input [21:0]a;
input [21:0]b;
input cin,clk;
output [21:0] s; 
output co;
wire [21:0]stemp,y0,y1,l11,l10,l21,l20,l31,l30,l41,l40,l51,l50,l61,l60;

assign stemp=a^b;  //initial sum
assign y0=stemp;   //This is the inital kpg values if you consider k=00, p=01 and g=10 where lsb is y0 and msb is y1 
assign y1= a&b;    //then from the truth table we see that y0=a^b and y1=a&b

generate
  genvar i;

  //level 1
  for (i = 21; i > 0; i = i - 1)
    begin
      kpg one(y1[i],y0[i],y1[i-1],y0[i-1],l11[i],l10[i]); 
    end
  kpg one0(y1[0],y0[0],cin,cin,l11[0],l10[0]);
  
  //level 2
  for (i = 21; i > 1; i = i - 1)
    begin
      kpg two(l11[i],l10[i],l11[i-2],l10[i-2],l21[i],l20[i]); 
    end
  kpg two0(l11[1],l10[1],cin,cin,l21[1],l20[1]);
  assign l21[0]=l11[0];
  assign l20[0]=l10[0];
  

  //level 3
  for (i = 21; i > 3; i = i - 1)
    begin
      kpg three(l21[i],l20[i],l21[i-4],l20[i-4],l31[i],l30[i]); 
    end
  kpg three0(l21[3],l20[3],cin,cin,l31[3],l30[3]);
  for (i = 2; i >= 0; i = i - 1)
    begin
      assign l31[i]=l21[i];
      assign l30[i]=l20[i];
    end
  
  //level four
  for (i = 21; i > 7; i = i - 1)
    begin
      kpg four(l31[i],l30[i],l31[i-8],l30[i-8],l41[i],l40[i]); 
    end

  kpg four0(l31[7],l30[7],cin,cin,l41[7],l40[7]);
  for (i = 6; i > -1; i = i - 1)
    begin
      assign l41[i]=l31[i];
      assign l40[i]=l30[i];
    end

  //level 5
  for (i = 21; i > 15; i = i - 1)
    begin
      kpg five(l41[i],l40[i],l41[i-16],l40[i-16],l51[i],l50[i]); 
    end
  
  kpg five0(l41[15],l40[15],cin,cin,l51[15],l50[15]);
  for (i = 14; i > -1; i = i - 1)
    begin
      assign l51[i]=l41[i];
      assign l50[i]=l40[i];
    end



  //final xor operation between the inital sum and the generated carries
  //We can xor with either l51 or l50 as both will be the same since p has been eliminated
 
  assign s[0]=stemp[0]^cin;

  for (i = 1; i <22 ; i = i + 1)
    begin
      assign s[i]=stemp[i]^l51[i-1]; 
    end
  
  assign co=l51[21];


endgenerate
endmodule


