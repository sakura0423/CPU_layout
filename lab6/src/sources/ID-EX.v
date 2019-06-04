`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:57:54 05/16/2019 
// Design Name: 
// Module Name:    ID-EX 
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
module ID_EX(
	 input clk,
	 input reset,
	 input [1:0] WB_in,
	 output [1:0] WB_out,
	 input [3:0] MEM_in,
	 output [3:0] MEM_out,
	 input [7:0] EX_in,
    input [31:0] nextAddress_in,
	 output [31:0] nextAddress_out,
	 input [31:0] A_in,
	 output [31:0] A_out,
	 input [31:0] B_in,
	 output [31:0] B_out,
	 input [31:0] imm_in,
	 output [31:0] imm_out,
	 input [4:0] Ins25_in,
	 output [4:0] Ins25_out,
	 input [4:0] Ins20_in,
	 output [4:0] Ins20_out,
	 input [4:0] Ins15_in,
	 output [4:0] Ins15_out,
	 input [4:0] Ins10_in,
	 output [4:0] Ins10_out,
	 input [25:0] tar_in,
	 output [25:0] tar_out,
	 output [2:0] AluzeroCtr,
	 output RegDst,
	 output [2:0] ALUop,
	 output ALUSrc
	 );
wire [7:0] EX_out;
assign AluzeroCtr = EX_out[7:5];
assign RegDst = EX_out[4:4];
assign ALUop = EX_out[3:1];
assign ALUSrc = EX_out[0:0];
Reg #(1)WBreg(clk,reset,WB_in,WB_out);
Reg #(3)MEMreg(clk,reset,MEM_in,MEM_out);
Reg #(7)EXreg(clk,reset,EX_in,EX_out);
Reg PCreg2(clk,reset,nextAddress_in,nextAddress_out),
	 Areg(clk,reset,A_in,A_out),
	 Breg(clk,reset,B_in,B_out),
	 Immreg(clk,reset,imm_in,imm_out);
Reg #(4)Insaddrreg0(clk,reset,Ins25_in,Ins25_out),
		  Insaddrreg1(clk,reset,Ins20_in,Ins20_out),
		  Insaddrreg2(clk,reset,Ins15_in,Ins15_out),
		  Insshamt(clk,reset,Ins10_in,Ins10_out);
Reg #(25)tarreg(clk,reset,tar_in,tar_out);
endmodule
