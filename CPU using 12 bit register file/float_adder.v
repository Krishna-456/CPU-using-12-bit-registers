module float_adder (
    input wire [11:0]A,B,
    output wire [11:0]C
);

wire [3:0]Xe,Ye;
assign Xe=A[10:7];
assign Ye=B[10:7];
wire [3:0]k;
BLS_4_bit bls (Xe,Ye,1'b0,k);

wire [3:0]Xe_plus_one;
wire yo1;
CLA_4_bit cla1 (Xe,4'b0001,1'b0,Xe_plus_one,yo1);

wire [8:0]Sm;
wire [3:0]Ze;
wire [3:0]Sm8;
assign Sm8={4{Sm[8]}};
Mux_2x1 mux1 [3:0] (Xe[3:0],Xe_plus_one[3:0],Sm8[3:0],Ze[3:0]);

wire [7:0]Ym;
assign Ym={1'b1,B[6:0]};

wire [7:0]Ym1;

wire [7:0]Ymux0;
assign Ymux0={1'b1,Ym[6:0]};
wire [7:0]Ymux1;
assign Ymux1={1'b0,1'b1,Ym[6:1]};
wire [7:0]Ymux2;
assign Ymux2={2'b00,1'b1,Ym[6:2]};
wire [7:0]Ymux3;
assign Ymux3={3'b000,1'b1,Ym[6:3]};
wire [7:0]Ymux4;
assign Ymux4={4'b0000,1'b1,Ym[6:4]};
wire [7:0]Ymux5;
assign Ymux5={5'b00000,1'b1,Ym[6:5]};
wire [7:0]Ymux6;
assign Ymux6={6'b000000,1'b1,Ym[6]};
wire [7:0]Ymux7;
assign Ymux7={7'b0000000,1'b1};

Mux_8x1 mux21 (Ymux0,k[2:0],Ym1[0]);
Mux_8x1 mux22 (Ymux1,k[2:0],Ym1[1]);
Mux_8x1 mux23 (Ymux2,k[2:0],Ym1[2]);
Mux_8x1 mux24 (Ymux3,k[2:0],Ym1[3]);
Mux_8x1 mux25 (Ymux4,k[2:0],Ym1[4]);
Mux_8x1 mux26 (Ymux5,k[2:0],Ym1[5]);
Mux_8x1 mux27 (Ymux6,k[2:0],Ym1[6]);
Mux_8x1 mux28 (Ymux7,k[2:0],Ym1[7]);

wire [7:0]Ym_shifted;
Mux_2x1 mux31 (Ym1[0],1'b0,k[3],Ym_shifted[0]);
Mux_2x1 mux32 (Ym1[1],1'b0,k[3],Ym_shifted[1]);
Mux_2x1 mux33 (Ym1[2],1'b0,k[3],Ym_shifted[2]);
Mux_2x1 mux34 (Ym1[3],1'b0,k[3],Ym_shifted[3]);
Mux_2x1 mux35 (Ym1[4],1'b0,k[3],Ym_shifted[4]);
Mux_2x1 mux36 (Ym1[5],1'b0,k[3],Ym_shifted[5]);
Mux_2x1 mux37 (Ym1[6],1'b0,k[3],Ym_shifted[6]);
Mux_2x1 mux38 (Ym1[7],1'b0,k[3],Ym_shifted[7]);

wire [7:0]Xm;
assign Xm={1'b1,A[6:0]};
CLA_8_bit_using_4_bit_CLAs cla2 (Xm,Ym_shifted,Sm);

Mux_2x1 mux41 (Sm[0],Sm[1],Sm[8],C[0]);
Mux_2x1 mux42 (Sm[1],Sm[2],Sm[8],C[1]);
Mux_2x1 mux43 (Sm[2],Sm[3],Sm[8],C[2]);
Mux_2x1 mux44 (Sm[3],Sm[4],Sm[8],C[3]);
Mux_2x1 mux45 (Sm[4],Sm[5],Sm[8],C[4]);
Mux_2x1 mux46 (Sm[5],Sm[6],Sm[8],C[5]);
Mux_2x1 mux47 (Sm[6],Sm[7],Sm[8],C[6]);

assign C[10:7]=Ze[3:0];
assign C[11]=1'b0;







endmodule
