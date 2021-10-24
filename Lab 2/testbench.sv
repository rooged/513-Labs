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
		#100 a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000010; ALUop=2'b00; //sum should be 0011
		#100 a=32'b00000000000000000000000000000010; b=32'b00000000000000000000000000000001; ALUop=2'b01; //sum should be 0001
 		#100 a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000001; ALUop=2'b00; //sum should be 0100
		#100 a=32'b00000000000000000000000000001000; b=32'b00000000000000000000000000000011; ALUop=2'b01; //sum should be 0101
		#100 a=32'b00000000000000000000000000001000; b=32'b00000000000000000000000000000011; ALUop=2'b00; //sum should be 1011
		#100 a=32'b00000000000000000000000000001010; b=32'b00000000000000000000000000001010; ALUop=2'b01; //sum should be 0000
		#100 a=32'b00000000000000000000000000001010; b=32'b00000000000000000000000000001010; ALUop=2'b00; //sum should be (01)0100
		#100 a=32'b00000000000000000000000000001001; b=32'b00000000000000000000000000000011; ALUop=2'b01; //sum should be 0110
		#100 a=32'b00000000000000000000000000001111; b=32'b00000000000000000000000000000001; ALUop=2'b01; //sum should be 1110
		#100 a=32'b11111111111111111111111111111111; b=32'b00000000000000000000000000000001; ALUop=2'b01;
		#100 a=32'b11111111111111111111111111111111; b=32'b00000000000000000000000000000001; ALUop=2'b00;
		#100 a=32'b11111111111111111111111111111111; b=32'b00000000000000000000000000000011; ALUop=2'b01;

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
		a <= 32'b10011000100101101000000; //5,000,000
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
		if (hi == 32'b11 & lo == 32'b111) begin
			$error("Test 6 Passed");
			//$error("a: %b, b: %b, hi: %b, lo: %b", a, b, hi, lo);
		end
	end
endmodule
