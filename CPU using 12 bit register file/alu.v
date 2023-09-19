`timescale 1ns/1ps

module alu(
   input wire [26:0]X,
   output wire [11:0]Y
);

wire [7:0] op1,op2;
wire [11:0]op3,op4;

assign op1={X[19:12]};
assign op2={X[7:0]};
assign op3={X[23:12]};
assign op4={X[11:0]};

//no operation
wire [11:0]no_op;

assign no_op={12'b0};

//8bit addition

wire[11:0] add;
wire[8:0] result_add;

CLA_8_bit_using_4_bit_CLAs add1(op1,op2,result_add);
assign add={{3'b0},result_add[8:0]};

//8bit subtraction



endmodule