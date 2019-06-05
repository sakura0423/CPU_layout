`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 13:14:33
// Design Name: 
// Module Name: clk_divide
// Project Name: 
// Target Devices: 
// Tool Versions: 
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

	always @(posedge clk or posedge rst_n)
	 begin
	  if (rst_n) cnt_div<=32'h0;
	  else if (cnt_div == 32'd9_999) cnt_div<=32'h0;
	  else cnt_div<=cnt_div+32'h1;
	 end

	always @(posedge clk or posedge rst_n)
	 begin
	 	if (rst_n) 
	 	     clk_slow<=1'b0;
	 	else if (cnt_div==32'd9_999) 
	 	     clk_slow<=1'b1;
	 	else 
	 	     clk_slow<=1'b0;
	 end

endmodule
