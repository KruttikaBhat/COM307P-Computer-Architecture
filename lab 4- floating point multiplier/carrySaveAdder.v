
module carrySaveOne(a,b,c,u,v);
input [10:0] a,b,c;
integer start;
output [12:0] u;
output [10:0]v;


generate
   genvar i;
   assign u[0]=a[0];
   halfAdder ha1(a[1],b[0],u[1],v[0]);
   
   for(i=2;i<11;i=i+1)
     begin
       fullAdder fa(a[i],b[i-1],c[i-2],u[i],v[i-1]); 
     end

halfAdder ha2(b[10],c[9],u[11],v[10]);
assign u[12]=c[10];
endgenerate

endmodule


module carrySaveTwoOne(a,b,c,u,v);
input [12:0] a,c;
input [10:0] b;
output [15:0] u;
output [12:0] v;

assign u[0]=a[0];
assign u[1]=a[1];
halfAdder ha1(a[2],b[0],u[2],v[0]);

generate
   genvar i;
    
   for(i=3;i<13;i=i+1)
     begin
       fullAdder fa(a[i],b[i-2],c[i-3],u[i],v[i-2]); 
     end

assign u[13]=c[10];
assign u[14]=c[11];
assign u[15]=c[12];
assign v[11]=0;
assign v[12]=0;            
endgenerate

endmodule



module carrySaveTwoTwo(a,b,c,u,v);
input [12:0] b;
input [10:0] a,c;
output [13:0] u;
output [12:0] v;

assign u[0]=a[0];

halfAdder ha1(a[1],b[0],u[1],v[0]);
halfAdder ha2(a[2],b[1],u[2],v[1]);
generate
   genvar i;
    
   for(i=3;i<11;i=i+1)
     begin
       fullAdder fa(a[i],b[i-1],c[i-3],u[i],v[i-1]); 
     end

halfAdder ha3(b[10],c[8],u[11],v[10]);
halfAdder ha4(b[11],c[9],u[12],v[11]);
halfAdder ha5(b[12],c[10],u[13],v[12]);
        
endgenerate



endmodule


module carrySaveThreeOne(a,b,c,u,v);
input [15:0] a;
input [12:0] b;
input [13:0] c;

output [18:0] u;
output [14:0] v;

assign u[0]=a[0];
assign u[1]=a[1];
assign u[2]=a[2];

halfAdder ha1(a[3],b[0],u[3],v[0]);
halfAdder ha2(a[4],b[1],u[4],v[1]);


generate
   genvar i;
    
   for(i=5;i<16;i=i+1)
     begin
       fullAdder fa(a[i],b[i-3],c[i-5],u[i],v[i-3]); 
     end

assign u[16]=c[11];
assign u[17]=c[12];
assign u[18]=c[13];
assign v[13]=0;
assign v[14]=0;
        
endgenerate



endmodule

module carrySaveThreeTwo(a,b,c,u,v);
input [10:0] b,c;
input [12:0] a;

output [13:0] u;
output [10:0] v;

assign u[0]=a[0];
assign u[1]=a[1];

halfAdder ha1(a[2],b[0],u[2],v[0]);

generate
   genvar i;
    
   for(i=3;i<13;i=i+1)
     begin
       fullAdder fa(a[i],b[i-2],c[i-3],u[i],v[i-2]); 
     end

assign u[13]=c[10];   
 
        
endgenerate



endmodule


module carrySaveFourOne(a,b,c,u,v);
input [18:0] a;
input [14:0] b;
input [13:0] c;

output [20:0] u;
output [15:0] v;

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
    
   for(i=7;i<19;i=i+1)
     begin
       fullAdder fa(a[i],b[i-4],c[i-7],u[i],v[i-4]); 
     end

   
   assign u[19]=c[12];
   assign u[20]=c[13];
   assign v[15]=0;    

 
        
endgenerate



endmodule



module carrySaveFive(a,b,c,u,v);
input [20:0] a;
input [15:0] b;
input [10:0] c;

output [21:0] u;
output [15:0] v;

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
    
   for(i=10;i<21;i=i+1)
     begin
       fullAdder fa(a[i],b[i-5],c[i-10],u[i],v[i-5]); 
     end

assign u[21]=0;        
endgenerate



endmodule



