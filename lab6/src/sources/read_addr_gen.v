`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:18:45 05/29/2019 
// Design Name: 
// Module Name:    read_addr_gen 
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
module read_addr_gen(
	input clk,
	input rst_n,
	output reg [7:0] read_addr
    );
	 
	 always @(posedge clk or negedge rst_n)
	 begin
		if (~rst_n)
			read_addr <= 8'd0;
		else 
		begin
		  if (read_addr < 8'b11111111) read_addr <= read_addr + 8'd1;
		  else read_addr <= 8'd0;
		end
	 end

endmodule
