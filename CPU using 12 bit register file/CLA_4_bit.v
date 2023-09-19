`timescale 1ns/1ps 
module CLA_4_bit (
    input wire [3:0]A,B,
    input wire Cin,
    output wire [3:0]S,
    output wire Cout
);

wire [3:1]C;
wire [3:0]P,G;

xor  Prop [3:0] (P[3:0],A[3:0],B[3:0]);
and  Gen [3:0] (G[3:0],A[3:0],B[3:0]);
xor sum1 (S[0],P[0],Cin);
xor  sum2 [3:1] (S[3:1],P[3:1],C[3:1]);

and  and11 (a11,P[0],Cin);
or  c1 (C[1],a11,G[0]);


and  and21 (a21,P[1],P[0],Cin);
and  and22 (a22,P[1],G[0]);
or  c2 (C[2],a21,a22,G[1]);

and  and31 (a31,P[2],P[1],P[0],Cin);
and  and32 (a32,P[2],P[1],G[0]);
and  and33 (a33,P[2],G[1]);
or  c3 (C[3],a31,a32,a33,G[2]);

and  and41 (a41,P[3],P[2],P[1],P[0],Cin);
and  and42 (a42,P[3],P[2],P[1],G[0]);
and  and43 (a43,P[3],P[2],G[1]);
and  and44 (a44,P[3],G[2]);
or cout (Cout,a41,a42,a43,a44,G[3]);

endmodule