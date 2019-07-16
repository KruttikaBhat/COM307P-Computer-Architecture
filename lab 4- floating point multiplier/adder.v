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

module adder(a,b,s);
input [4:0]a,b;
output [4:0]s;
wire cin,cout,c0,c1,c2,c3;
assign cin=1'b0;

fullAdder fa0(cin,a[0],b[0],s[0],c0);
fullAdder fa1(c0,a[1],b[1],s[1],c1);
fullAdder fa2(c1,a[2],b[2],s[2],c2);
fullAdder fa3(c2,a[3],b[3],s[3],c3);
fullAdder fa4(c3,a[4],b[4],s[4],cout);

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


module subtractorMan(a,b,D1,cman);
input [20:0]a,b;
output [20:0]D1;
output cman;

wire [20:0]B1;
wire [30:0]c;

wire [20:0]bcomp=~b;

assign temp=1'b1;
halfAdder ha1(bcomp[0],temp,B1[0],c[0]);

generate
   genvar i;
   
   for(i=1;i<21;i=i+1)
     begin
       halfAdder h(bcomp[i],c[i-1],B1[i],c[i]);
     end

   assign cin=1'b0;
   fullAdder fa1(cin,a[0],B1[0],D1[0],c[10]);
   for(i=1;i<21;i=i+1)
     begin
       fullAdder f(c[i+9],a[i],B1[i],D1[i],c[i+10]);
     end

endgenerate

assign cman=c[30];


endmodule

