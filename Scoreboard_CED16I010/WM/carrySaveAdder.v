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



module carrySaveOne(a,b,c,u,v);
input [15:0] a,b,c;
integer start;
output [17:0] u;
output [15:0]v;


generate
   genvar i;
   assign u[0]=a[0];
   halfAdder ha1(a[1],b[0],u[1],v[0]);
   
   for(i=2;i<16;i=i+1)
     begin
       fullAdder fa(a[i],b[i-1],c[i-2],u[i],v[i-1]); 
     end

halfAdder ha2(b[15],c[14],u[16],v[15]);
assign u[17]=c[15];
endgenerate

endmodule


module carrySaveTwoOne(a,b,c,u,v);
input [17:0] a,c;
input [15:0] b;
output [20:0] u;
output [17:0] v;

assign u[0]=a[0];
assign u[1]=a[1];
halfAdder ha1(a[2],b[0],u[2],v[0]);

generate
   genvar i;
    
   for(i=3;i<18;i=i+1)
     begin
       fullAdder fa(a[i],b[i-2],c[i-3],u[i],v[i-2]); 
     end

assign u[18]=c[15];
assign u[19]=c[16];
assign u[20]=c[17];
assign v[16]=0;
assign v[17]=0;            
endgenerate

endmodule



module carrySaveTwoTwo(a,b,c,u,v);
input [17:0] b;
input [15:0] a,c;
output [18:0] u;
output [17:0] v;

assign u[0]=a[0];

halfAdder ha1(a[1],b[0],u[1],v[0]);
halfAdder ha2(a[2],b[1],u[2],v[1]);
generate
   genvar i;
    
   for(i=3;i<16;i=i+1)
     begin
       fullAdder fa(a[i],b[i-1],c[i-3],u[i],v[i-1]); 
     end

halfAdder ha3(b[15],c[13],u[16],v[15]);
halfAdder ha4(b[16],c[14],u[17],v[16]);
halfAdder ha5(b[17],c[15],u[18],v[17]);
        
endgenerate



endmodule


module carrySaveThreeOne(a,b,c,u,v);
input [20:0] a;
input [17:0] b;
input [18:0] c;

output [23:0] u;
output [19:0] v;

assign u[0]=a[0];
assign u[1]=a[1];
assign u[2]=a[2];

halfAdder ha1(a[3],b[0],u[3],v[0]);
halfAdder ha2(a[4],b[1],u[4],v[1]);


generate
   genvar i;
    
   for(i=5;i<21;i=i+1)
     begin
       fullAdder fa(a[i],b[i-3],c[i-5],u[i],v[i-3]); 
     end

assign u[21]=c[16];
assign u[22]=c[17];
assign u[23]=c[18];
assign v[18]=0;
assign v[19]=0;
        
endgenerate



endmodule

module carrySaveThreeTwo(a,b,c,u,v);
input [17:0] a,c;
input [20:0] b;

output [22:0] u;
output [20:0] v;

assign u[0]=a[0];
assign u[1]=a[1];

halfAdder ha1(a[2],b[0],u[2],v[0]);
halfAdder ha2(a[3],b[1],u[3],v[1]);
halfAdder ha3(a[4],b[2],u[4],v[2]);

generate
   genvar i;
    
   for(i=5;i<18;i=i+1)
     begin
       fullAdder fa(a[i],b[i-2],c[i-5],u[i],v[i-2]); 
     end

   for(i=16;i<21;i=i+1)
     begin
       halfAdder ha(b[i],c[i-3],u[i+2],v[i]); 
     end
 
        
endgenerate



endmodule


module carrySaveFourOne(a,b,c,u,v);
input [23:0] a;
input [19:0] b;
input [22:0] c;

output [29:0] u;
output [25:0] v;

generate
   genvar i;
   for(i=0;i<4;i=i+1)
     begin
       assign u[i]=a[i]; 
     end
   
   for(i=4;i<7;i=i+1)
     begin
       halfAdder ha1(a[i],b[i-4],u[i],v[i-4]);
     end
    
   for(i=7;i<24;i=i+1)
     begin
       fullAdder fa(a[i],b[i-4],c[i-7],u[i],v[i-4]); 
     end

   for(i=24;i<30;i=i+1)
     begin
       assign u[i]=c[i-7];
       assign v[i-4]=0;    
     end
 
        
endgenerate



endmodule


module carrySaveFourTwo(a,b,c,u,v);
input [20:0] a;
input [15:0] b,c;

output [20:0] u;
output [16:0] v;

generate
   genvar i;
   for(i=0;i<4;i=i+1)
     begin
       assign u[i]=a[i]; 
     end
   
   halfAdder ha1(a[4],b[0],u[4],v[0]);

    
   for(i=5;i<20;i=i+1)
     begin
       fullAdder fa(a[i],b[i-4],c[i-5],u[i],v[i-4]); 
     end

   halfAdder ha2(a[20],c[15],u[20],v[16]);
        
endgenerate



endmodule


module carrySaveFive(a,b,c,u,v);
input [29:0] a;
input [25:0] b;
input [20:0] c;

output [30:0] u;
output [25:0] v;

generate
   genvar i;
   for(i=0;i<5;i=i+1)
     begin
       assign u[i]=a[i]; 
     end
   
   for(i=5;i<10;i=i+1)
     begin
       halfAdder ha1(a[i],b[i-5],u[i],v[i-5]);
     end
    
   for(i=10;i<30;i=i+1)
     begin
       fullAdder fa(a[i],b[i-5],c[i-10],u[i],v[i-5]); 
     end

   halfAdder ha2(b[25],c[20],u[30],v[25]);
        
endgenerate



endmodule


module carrySaveSix(a,b,c,u,v);
input [30:0] a;
input [25:0] b;
input [16:0] c;

output [31:0] u;
output [25:0] v;

generate
   genvar i;
   for(i=0;i<6;i=i+1)
     begin
       assign u[i]=a[i]; 
     end
   
   for(i=6;i<15;i=i+1)
     begin
       halfAdder ha1(a[i],b[i-6],u[i],v[i-6]);
     end
    
   for(i=15;i<31;i=i+1)
     begin
       fullAdder fa(a[i],b[i-6],c[i-15],u[i],v[i-6]); 
     end

   halfAdder ha2(b[25],c[16],u[31],v[25]);
        
endgenerate



endmodule



/*
module carrySave(a,b,c,u,v);
input [31:0]a,b,c;
output [31:0]u,v;

generate
   genvar i;
   assign v[0]=0;
   for(i=0;i<31;i=i+1)
     begin
       fullAdder fa(a[i],b[i],c[i],u[i],v[i+1]); 
     end
   assign u[i]=c[i];
endgenerate

endmodule

*/



