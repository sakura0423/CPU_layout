`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:40 04/30/2018 
// Design Name: 
// Module Name:    Mux4to1 
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
module Mux4to1(control,in0,in1,in2,in3,out);
	 parameter EM = 31;
	 input [1:0] control;
    input [EM:0] in0;
    input [EM:0] in1;
	 input [EM:0] in2;
	 input [EM:0] in3;
    output reg [EM:0] out;
always@(*)    
begin
	 case(control)
	 2'b00: out = in0;
	 2'b01: out = in1;
	 2'b10: out = in2;
	 2'b11: out = in3;
	endcase
end	
endmodule
