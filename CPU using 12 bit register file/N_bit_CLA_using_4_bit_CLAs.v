`timescale 1ns/1ps 

module N_bit_CLA_using_4_bit_CLAs #(parameter N=16)(  
    input wire [N-1:0]A,B,
    input wire Cin,
    output wire [N-1:0]S
);

parameter n=N/4;
wire [4:1]C;//Cout of each 4_bit_CLA

CLA_4_bit cla0 (A[3:0],B[3:0],Cin,S[3:0],C[1]);
CLA_4_bit cla1(A[7:4],B[7:4],C[1],S[7:4],C[2]);
CLA_4_bit cla2 (A[11:8],B[11:8],C[2],S[11:8],C[3]);
CLA_4_bit cla3 (A[15:12],B[15:12],C[3],S[15:12],C[4]);

/*
    modules can't be instantiated  with same name
    but in a for loop you just write module name once but it wont give error saying all module names in for loop are same . rather it'll run fine, considering implicity that the names are different
    if you check signal of for loop in gtkwave youll see that there are 4 signals with same name but they are actually different 
    thus the below code works
*/         
//CLA_4_bit cla (A[3:0],B[3:0],Cin,S[3:0],C[1]);
// for(genvar i=2;i<n;i=i+1)begin
//     CLA_4_bit cla (A[4*i+3:4*i],B[4*i+3:4*i],C[i],S[4*i+3:4*i],C[i+1]);
// end



endmodule