`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:53 04/25/2019 
// Design Name: 
// Module Name:    Mux32 
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
module Mux(control,in1,in0,out);
    parameter EM = 31;
	 input control;
    input [EM:0] in1;
    input [EM:0] in0;
    output [EM:0] out;
    assign out = control ? in1 : in0;

endmodule
