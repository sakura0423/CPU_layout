`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:17 05/17/2019
// Design Name: 
// Module Name:    MEM-WB 
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
module MEM_WB(
	 input clk,
	 input reset,
	 input [1:0] WB_in,
	 input [31:0] ALUresult_in,
	 output [31:0] ALUresult_out,
	 input [4:0] Insaddr_in,
	 output [4:0] Insaddr_out,
	 output RegWrite,
	 output MemtoReg
	 );
wire [1:0] WB_out;
assign RegWrite = WB_out[1:1];
assign MemtoReg = WB_out[0:0];
Reg #(1)WBreg(clk,reset,WB_in,WB_out);
//Reg RAMreg(clk,reset,Readdata_in,Readdata_out);
Reg ALUreg(clk,reset,ALUresult_in,ALUresult_out);
Reg #(4)Insaddrreg(clk,reset,Insaddr_in,Insaddr_out);
endmodule
