`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:24 05/21/2019
// Design Name: 
// Module Name:    Hazardunit 
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
module Hazardunit(
	input reset,
	input [4:0] rt_EX,
	input [4:0] rs_ID,
	input [4:0] rt_ID,
	input MemRead,
	output reg PCWrite,
	output reg IRWrite,
	output reg CtrStr
    );
always@(*)
begin
if (reset);
PCWrite = 1;
IRWrite = 1;
CtrStr = 1;
if((MemRead)&&(rt_EX!=5'b0)&&((rt_EX==rs_ID)||(rt_EX==rt_ID)))
begin
PCWrite = 0;
IRWrite = 0;
CtrStr = 0;
end
end
endmodule
