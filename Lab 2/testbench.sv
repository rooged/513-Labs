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
		//multiplication
		ALUop <= 2'b10;
		a <= 32'b111;
		b <= 32'b11;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0 & lo == 32'b10101) begin
			$error("Test 1 Passed");
			//$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
		
		ALUop <= 2'b10;
		a <= 32'b1;
		b <= 32'b10;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0 & lo == 32'b10) begin
			$error("Test 2 Passed");
			//$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
		
		ALUop <= 2'b10;
		a <= 32'b0;
		b <= 32'b1;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0 & lo == 32'b0) begin
			$error("Test 3 Passed");
			//$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
		
		ALUop <= 2'b10;
		a <= 32'b11110100001001000000; //5,000,000
		b <= 32'b10101011101010010101000000; //45,000,000
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b1100110010100010 & lo == 32'b11100101000100110001000000000000) begin
			$error("Test 4 Passed");
			//$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
		
		//division
		ALUop <= 2'b11;
		a <= 32'b111;
		b <= 32'b11;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b1 & lo == 32'b10) begin
			$error("Test 5 Passed");
			//$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end

		ALUop <= 2'b11;
		a <= 32'b111011;
		b <= 32'b1000;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b111 & lo == 32'b11) begin
			$error("Test 6 Passed");
			//$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
	end
endmodule
