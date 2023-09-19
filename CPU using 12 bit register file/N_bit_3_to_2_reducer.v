`timescale 1ns/1ps 

module N_bit_3_to_2_reducer #(parameter N=16)(
    input wire  [N-1:0] P1,P2,P3,
    output wire [N-1:0] S,
    output wire [N:1] C
);
 
Full_Adder FA[N-1:0] (P1[N-1:0],P2[N-1:0],P3[N-1:0],S[N-1:0],C[N:1]); //bitwise instantiation 

endmodule 