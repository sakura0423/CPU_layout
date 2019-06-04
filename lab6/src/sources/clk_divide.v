`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:32:51 11/22/2018 
// Design Name: 
// Module Name:    clk_divide 
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
module clk_divide(
	input clk,
	input rst_n,
	output reg clk_slow
	);

	reg [31:0] cnt_div;

	always @(posedge clk or negedge rst_n)
	 begin
	  if (~rst_n) cnt_div<=32'h0;
	  else if (cnt_div == 32'd99_999) cnt_div<=32'h0;
	  else cnt_div<=cnt_div+32'h1;
	 end

	always @(posedge clk or negedge rst_n)
	 begin
	 	if (~rst_n) clk_slow<=1'b0;
	 	else if (cnt_div==32'd99_999) clk_slow<=1'b1;
	 	else clk_slow<=1'b0;
	 end

endmodule