module muxTwotoOne(I0,I1,A,O);
input I0,I1;
input A;
output O;

wire Abar=~A;

assign O=~(~(I0&A)&~(Abar&I1));

endmodule



module barrelShifter(I,mag,O);
input [9:0]I;
input [3:0]mag;
output [9:0]O;

wire [9:0] O1,O2,O3;

//level 0
muxTwotoOne m00(I[9],1'b0,~mag[0],O1[9]);
muxTwotoOne m01(I[8],I[9],~mag[0],O1[8]); 
muxTwotoOne m02(I[7],I[8],~mag[0],O1[7]); 
muxTwotoOne m03(I[6],I[7],~mag[0],O1[6]); 
muxTwotoOne m04(I[5],I[6],~mag[0],O1[5]); 
muxTwotoOne m05(I[4],I[5],~mag[0],O1[4]); 
muxTwotoOne m06(I[3],I[4],~mag[0],O1[3]); 
muxTwotoOne m07(I[2],I[3],~mag[0],O1[2]); 
muxTwotoOne m08(I[1],I[2],~mag[0],O1[1]); 
muxTwotoOne m09(I[0],I[1],~mag[0],O1[0]); 


//level 1
muxTwotoOne m10(O1[9],1'b0,~mag[1],O2[9]);
muxTwotoOne m11(O1[8],1'b0,~mag[1],O2[8]);
muxTwotoOne m12(O1[7],O1[9],~mag[1],O2[7]);
muxTwotoOne m13(O1[6],O1[8],~mag[1],O2[6]);
muxTwotoOne m14(O1[5],O1[7],~mag[1],O2[5]);
muxTwotoOne m15(O1[4],O1[6],~mag[1],O2[4]);
muxTwotoOne m16(O1[3],O1[5],~mag[1],O2[3]);
muxTwotoOne m17(O1[2],O1[4],~mag[1],O2[2]);
muxTwotoOne m18(O1[1],O1[3],~mag[1],O2[1]);
muxTwotoOne m19(O1[0],O1[2],~mag[1],O2[0]);


//level 2
muxTwotoOne m20(O2[9],1'b0,~mag[2],O3[9]);
muxTwotoOne m21(O2[8],1'b0,~mag[2],O3[8]);
muxTwotoOne m22(O2[7],1'b0,~mag[2],O3[7]);
muxTwotoOne m23(O2[6],1'b0,~mag[2],O3[6]);
muxTwotoOne m24(O2[5],O2[9],~mag[2],O3[5]);
muxTwotoOne m25(O2[4],O2[8],~mag[2],O3[4]);
muxTwotoOne m26(O2[3],O2[7],~mag[2],O3[3]);
muxTwotoOne m27(O2[2],O2[6],~mag[2],O3[2]);
muxTwotoOne m28(O2[1],O2[5],~mag[2],O3[1]); 
muxTwotoOne m29(O2[0],O2[4],~mag[2],O3[0]);


//level 3
muxTwotoOne m30(O3[9],1'b0,~mag[3],O[9]);
muxTwotoOne m31(O3[8],1'b0,~mag[3],O[8]);
muxTwotoOne m32(O3[7],1'b0,~mag[3],O[7]);
muxTwotoOne m33(O3[6],1'b0,~mag[3],O[6]);
muxTwotoOne m34(O3[5],1'b0,~mag[3],O[5]);
muxTwotoOne m35(O3[4],1'b0,~mag[3],O[4]);
muxTwotoOne m36(O3[3],1'b0,~mag[3],O[3]);
muxTwotoOne m37(O3[2],1'b0,~mag[3],O[2]);
muxTwotoOne m38(O3[1],O3[9],~mag[3],O[1]);
muxTwotoOne m39(O3[0],O3[8],~mag[3],O[0]);





endmodule

module barrelShifterLeft(I,mag,O);
input [9:0]I;
input [3:0]mag;
output [9:0]O;

wire [9:0] O1,O2,O3;

//level 0
muxTwotoOne m00(I[0],1'b0,~mag[0],O1[0]);
muxTwotoOne m01(I[1],I[0],~mag[0],O1[1]); 
muxTwotoOne m02(I[2],I[1],~mag[0],O1[2]); 
muxTwotoOne m03(I[3],I[2],~mag[0],O1[3]); 
muxTwotoOne m04(I[4],I[3],~mag[0],O1[4]); 
muxTwotoOne m05(I[5],I[4],~mag[0],O1[5]); 
muxTwotoOne m06(I[6],I[5],~mag[0],O1[6]); 
muxTwotoOne m07(I[7],I[6],~mag[0],O1[7]); 
muxTwotoOne m08(I[8],I[7],~mag[0],O1[8]); 
muxTwotoOne m09(I[9],I[8],~mag[0],O1[9]); 


//level 1
muxTwotoOne m10(O1[0],1'b0,~mag[1],O2[0]);
muxTwotoOne m11(O1[1],1'b0,~mag[1],O2[1]);
muxTwotoOne m12(O1[2],O1[0],~mag[1],O2[2]);
muxTwotoOne m13(O1[3],O1[1],~mag[1],O2[3]);
muxTwotoOne m14(O1[4],O1[2],~mag[1],O2[4]);
muxTwotoOne m15(O1[5],O1[3],~mag[1],O2[5]);
muxTwotoOne m16(O1[6],O1[4],~mag[1],O2[6]);
muxTwotoOne m17(O1[7],O1[5],~mag[1],O2[7]);
muxTwotoOne m18(O1[8],O1[6],~mag[1],O2[8]);
muxTwotoOne m19(O1[9],O1[7],~mag[1],O2[9]);


//level 2
muxTwotoOne m20(O2[0],1'b0,~mag[2],O3[0]);
muxTwotoOne m21(O2[1],1'b0,~mag[2],O3[1]);
muxTwotoOne m22(O2[2],1'b0,~mag[2],O3[2]);
muxTwotoOne m23(O2[3],1'b0,~mag[2],O3[3]);
muxTwotoOne m24(O2[4],O2[0],~mag[2],O3[4]);
muxTwotoOne m25(O2[5],O2[1],~mag[2],O3[5]);
muxTwotoOne m26(O2[6],O2[2],~mag[2],O3[6]);
muxTwotoOne m27(O2[7],O2[3],~mag[2],O3[7]);
muxTwotoOne m28(O2[8],O2[4],~mag[2],O3[8]); 
muxTwotoOne m29(O2[9],O2[5],~mag[2],O3[9]);


//level 3
muxTwotoOne m30(O3[0],1'b0,~mag[3],O[0]);
muxTwotoOne m31(O3[1],1'b0,~mag[3],O[1]);
muxTwotoOne m32(O3[2],1'b0,~mag[3],O[2]);
muxTwotoOne m33(O3[3],1'b0,~mag[3],O[3]);
muxTwotoOne m34(O3[4],1'b0,~mag[3],O[4]);
muxTwotoOne m35(O3[5],1'b0,~mag[3],O[5]);
muxTwotoOne m36(O3[6],1'b0,~mag[3],O[6]);
muxTwotoOne m37(O3[7],1'b0,~mag[3],O[7]);
muxTwotoOne m38(O3[8],O3[0],~mag[3],O[8]);
muxTwotoOne m39(O3[9],O3[1],~mag[3],O[9]);





endmodule
