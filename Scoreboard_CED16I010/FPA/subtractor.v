module halfAdder(a,b,s,c);
input a,b;
output s,c;
assign s=a^b;
assign c=a&b;
endmodule

module fullAdder(a,b,c,s,cout);
input a,b,c;
output s,cout;
assign s=a^b^c;
assign cout=a&b | b&c | a&c;
endmodule


module muxTwotoOneTwo(I0,I1,A,O);
input [4:0]I0,I1;
input A;
output [4:0]O;

wire Abar=~A;

assign O[0]=~(~(I0[0]&A)&~(Abar&I1[0]));
assign O[1]=~(~(I0[1]&A)&~(Abar&I1[1]));
assign O[2]=~(~(I0[2]&A)&~(Abar&I1[2]));
assign O[3]=~(~(I0[3]&A)&~(Abar&I1[3]));
assign O[4]=~(~(I0[4]&A)&~(Abar&I1[4]));


endmodule

module subtractor(A, B, D, C);
input [4:0]A,B;
output [4:0]D;
output C;

wire [4:0]Bcomp=~B;
wire c0,c1,c2,c3,c4,temp,cin,c5,c6,c7,c8,c9,c10,c11,c12,c13;

wire [4:0]B1,D1,D2,D3;


assign temp=1'b1;

halfAdder ha1(Bcomp[0],temp,B1[0],c0);
halfAdder ha2(Bcomp[1],c0,B1[1],c1);
halfAdder ha3(Bcomp[2],c1,B1[2],c2);
halfAdder ha4(Bcomp[3],c2,B1[3],c3);
halfAdder ha5(Bcomp[4],c3,B1[4],c4);

assign cin=1'b0;

fullAdder fa1(cin,A[0],B1[0],D1[0],c5);
fullAdder fa2(c5,A[1],B1[1],D1[1],c6);
fullAdder fa3(c6,A[2],B1[2],D1[2],c7);
fullAdder fa4(c7,A[3],B1[3],D1[3],c8);
fullAdder fa5(c8,A[4],B1[4],D1[4],C);

assign D2=~D1;

halfAdder ha6(D2[0],temp,D3[0],c9);
halfAdder ha7(D2[1],c9,D3[1],c10);
halfAdder ha8(D2[2],c10,D3[2],c11);
halfAdder ha9(D2[3],c11,D3[3],c12);
halfAdder ha10(D2[4],c12,D3[4],c13);


muxTwotoOneTwo mux(D1,D3,C,D);


endmodule 

module subtractorMan(a,b,D1,cman);
input [9:0]a,b;
output [9:0]D1;
output cman;

wire [9:0]B1;
wire [18:0]c;

wire [9:0]bcomp=~b;

assign temp=1'b1;
halfAdder ha1(bcomp[0],temp,B1[0],c[0]);
halfAdder ha2(bcomp[1],c[0],B1[1],c[1]);
halfAdder ha3(bcomp[2],c[1],B1[2],c[2]);
halfAdder ha4(bcomp[3],c[2],B1[3],c[3]);
halfAdder ha5(bcomp[4],c[3],B1[4],c[4]);
halfAdder ha6(bcomp[5],c[4],B1[5],c[5]);
halfAdder ha7(bcomp[6],c[5],B1[6],c[6]);
halfAdder ha8(bcomp[7],c[6],B1[7],c[7]);
halfAdder ha9(bcomp[8],c[7],B1[8],c[8]);
halfAdder ha10(bcomp[9],c[8],B1[9],c[9]);

assign cin=1'b0;

fullAdder fa1(cin,a[0],B1[0],D1[0],c[10]);
fullAdder fa2(c[10],a[1],B1[1],D1[1],c[11]);
fullAdder fa3(c[11],a[2],B1[2],D1[2],c[12]);
fullAdder fa4(c[12],a[3],B1[3],D1[3],c[13]);
fullAdder fa5(c[13],a[4],B1[4],D1[4],c[14]);
fullAdder fa6(c[14],a[5],B1[5],D1[5],c[15]);
fullAdder fa7(c[15],a[6],B1[6],D1[6],c[16]);
fullAdder fa8(c[16],a[7],B1[7],D1[7],c[17]);
fullAdder fa9(c[17],a[8],B1[8],D1[8],c[18]);
fullAdder fa10(c[18],a[9],B1[9],D1[9],cman);


endmodule


module adder(a,b,cin,s,cout);
input [9:0]a,b;
input cin;
output [9:0]s;
output cout;


fullAdder fa0(cin,a[0],b[0],s[0],c0);
fullAdder fa1(c0,a[1],b[1],s[1],c1);
fullAdder fa2(c1,a[2],b[2],s[2],c2);
fullAdder fa3(c2,a[3],b[3],s[3],c3);
fullAdder fa4(c3,a[4],b[4],s[4],c4);
fullAdder fa5(c4,a[5],b[5],s[5],c5);
fullAdder fa6(c5,a[6],b[6],s[6],c6);
fullAdder fa7(c6,a[7],b[7],s[7],c7);
fullAdder fa8(c7,a[8],b[8],s[8],c8);
fullAdder fa9(c8,a[9],b[9],s[9],cout);


endmodule

module adderfour(a,b,s);
input [3:0]a,b;
input cin;
assign cin=1'b0;
output [3:0]s;
wire cout;

fullAdder fa0(cin,a[0],b[0],s[0],c0);
fullAdder fa1(c0,a[1],b[1],s[1],c1);
fullAdder fa2(c1,a[2],b[2],s[2],c2);
fullAdder fa3(c2,a[3],b[3],s[3],cout);

endmodule


module subtractorfour(a,b,D1);
input [3:0]a,b;
output [3:0]D1;


wire [3:0]B1;
wire [7:0]c;

wire [3:0]bcomp=~b;

assign temp=1'b1;
halfAdder ha1(bcomp[0],temp,B1[0],c[0]);
halfAdder ha2(bcomp[1],c[0],B1[1],c[1]);
halfAdder ha3(bcomp[2],c[1],B1[2],c[2]);
halfAdder ha4(bcomp[3],c[2],B1[3],c[3]);

assign cin=1'b0;

fullAdder fa1(cin,a[0],B1[0],D1[0],c[4]);
fullAdder fa2(c[4],a[1],B1[1],D1[1],c[5]);
fullAdder fa3(c[5],a[2],B1[2],D1[2],c[6]);
fullAdder fa4(c[6],a[3],B1[3],D1[3],c[7]);



endmodule


module subtractorfive(a,b,D1);
input [4:0]a,b;
output [4:0]D1;


wire [4:0]B1;
wire [9:0]c;

wire [4:0]bcomp=~b;

assign temp=1'b1;
halfAdder ha1(bcomp[0],temp,B1[0],c[0]);
halfAdder ha2(bcomp[1],c[0],B1[1],c[1]);
halfAdder ha3(bcomp[2],c[1],B1[2],c[2]);
halfAdder ha4(bcomp[3],c[2],B1[3],c[3]);
halfAdder ha5(bcomp[4],c[3],B1[4],c[4]);

assign cin=1'b0;

fullAdder fa1(cin,a[0],B1[0],D1[0],c[5]);
fullAdder fa2(c[5],a[1],B1[1],D1[1],c[6]);
fullAdder fa3(c[6],a[2],B1[2],D1[2],c[7]);
fullAdder fa4(c[7],a[3],B1[3],D1[3],c[8]);
fullAdder fa5(c[8],a[4],B1[4],D1[4],c[9]);



endmodule

