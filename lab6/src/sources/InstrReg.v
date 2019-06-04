`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:45 04/30/2018 
// Design Name: 
// Module Name:    InstrReg 
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
module InstrReg(
	 input IRWrite,
	 input [31:0] Ins_in,
	 output reg [31:0] Ins_out
	 );
always@(*)
	begin
	if (IRWrite)
	begin
	Ins_out <= Ins_in;
	end
	else begin
	Ins_out <= Ins_out;
	end
	end
endmodule
