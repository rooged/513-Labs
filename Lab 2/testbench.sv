//written by Timothy Gedney
module testbench;
	logic [31:0] a, b;
	logic [1:0] ALUop;
	logic clk;
	logic rst_n;
	wire [31:0] s;
	wire [31:0] hi;
	wire [31:0] lo;
	wire zero;
	logic [63:0] c;
	
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
		ALUop <= 2'b10;
		
		a <= 32'b111;
		b <= 32'b11;
		c <= a * b;
		clk <= 0;
		clk <= 1;
		#10
		if (hi != c[63:32] & lo != c[31:0]) begin
			$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
		
		a <= 32'b1;
		b <= 32'b10;
		c <= a * b;
		clk <= 0;
		clk <= 1;
		#10
		if (hi != c[63:32] & lo != c[31:0]) begin
			$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
		
		a <= 32'b0;
		b <= 32'b1;
		c <= a * b;
		clk <= 0;
		clk <= 1;
		#10
		if (hi != c[63:32] & lo != c[31:0]) begin
			$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
		
		a <= 32'b11110100001001000000;
		b <= 32'b1111010000100100000;
		c <= a * b;
		clk <= 0;
		clk <= 1;
		#10
		if (hi != c[63:32] & lo != c[31:0]) begin
			$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
		
		ALUop <= 2'b11;
		a <= 32'b111;
		b <= 32'b11;
		clk <= 0;
		clk <= 1;
		#10
		if (hi != 32'b1 & lo != 32'b10) begin
			$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end

		a <= 32'b111011;
		b <= 32'b1000;
		clk <= 0;
		clk <= 1;
		#10
		if (hi != 32'b111 & lo != 32'b11) begin
			$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
	end
endmodule
