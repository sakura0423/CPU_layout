`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:10:53 05/30/2018 
// Design Name: 
// Module Name:    read_addr_gen_single 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module read_addr_gen_single(
	input clk,
	input rst_n,
	input [7:0] addr,
	output [7:0] addr_out
    );
	
	reg counter;
	
	initial
		counter <= 1'b0;
	
	always @(posedge clk or negedge rst_n)
	begin
		if (~rst_n) counter <= 1'b0;
		else counter <= ~counter;
	end
	
	assign addr_out = {addr, counter};

endmodule
