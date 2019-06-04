`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:53 04/25/2019 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
	 input reset,
	 input PCWrite,
    input [31:0] newAddress,           
    output reg[31:0] currentAddress  
    );

    always@(posedge clk or negedge reset)
    begin
        if (~reset) 
		  begin
		  currentAddress <= 0;
		  end
		  else begin
		  if (PCWrite)
		  begin
		  currentAddress <= newAddress;
		  end
		  else begin
		  currentAddress <= currentAddress;
		  end
		  end
    end

endmodule
