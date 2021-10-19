//Caitlynn Jones CSCE 513 Project 1
module carry_lookahead_adder(input logic [3:0] a,b, //operands
		   input logic cin, //carry_in
		   input logic ctrl, //Add(ctrl=0) and SUB(ctrl=1)
		   output logic [3:0] s, //The result of ADD/SUB
	           output logic cout 	//carry out
);

wire [3:0] P, G;
wire [4:0] C; //C[i+1]


assign G = a & b; //Gi = Ai.Bi, Generate signal
assign P = a ^ b; //Pi = Ai + Bi, Propagate signal
assign s = P ^ C;

assign cout = G[0] | (P & C[0]);

assign C[0] = cin;
assign C[1] = G[0] | (P[0] & C[0]); //C1 = G0 + P0.C0 
assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) |
				(P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);


endmodule



module add_sub_4b(input logic [3:0] a,b, //operands
		   input logic cin, //carry_in
		   input logic ctrl, //Add(ctrl=0) and SUB(ctrl=1)
		   output logic [3:0] s, //The result of ADD/SUB
	           output logic [3:0] cout 	//carry out
);

wire C0,C1,C2,C3;

//complements each bit of b if ctrl=1
xor X0(C0, ctrl, b[0]),
    X1(C1, ctrl, b[1]),
    X2(C2, ctrl, b[2]),
    X3(C3, ctrl, b[3]);


carry_lookahead_adder CA0(.a(a[0]),.b(C0),.cin(ctrl),.s(s[0]),.cout(cout[0])), //Bit 1
                      CA1(.a(a[1]),.b(C1),.cin(cout[0]),.s(s[1]),.cout(cout[1])), //Bit 2
                      CA2(.a(a[2]),.b(C2),.cin(cout[1]),.s(s[2]),.cout(cout[2])), //Bit 3
                      CA3(.a(a[3]),.b(C3),.cin(cout[2]),.s(s[3]),.cout(cout[3])); //Bit 4





endmodule
