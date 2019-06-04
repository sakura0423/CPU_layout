`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:14:48 05/20/2018
// Design Name:   PipelineCPU
// Module Name:   C:/Users/tkc/Desktop/Pipeline CPU/PipelineMIPSCPU/PlCPUtest.v
// Project Name:  PipelineMIPSCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PipelineCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PlCPUtest;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	PipelineCPU uut (
		.clk(clk), 
		.reset(reset), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#90;
      reset = 1;  
		// Add stimulus here

	end
always
begin
#10 clk=~clk;
end      
endmodule

