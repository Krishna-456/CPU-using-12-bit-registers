`timescale 1ns/1ps 
module CSA_based_8_bit_multiplier(
    input wire [7:0] A,B,
    input wire Cont,//Control bit - 0 for unsigned multiplication, 1 for signed multiplication
    output wire [7:0] Pr,//product
    output wire OF
);

wire [15:0]PP[8:0];//not 7 but 8!!! this is for signed , you need to add 2^15 (in binary form to convet 1's of last PP to 2's)if last bit of multipilier is 1
wire [7:0]AB[7:0];
wire [7:0]b[7:0];
wire [15:0]P;

for(genvar i=0;i<8;i=i+1)begin
    assign b[i] = {8{B[i]}};//b is 8 bit vector with all bits same as B[7]
end

for(genvar i=0;i<8;i=i+1)begin
    and  unextended_PP[7:0] (AB[i][7:0],A[7:0],b[i][7:0]);
end

for(genvar i=0;i<7;i=i+1)begin
    assign PP[i] = {{(8-i){AB[i][7]}},AB[i],{i{1'b0}}};
end

wire [7:0]AB7;
xor ones_comp[7:0] (AB7[7:0],b[7][7:0],AB[7][7:0]);

assign PP[7] = {AB7[7],AB7,7'b0};

assign PP[8]={8'b0,B[7],7'b0};

wire [15:0]S10,S11,S12;
wire [16:1]C10out,C11out,C12out;
N_bit_3_to_2_reducer r11 (PP[0],PP[1],PP[2],S10,C10out);
N_bit_3_to_2_reducer r12 (PP[3],PP[4],PP[5],S11,C11out);
N_bit_3_to_2_reducer r13 (PP[6],PP[7],PP[8],S12,C12out);

wire [16:1]C10in,C11in,C12in;
assign C10in = {C10out[15:1],{1'b0}};
assign C11in = {C11out[15:1],{1'b0}};
assign C12in = {C12out[15:1],{1'b0}};

wire [15:0]S20,S21;
wire [16:1]C20out,C21out;

N_bit_3_to_2_reducer r21 (C10in,S10,C11in,S20,C20out);
N_bit_3_to_2_reducer r22 (S11,S12,C12in,S21,C21out);

wire [16:1]C20in,C21in;
assign C20in = {C20out[15:1],{1'b0}};
assign C21in = {C21out[15:1],{1'b0}};
wire [15:0]S30;
wire [16:1]C30out;
N_bit_3_to_2_reducer r31 (C20in,S20,C21in,S30,C30out);

wire [16:1]C30in;
assign C30in = {C30out[15:1],{1'b0}};
wire [15:0]S40;
wire [16:1]C40out;
N_bit_3_to_2_reducer r41 (S30,C30in,S21,S40,C40out);

wire [16:1]C40in;
assign C40in = {C40out[15:1],{1'b0}};
N_bit_CLA_using_4_bit_CLAs CLA (S40,C40in,1'b0,P);

buf product [7:0](Pr[7:0],P[7:0]);

wire OFu, OFs;
or or1 (OFu,P[15],P[14],P[13],P[12],P[11],P[10],P[9],P[8]); //OF=Pn+Pn+1+...+P2n-1// there is no Pn-1=> wrong Pn-1+Pn+Pn+1+...+P2n-1 

wire notPand,Pand;
and and1 (Pand,P[15],P[14],P[13],P[12],P[11],P[10],P[9],P[8],P[7]);
not not1 (notPand,Pand);
xnor xnor1 (A7xnorB7,A[7],B[7]);
xor xor1 (A7xorB7,A[7],B[7]);

and and2 (OFsame_sign,A7xnorB7,OFu);
and and3 (OFdiff_sign,A7xorB7,notPand);//~(P[15] & P[14] & P[13] & P[12] & P[11] & P[10] & P[9] & P[8] & P[7])
or or2 (OFs,OFsame_sign,OFdiff_sign);

// assign OFu = P[15]+P[14]+P[13]+P[12]+P[11]+P[10]+P[9]+P[8]+P[7];
// assign OFs = ((A[7]^~B[7])&(P[15]+P[14]+P[13]+P[12]+P[11]+P[10]+P[9]+P[8]+P[7]))+
//              ((A[7]^B[7])&(~(P[15]&P[14]&P[13]&P[12]&P[11]&P[10]&P[9]&P[8]&P[7])));

Mux_2x1 mux1 (OFs,OFu,Cont,OF);

endmodule