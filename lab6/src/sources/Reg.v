`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:07:51 05/17/2019
// Design Name: 
// Module Name:    Reg 
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
module Reg(clk,reset,in,out);
	 parameter EM = 31;
	 input clk;
	 input reset;
	 input [EM:0] in;
	 output reg [EM:0] out;
    always@(posedge clk or negedge reset)
    begin
        if (~reset) 
		  begin
		  out <= 0;
		  end
		  else begin
		  out <= in;
		  end
    end

endmodule
