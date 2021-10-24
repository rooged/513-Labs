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
		//addition
		ALUop = 2'b00;
		a <= 32'b1;
		b <= 32'b10;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b11) begin
			$error("Addition: Test 1 Passed");
		end
		
		ALUop = 2'b00;
		a <= 32'b11;
		b <= 32'b1;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b100) begin
			$error("Addition: Test 2 Passed");
		end

		ALUop = 2'b00;
		a <= 32'b1000;
		b <= 32'b11;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b1011) begin
			$error("Addition: Test 3 Passed");
		end

		ALUop = 2'b00;
		a <= 32'b1010;
		b <= 32'b1010;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b010100) begin
			$error("Addition: Test 4 Passed");
		end

		ALUop = 2'b00;
		a <= 32'b11111111111111111111111111111111;
		b <= 32'b1;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b0) begin
			$error("Addition: Test 5 Passed");
		end

		ALUop = 2'b00;
		a <= 32'b110011011010010111011000010001;
		b <= 32'b100000100000110110001110000101;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b01010011111011001101100110010110) begin
			$error("Addition: Test 6 Passed");
		end

		//subtraction
		ALUop = 2'b01;
		a <= 32'b10;
		b <= 32'b1;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b1) begin
			$error("Subtraction: Test 1 Passed");
		end

		ALUop = 2'b01;
		a <= 32'b1000;
		b <= 32'b11;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b101) begin
			$error("Subtraction: Test 2 Passed");
		end

		ALUop = 2'b01;
		a <= 32'b1010;
		b <= 32'b1010;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b0) begin
			$error("Subtraction: Test 3 Passed");
		end

		ALUop = 2'b01;
		a <= 32'b1;
		b <= 32'b1000;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b11111111111111111111111111111001) begin
			$error("Subtraction: Test 4 Passed");
		end

		ALUop = 2'b01;
		a <= 32'b1111;
		b <= 32'b1;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b1110) begin
			$error("Subtraction: Test 5 Passed");
		end

		ALUop = 2'b01;
		a <= 32'b11111111111111111111111111111111;
		b <= 32'b11;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (s == 32'b11111111111111111111111111111100) begin
			$error("Subtraction: Test 6 Passed");
		end

		//multiplication
		ALUop <= 2'b10;
		a <= 32'b111;
		b <= 32'b11;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0 & lo == 32'b10101) begin
			$error("Multiplication: Test 1 Passed");
		end
		
		ALUop <= 2'b10;
		a <= 32'b1;
		b <= 32'b10;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0 & lo == 32'b10) begin
			$error("Multiplication: Test 2 Passed");
		end
		
		ALUop <= 2'b10;
		a <= 32'b0;
		b <= 32'b1;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0 & lo == 32'b0) begin
			$error("Multiplication: Test 3 Passed");
		end
		
		ALUop <= 2'b10;
		a <= 32'b10011000100101101000000; //5,000,000
		b <= 32'b10101011101010010101000000; //45,000,000
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b1100110010100010 & lo == 32'b11100101000100110001000000000000) begin
			$error("Multiplication: Test 4 Passed");
		end

		ALUop <= 2'b10;
		a <= 32'b1111111001101100101110100101101; //2,134,269,229
		b <= 32'b1101000101001110101101000100001; //1,755,798,049
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b00110100000000010011111100011010 & lo == 32'b10010011000111101101010011001101) begin
			$error("Multiplication: Test 5 Passed");
		end

		ALUop <= 2'b10;
		a <= 32'b10110010110110010; //91,570
		b <= 32'b1001001100001110010001010101010; //1,233,593,002
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0110011010111100 & lo == 32'b10010011010011010010110000110100) begin
			$error("Multiplication: Test 6 Passed");
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
			$error("Division: Test 1 Passed");
		end

		ALUop <= 2'b11;
		a <= 32'b111011;
		b <= 32'b1000;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b11 & lo == 32'b111) begin
			$error("Division: Test 2 Passed");
		end

		ALUop <= 2'b11;
		a <= 32'b110101001;
		b <= 32'b0;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0 & lo == 32'b0) begin
			$error("Division: Test 3 Passed");
		end

		ALUop <= 2'b11;
		a <= 32'b1110010111001011010010110110010; //1,927,652,786
		b <= 32'b1011;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b100 & lo == 32'b01010011100011111011111001010) begin
			$error("Division: Test 4 Passed");
		end

		ALUop <= 2'b11;
		a <= 32'b101;
		b <= 32'b1011111011010010110110; //3,126,454
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0101 & lo == 32'b0) begin
			$error("Division: Test 5 Passed");
		end

		ALUop <= 2'b11;
		a <= 32'b1011100101011010101010011000; //194,357,912
		b <= 32'b100;
		clk <= 0;
		#1
		clk <= 1;
		#9
		if (hi == 32'b0 & lo == 32'b010111001010110101010100110) begin
			$error("Division: Test 6 Passed");
		end
	end
endmodule
