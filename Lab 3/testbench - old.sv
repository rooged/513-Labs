module testbench3();
logic clk; logic rst_n;

// instantiate device to be tested 
single_cycle_mips dut (clk, !rst_n); 

// initialize test 
initial 
	begin
		rst_n <= 0; # 22; rst_n <= 1;
	end

// generate clock to sequence tests 
always 
	begin clk <= 1; # 5; clk <= 0; # 5;
end

parameter end_pc = 32'h48;

//check results
always @(dut.pc) begin
	if(dut.pc == end_pc) begin
		if (dut.dmem.RAM[21]==7) begin
			$display("Simulation succeeded");
			$stop;
		end 
		else begin
			$display("Simulation failed");
			$stop;
		end
	end
end
endmodule

module top(input logic clk, rst_n);



	logic [31:0] pc, instr, readdata, writedata, dataadr;
	logic memwrite;

	//instantiate processor and memories
	single_cycle_mips mips(clk, rst_n);
	
	imem imem(pc[7:2], instr);
	dmem dmem(clk, memwrite, dataadr, writedata, readdata);
endmodule


