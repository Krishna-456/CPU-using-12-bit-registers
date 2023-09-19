module BLS_4_bit ( //unsigned
    input wire [3:0]M,S,
    input wire Bin,
    output wire [3:0]D
    //output wire Bout // OF
);

wire [3:1]B;
wire [3:0]P,nP,nM,G;

xor  Prop [3:0] (P[3:0],M[3:0],S[3:0]);
xnor  nProp [3:0] (nP[3:0],M[3:0],S[3:0]);
not notM [3:0] (nM[3:0],M[3:0]);
and  Gen [3:0] (G[3:0],nM[3:0],S[3:0]);

and  and11 (a11,nP[0],Bin);
or  b1 (B[1],a11,G[0]);

and  and21 (a21,nP[1],nP[0],Bin);
and  and22 (a22,nP[1],G[0]);
or  b2 (B[2],a21,a22,G[1]);

and  and31 (a31,nP[2],nP[1],nP[0],Bin);
and  and32 (a32,nP[2],nP[1],G[0]);
and  and33 (a33,nP[2],G[1]);
or  b3 (B[3],a31,a32,a33,G[2]);

and  and41 (a41,nP[3],nP[2],nP[1],nP[0],Bin);
and  and42 (a42,nP[3],nP[2],nP[1],G[0]);
and  and43 (a43,nP[3],nP[2],G[1]);
and  and44 (a44,nP[3],G[2]);
//or bout (Bout,a41,a42,a43,a44,G[3]);

xor dif1 (D[0],P[0],Bin);
xor  dif2 [3:1] (D[3:1],P[3:1],B[3:1]);


endmodule