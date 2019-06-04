`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:18 04/11/2019
// Design Name: 
// Module Name:    reg_file 
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
module REG_FILE(
	input clk,
	input [4:0] read_addr1,
	input [4:0] read_addr2,
	output reg [31:0] RD1, 
	output reg [31:0] RD2,
	input [4:0] write_addr,
	input [31:0] WD,
	input wEna
);
	
	reg [31:0] register [31:0];
	
	//assign RD1 = (read_addr1 == 0)? 0 : register[read_addr1];
	//assign RD2 = (read_addr2 == 0)? 0 : register[read_addr2];
	
	always@(*)
	begin
	if (read_addr1 == 0) RD1 <= 0;
	else begin
	if (read_addr1 == write_addr)
	RD1 <= WD;
	else RD1 <= register[read_addr1];
	end
	if (read_addr2 == 0) RD2 <= 0;
	else begin
	if (read_addr2 == write_addr)
	RD2 <= WD;
	else RD2 <= register[read_addr2];
	end
	end
	
	always @(posedge clk)
	begin
		if (wEna)
		begin
			if (write_addr != 0)
			register[write_addr] <= WD;
		end
	end
endmodule

