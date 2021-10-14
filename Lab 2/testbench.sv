//written by Timothy Gedney
module testbench;
	logic [31:0] a, b;
	logic ALUop;
	logic clk;
	logic rst_n;
	wire [31:0] s;
	wire [31:0] hi;
	wire [31:0] lo;
	wire zero;
	logic [4:0] i, j;
	logic [3:0] k;
	
	Au_32b uut (
		.a(a),
		.b(b),
		.ALUop(ALUop),
		.clk(clk),
		.rst_n,
		.s(s),
		.hi(hi),
		.lo(lo),
		.zero(zero)
	);
	
	initial begin
		a <= 0;
		b <= 0;
		cin <= 0;
		ctrl <= 0;
		
		//test addition for no carry in
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				a = i;
				b = j;
				#10;
				if ({cout, s} != (i + j)) begin
					$error("a: %b, b: %b, {cout, s}: %b, cin: %b, ctrl: %b. i: %b, j: %b = %b",
					a, b, {cout, s}, cin, ctrl, i, j, i + j);
				end
			end
		end
	end
endmodule