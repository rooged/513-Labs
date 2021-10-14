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

endmodule