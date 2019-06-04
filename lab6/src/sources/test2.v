`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:10:29 06/07/2018
// Design Name:   PipelineCPU
// Module Name:   C:/Users/tkc/Desktop/Pipeline CPU/PipelineMIPSCPU/test2.v
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

module test2;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] read_addr_out;

	// Outputs
	wire [31:0] read_out;

	// Instantiate the Unit Under Test (UUT)
	PipelineCPU uut (
		.clk(clk), 
		.reset(reset), 
		.read_addr_out(read_addr_out), 
		.read_out(read_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		read_addr_out = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset =1;
		// Add stimulus here

	end
always
begin
#10 clk=~clk;
end      
endmodule

