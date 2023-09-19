module Mux_8x1 (
    input wire [7:0]A,
    input wire [2:0]S,
    output wire Y
);

wire [3:0]Y1;
wire [1:0]Y2;
Mux_2x1 mux1 (A[0],A[1],S[0],Y1[0]);
Mux_2x1 mux2 (A[2],A[3],S[0],Y1[1]);
Mux_2x1 mux3 (A[4],A[5],S[0],Y1[2]);
Mux_2x1 mux4 (A[6],A[7],S[0],Y1[3]);

Mux_2x1 mux5 (Y1[0],Y1[1],S[1],Y2[0]);
Mux_2x1 mux6 (Y1[2],Y1[3],S[1],Y2[1]);

Mux_2x1 mux7 (Y2[0],Y2[1],S[2],Y);


endmodule