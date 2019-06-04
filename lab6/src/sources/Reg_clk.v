`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:53:02 04/30/2018 
// Design Name: 
// Module Name:    Reg_clk 
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
module Reg_clk(
    input clk,
	 input [31:0] in,
	 output reg [31:0] out
	 );
always@(posedge clk)
	begin
	out <= in;
	end
endmodule
