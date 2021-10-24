//written by Brandon Carter, Caitlynn Jones, & Timothy Gedney
module Au_32b  (input logic [31:0] a,b,	// operands
				input logic [1:0] ALUop, //ADD(ALUop=00), SUB(ALUop=01), MULT(ALUop=10), DIV(ALUop11)
				input logic clk, //clock signal
				input logic rst_n, //active-low reset signal used for initialization
				output logic [31:0] s, //the result of add/sub
				output logic [31:0] hi,	//left half of product/remainder register for mult/div
				output logic [31:0] lo, //right half of product/remainder register for mult/div
				output logic zero //zero flag
				);
logic [31:0] cout;
logic [5:0] i;
logic [31:0] hi2, lo2;

reg C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24,C25,C26,C27,C28,C29,C30,C31;
	//complements each bit of b (32 bits total) if ALUop = 01
	xor X0(C0, ALUop, b[0]), 
    	    X1(C1, ALUop, b[1]), 
    	    X2(C2, ALUop, b[2]), 
    	    X3(C3, ALUop, b[3]), 
    	    X4(C4, ALUop, b[4]), 
    	    X5(C5, ALUop, b[5]), 
    	    X6(C6, ALUop, b[6]), 
    	    X7(C7, ALUop, b[7]), 
    	    X8(C8, ALUop, b[8]),
    	    X9(C9, ALUop, b[9]),
    	    X10(C10, ALUop, b[10]),
    	    X11(C11, ALUop, b[11]),
    	    X12(C12, ALUop, b[12]),
    	    X13(C13, ALUop, b[13]),
    	    X14(C14, ALUop, b[14]),
    	    X15(C15, ALUop, b[15]),
    	    X16(C16, ALUop, b[16]),
    	    X17(C17, ALUop, b[17]),
    	    X18(C18, ALUop, b[18]),
    	    X19(C19, ALUop, b[19]),
    	    X20(C20, ALUop, b[20]),
    	    X21(C21, ALUop, b[21]),
    	    X22(C22, ALUop, b[22]),
    	    X23(C23, ALUop, b[23]),
    	    X24(C24, ALUop, b[24]),
    	    X25(C25, ALUop, b[25]),
    	    X26(C26, ALUop, b[26]),
    	    X27(C27, ALUop, b[27]),
    	    X28(C28, ALUop, b[28]),
    	    X29(C29, ALUop, b[29]),
    	    X30(C30, ALUop, b[30]),
    	    X31(C31, ALUop, b[31]);	

always @ (posedge clk or posedge rst_n) begin
	
	if(ALUop == 2'b00 || ALUop == 2'b01) begin
		 
carry_lookahead_adder CA0(.a(a[0]),.b(C0),.cin(ALUop),.s(s[0]),.cout(cout[0])), //Bit 1
		      CA1(.a(a[1]),.b(C1),.cin(cout[0]),.s(s[1]),.cout(cout[1])), //Bit 2
                      CA2(.a(a[2]),.b(C2),.cin(cout[1]),.s(s[2]),.cout(cout[2])), //Bit 3
                      CA3(.a(a[3]),.b(C3),.cin(cout[2]),.s(s[3]),.cout(cout[3])), //Bit 4
		      CA4(.a(a[4]),.b(C4),.cin(cout[3]),.s(s[4]),.cout(cout[4])), //Bit 5
		      CA5(.a(a[5]),.b(C5),.cin(cout[4]),.s(s[5]),.cout(cout[5])), //Bit 6
                      CA6(.a(a[6]),.b(C6),.cin(cout[5]),.s(s[6]),.cout(cout[6])), //Bit 7
                      CA7(.a(a[7]),.b(C7),.cin(cout[6]),.s(s[7]),.cout(cout[7])), //Bit 8
		      CA8(.a(a[8]),.b(C8),.cin(cout[7]),.s(s[8]),.cout(cout[8])), //Bit 9
                      CA9(.a(a[9]),.b(C9),.cin(cout[8]),.s(s[9]),.cout(cout[9])), //Bit 10
                      CA10(.a(a[10]),.b(C10),.cin(cout[9]),.s(s[10]),.cout(cout[10])), //Bit 11
                      CA11(.a(a[11]),.b(C11),.cin(cout[10]),.s(s[11]),.cout(cout[11])), //Bit 12
                      CA12(.a(a[12]),.b(C12),.cin(cout[11]),.s(s[12]),.cout(cout[12])), //Bit 13
                      CA13(.a(a[13]),.b(C13),.cin(cout[12]),.s(s[13]),.cout(cout[13])), //Bit 14
                      CA14(.a(a[14]),.b(C14),.cin(cout[13]),.s(s[14]),.cout(cout[14])), //Bit 15
                      CA15(.a(a[15]),.b(C15),.cin(cout[14]),.s(s[15]),.cout(cout[15])), //Bit 16
                      CA16(.a(a[16]),.b(C16),.cin(cout[15]),.s(s[16]),.cout(cout[16])), //Bit 17
                      CA17(.a(a[17]),.b(C17),.cin(cout[16]),.s(s[17]),.cout(cout[17])), //Bit 18
                      CA18(.a(a[18]),.b(C18),.cin(cout[17]),.s(s[18]),.cout(cout[18])), //Bit 19	
                      CA19(.a(a[19]),.b(C19),.cin(cout[18]),.s(s[19]),.cout(cout[19])), //Bit 20
                      CA20(.a(a[20]),.b(C20),.cin(cout[19]),.s(s[20]),.cout(cout[20])), //Bit 21
                      CA21(.a(a[21]),.b(C21),.cin(cout[20]),.s(s[21]),.cout(cout[21])), //Bit 22
                      CA22(.a(a[22]),.b(C22),.cin(cout[21]),.s(s[22]),.cout(cout[22])), //Bit 23
                      CA23(.a(a[23]),.b(C23),.cin(cout[22]),.s(s[23]),.cout(cout[23])), //Bit 24
                      CA24(.a(a[24]),.b(C24),.cin(cout[23]),.s(s[24]),.cout(cout[24])), //Bit 25
                      CA25(.a(a[25]),.b(C25),.cin(cout[24]),.s(s[25]),.cout(cout[25])), //Bit 26
                      CA26(.a(a[26]),.b(C26),.cin(cout[25]),.s(s[26]),.cout(cout[26])), //Bit 27
                      CA27(.a(a[27]),.b(C27),.cin(cout[26]),.s(s[27]),.cout(cout[27])), //Bit 28
                      CA28(.a(a[28]),.b(C28),.cin(cout[27]),.s(s[28]),.cout(cout[28])), //Bit 29
                      CA29(.a(a[29]),.b(C29),.cin(cout[28]),.s(s[29]),.cout(cout[29])), //Bit 30
                      CA30(.a(a[30]),.b(C30),.cin(cout[29]),.s(s[30]),.cout(cout[30])), //Bit 31
                      CA31(.a(a[31]),.b(C31),.cin(cout[30]),.s(s[31]),.cout(cout[31])); //Bit 32

	//multiplication
	end else if (ALUop == 2'b10) begin
		//check if either are 0 & immediately assigns 0 if so
		if (a == 32'b0 | b == 32'b0) begin
			$error("a or b is 0");
			assign hi = 32'b0;
			assign lo = 32'b0;
		end else begin
			//assigns 0 to hi & a to low
			hi2 = 32'b0;
			lo2 = a;
			//for loop begin, iterates through 32 bits
			for (i = 0; i < 32; i = i + 1) begin
				$error("begin iteration, hi2: %b, lo2: %b, i: %b", hi2, lo2, i);
				//checks if lo[0] is 1, adds b to hi if so
				if (lo2[0] == 1) begin
					hi2 = hi2 + b;
					$error("if lo2[0] == 1, hi2: %b", hi2);
				end
				//shifts lo right 1 bit
				lo2 = lo2 >> 1;
				$error("shift lo right 1 bit, lo2: %b", lo2);
				//checks if hi[0] is 1 and moves that bit to lo[31] is so
				if (hi2[0] == 1) begin
					lo2[31] = 1;
					$error("hi[0] is 1, moves to lo[31], lo2: %b", lo2);
				end
				//shifts hi right 1 bit
				hi2 = hi2 >> 1;
				$error("shift hi2 right 1, hi2: %b", hi2);
			end
			//final assigns after end loop
			assign hi = hi2;
			assign lo = lo2;
		end
	//division
	end else if (ALUop == 2'b11) begin
	$error("entered division");
		//checks if b is 0, assigns 0 to hi & lo if so
		if (b == 32'b0) begin
			assign hi = 32'b0;
			assign lo = 32'b0;
		end else begin
			//assigns 0 to hi & a to lo
			hi2 = 32'b0;
			lo2 = a;

			//shift hi 1 bit & check if lo[31] is 1, adds to hi[0] if so, shift lo left 1 bit
			hi2 = hi2 << 1;
			if (lo2[31] == 1) begin
				hi2[0] = 1;
			end
			lo2 = lo2 << 1;
			
			//for loop, iterate 32 times
			for (i = 0; i < 32; i = i + 1) begin
				//subtract b from hi
				hi2 = hi2 - b;
				//if hi >= 0, shift both to left 1 bit & set lo[0] to 1
				if (hi2 >= 0) begin
					hi2 = hi2 << 1;
					if (lo2[31] == 1) begin
						hi2[0] = 1;
					end
					lo2 = lo2 << 1;
					lo2[0] = 1;
				//if hi < 0, add b back to hi, shift both left 1 bit & set lo[0] to 0
				end else begin
					hi2 = hi2 + b;
					hi2 = hi2 << 1;
					if (lo2[31] == 1) begin
						hi2[0] = 1;
					end
					lo2 = lo2 << 1;
				end
			end
			//shift hi right 1 bit
			hi2 = hi2 >> 1;
			//final assign
			assign hi = hi2;
			assign lo = lo2;
		end
	end
end

endmodule

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
