module partialprod(a,b,out);
input [10:0]a;
input b;
output [10:0]out;



generate
   genvar i; 
   for(i=0;i<11;i=i+1)
     begin
        assign out[i]=a[i]&b; 
     end  
endgenerate

endmodule

