`timescale 1ns/1ps 

module Mux_2x1(
    input wire A,B,
    input wire s,
    output wire M
);

and  and1 (m1,A,s);
not  not1 (ns,s);
and  and2 (m2,B,ns);
or  mux (M,m1,m2);//M=s?A:B

endmodule