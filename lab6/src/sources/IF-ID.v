`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:49:38 05/16/2019 
// Design Name: 
// Module Name:    IF-ID 
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
module IF_ID(
	 input clk,
	 input reset,
	 input IRWrite,
    input [31:0] nextAddress_in,
	 output [31:0] nextAddress_out,
	 input [31:0] Ins_in,
	 output [31:0] Ins_out
	 );
Reg_we PCreg(clk,reset,IRWrite,nextAddress_in,nextAddress_out),
	    Insreg(clk,reset,IRWrite,Ins_in,Ins_out);
endmodule
