module partialprod(a,b,out);
input [15:0]a;
input b;
output [15:0]out;



generate
   genvar i; 
   for(i=0;i<16;i=i+1)
     begin
        assign out[i]=a[i]&b; 
     end  
endgenerate

endmodule

