`timescale 1ns/1ps

module comparatar_8bit (
   input wire [7:0] A,B,
   output wire C
);

wire [7:0]check;
wire [6:0]d;

xnor com[7:0] (check[7:0],A[7:0],B[7:0]);

and comp0(d[0],check[1],check[0]);
and comp1(d[1],check[2],d[0]);
and comp2(d[2],check[3],d[1]);
and comp3(d[3],check[4],d[2]);
and comp4(d[4],check[5],d[3]);
and comp5(d[5],check[6],d[4]);
and comp6(d[6],check[7],d[5]);

not not1(C,d[6]);

endmodule