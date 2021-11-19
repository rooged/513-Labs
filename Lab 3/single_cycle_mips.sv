module single_cycle_mips ( input logic clk, input logic rst_n);

	logic [31:0] pc, instr;
	logic memwrite;
	logic [31:0] aluout, writedata, readdata;

	logic memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero;

	logic [2:0] alucontrol;

	controller c(instr[31:26], instr[5:0], zero,
			memtoreg, memwrite, pcsrc,
			alusrc, regdst, regwrite, jump,
			alucontrol);

	datapath dp(clk, rst_n, memtoreg, pcsrc,
			alusrc, regdst, regwrite, jump,
			alucontrol,
			zero, pc, instr,
			aluout, writedata, readdata);
	imem imem(pc[7:2], instr);
	dmem dmem(clk, memwrite, dataadr, writedata, readdata);

endmodule

module aludec(input logic [5:0] funct,
	input logic [1:0] aluop,
	output logic [2:0] alucontrol);

	always_comb
		case(aluop)
			2'b00: alucontrol <= 3'b010; // add (for lw/sw/addi)
			2'b01: alucontrol <= 3'b110; // sub (for beq)
			default: case(funct) // R-type instructions
			6'b100000: alucontrol <= 3'b010; // add
			6'b100010: alucontrol <= 3'b110; // sub
			6'b100100: alucontrol <= 3'b000; // and
			6'b100101: alucontrol <= 3'b001; // or
			6'b101010: alucontrol <= 3'b111; // slt
			default: alucontrol <= 3'bxxx; // ???
			endcase
		endcase
endmodule


module decoder(input logic [5:0] op, 
		output logic memtoreg, memwrite,
		output logic branch, alusrc,
		output logic regdst, regwrite,
		output logic jump,
		output logic [1:0] aluop);

logic [8:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls;

always_comb 
	case (op)
	6'b000000: controls <= 9'b110000010; // RTYPE add, sub, and, or, slt
	6'b100011: controls <= 9'b101001000; // LW
	6'b101011: controls <= 9'b001010000; // SW
	6'b000100: controls <= 9'b000100001; // BEQ
	6'b001000: controls <= 9'b101000000; // ADDI
	6'b000010: controls <= 9'b000000100; // J
	default: controls <= 9'bxxxxxxxxx; // illegal op
	endcase
endmodule

module controller(input logic [5:0] op, funct,
			input logic zero,
			output logic memtoreg, memwrite,
			output logic pcsrc, alusrc,
			output logic regdst, regwrite,
			output logic jump,
			output logic [2:0] alucontrol);

	logic [1:0] aluop;
	logic branch;

	decoder decode(op, memtoreg, memwrite, branch,
			alusrc, regdst, regwrite, jump, aluop);

	aludec ad(funct, aluop, alucontrol);
	assign pcsrc = branch & zero;
endmodule

module datapath(input logic clk, rst_n,
		input logic memtoreg, pcsrc,
		input logic alusrc, regdst,
		input logic regwrite, jump,
		input logic [2:0] alucontrol,
		output logic zero,
		output logic [31:0] pc,
		input logic [31:0] instr,
		output logic [31:0] aluout, writedata,
		input logic [31:0] readdata);
		logic [4:0] writereg;
		logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
		logic [31:0] signimm, signimmsh;
		logic [31:0] srca, srcb;
		logic [31:0] result;
		// next PC logic
		flopr #(32) pcreg(clk, rst_n, pcnext, pc);

	adder pcadd1(pc, 32'b100, pcplus4);

	sl2 immsh(signimm, signimmsh);

	adder pcadd2(pcplus4, signimmsh, pcbranch);
	mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);

	mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28],
				instr[25:0], 2'b00}, jump, pcnext);
	// register file logic
	regfile rf(clk, regwrite, instr[25:21], instr[20:16],
			writereg, result, srca, writedata);

	mux2 #(5) wrmux(instr[20:16], instr[15:11],
			regdst, writereg);
	mux2 #(32) resmux(aluout, readdata, memtoreg, result);
				signext se(instr[15:0], signimm);

	// ALU logic
	mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);

	alu alu(srca, srcb, alucontrol, aluout, zero);
endmodule

module regfile(input logic clk,
		input logic we3,
		input logic [4:0] ra1, ra2, wa3,
		input logic [31:0] wd3,
		output logic [31:0] rd1, rd2);

		logic [31:0] rf[31:0];
// three ported register file
// read two ports combinationally
// write third port on rising edge of clk
// register 0 hardwired to 0
// note: for pipelined processor, write third port
// on falling edge of clk
	always_ff @(posedge clk)
		if (we3) rf[wa3] <= wd3;

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule

module adder(input logic [31:0] a, b,
		output logic [31:0] y);

	assign y = a + b;

endmodule

module sl2(input logic [31:0] a,
		output logic [31:0] y);
	// shift left by 2
	assign y = {a[29:0], 2'b00};
endmodule

module mux2 #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] d0, d1,
		input logic s,
		output logic [WIDTH-1:0] y);

	assign y = s ? d1 : d0;
endmodule

module signext(input logic [15:0] a,
		output logic [31:0] y);

	assign y = {{16{a[15]}}, a};
endmodule

module alu (input logic srca, srcb, alucontrol,
		input logic [2:0] ctrl,
		output logic aluout, zero);

	logic [31:0] srcc, srcbOut;
	
	assign srcbOut = ctrl[2] ? ~srcb : srcb;
	assign srcc = srca + srcbOut + ctrl[2];
	
	always_comb
		case (ctrl[1:0])
			2'b00: aluout <= srca & srcbOut; //and
			2'b01: aluout <= srca | srcbOut; //or
			2'b10: aluout <= srcc; //add
			2'b11: aluout <= srcc[31]; //set on less than
		endcase
endmodule

module flopr #(parameter WIDTH=8)
		(input logic clk, rst_n,
		input logic [WIDTH-1:0] d,
		output logic [WIDTH-1:0] q);

	always_ff @(posedge clk, posedge rst_n)
		if (rst_n) q <= 0;
		else q <= d;
endmodule	

module dmem(input logic clk, we,
		input logic [31:0] a, wd,
		output logic [31:0] rd);

	logic [31:0] RAM[63:0];
	assign rd = RAM[a[31:2]]; // word aligned

	always_ff @(posedge clk)
		if (we) RAM[a[31:2]] <= wd;
endmodule

module imem(input logic [5:0] a,
		output logic [31:0] rd);

	logic [31:0] RAM[63:0];

	initial
		$readmemh("C:/Users/Carro/OneDrive/Desktop/CSCE513/memfile.dat", RAM);
		assign rd = RAM[a]; // word aligned
endmodule
