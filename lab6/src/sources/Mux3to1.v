`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:35 04/30/2019 
// Design Name: 
// Module Name:    Mux3to1 
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
module Mux3to1(control,in0,in1,in2,out);
	 parameter EM = 31;
	 input [1:0] control;
    input [EM:0] in0;
    input [EM:0] in1;
	 input [EM:0] in2;
    output reg [EM:0] out;
always@(*)
begin
    case(control)
	 2'b00: out = in0;
	 2'b01: out = in1;
	 2'b10: out = in2;
	endcase
end
endmodule