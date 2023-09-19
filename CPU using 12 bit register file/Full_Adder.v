`timescale 1ns/1ps 

module Full_Adder (
    input wire A,B,
    input wire Cin,
    output wire S,
    output wire Cout
);

xor sum (S,A,B,Cin);

and and1 (a1,A,B);
and and2 (a2,A,Cin);
and and3 (a3,B,Cin);

or  cout (Cout,a1,a2,a3);

endmodule