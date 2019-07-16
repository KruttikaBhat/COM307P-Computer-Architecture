//using k diagram, the table of kpg values was converted into the appropriate equations
//if we have y(i) and y(i+1) in our current state 
//then the next y1(i)= (y1(i)&y0(i+1)) | ( y1(i+1) & (~y0(i+1)) ) 
// and the next y0(i)= (~y1(i)) & y0(i) & (~y1(i+1)) & y0(i+1)

module kpg(y1j,y0j,y1i,y0i,out1,out0);//j=i+1
input y1i,y0i,y1j,y0j;
output out1,out0;
wire out1,out0;
assign out0= (~y1i) & y0i & (~y1j) & y0j;
assign out1= (y1i & y0j) | (y1j & (~y0j));

endmodule
