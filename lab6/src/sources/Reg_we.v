`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:56:40 05/21/2019
// Design Name: 
// Module Name:    Reg_we 
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
module Reg_we(clk,reset,IRWrite,in,out);
	 parameter EM = 31;
	 input clk;
	 input reset;
	 input IRWrite;
	 input [EM:0] in;
	 output reg [EM:0] out;
    always@(posedge clk or negedge reset)
    begin
        if (~reset) 
		  begin
		  out <= 0;
		  end
		  else begin
		  if(IRWrite)
		  begin
		  out <= in;
		  end
		  else begin
		  out <= out;
		  end
		  end
    end

endmodule
