`timescale 1ns/1ps

module multipilier
(
   input wire [11:0]x,y,
   output wire [11:0]z
);

wire xs,ys,zs;
wire [3:0]xe,ye,ze;
wire[6:0]xm,ym,zm;
wire [7:0]xm1,ym1;

assign xs=x[11];
assign ys=y[11];
assign xe={x[10:7]};
assign ye={y[10:7]};
assign xm={x[6:0]};
assign ym={y[6:0]};
assign xm1={1'b1,x[6:0]};
assign ym1={1'b1,y[6:0]};

xor xor1(zs,xs,ys);

wire [15:0]m;
wire [6:0]mo,mno,selec;
CSA_based_8_bit_multiplier mult1(xm1,ym1,1'b0,m);
assign mo=m[14:8];
assign mno=m[13:7];
assign selec={7{m[15]}};
Mux_2x1 mux1[6:0](mo[6:0],mno[6:0],selec[6:0],zm[6:0]);

wire[3:0] bias,sum1,sub,addend,se;
wire c1,c2;
assign bias=4'b0111;
BLS_4_bit sub1(xe,bias,1'b0,sub);
CLA_4_bit add1(sub,ye,1'b0,sum1,c1);
wire [3:0] ones,zeroes;
assign zeroes=4'b0000;
assign ones=4'b0001;
assign se={4{m[15]}};
Mux_2x1 mux2[3:0](ones[3:0],zeroes[3:0],se[3:0],addend[3:0]);
CLA_4_bit add2(sum1,addend,1'b0,ze,c2);

assign z={zs,ze[3:0],zm[6:0]};

endmodule