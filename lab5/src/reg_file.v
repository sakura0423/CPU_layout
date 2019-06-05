`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:18 04/11/2018 
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
	input wEna,
    input [4:0] Read_Register1,
    input [4:0] Read_Register2,
    input [4:0] Write_Register,
    input [31:0] Write_Data,
    output [31:0] Read_Data1, 
    output [31:0] Read_Data2,
    input  [31:0] register_addr,
    output [31:0] register_data
);
	
	reg [31:0] register [31:0];
	integer i;
	initial 
    begin
		for(i = 0; i < 32; i = i + 1)  register[i] <= 0;
    end
	
	assign Read_Data1 = register[Read_Register1];
	assign Read_Data2 = register[Read_Register2];
    assign register_data=register[register_addr[4:0]];
	always @(posedge clk)
	begin
		if (wEna)
		begin
			if (Write_Register)
			register[Write_Register] <= Write_Data;
		end
	end
endmodule
