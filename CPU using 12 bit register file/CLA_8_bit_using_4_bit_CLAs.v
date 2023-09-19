`timescale 1ns/1ps 
module CLA_8_bit_using_4_bit_CLAs (  
    input wire [7:0]A,B,
    output wire [8:0]S// including Cout
);

wire [2:1]C;

CLA_4_bit cla0 (A[3:0],B[3:0],1'b0,S[3:0],C[1]);
CLA_4_bit cla1 (A[7:4],B[7:4],C[1],S[7:4],C[2]);

assign S[8]=C[2];

endmodule