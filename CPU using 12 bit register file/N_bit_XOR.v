`timescale 1ns/1ps 
module N_bit_XOR#(parameter N=8)(
    input wire [N-1:0] A,B,
    output wire [N-1:0] S
);

xor xor_[N-1:0] (S[N-1:0],A[N-1:0],B[N-1:0]);

endmodule