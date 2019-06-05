`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 12:50:05
// Design Name: 
// Module Name: seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg(
	input clk,
	input rst,
	input [31:0] data,
	output reg [7:0] sel,
	output reg [7:0] segment
	);
	
	reg [2:0] counter;
	wire [7:0] segment7;
	wire [7:0] segment6;
	wire [7:0] segment5;
	wire [7:0] segment4;
	wire [7:0] segment3;
	wire [7:0] segment2;
	wire [7:0] segment1;
	wire [7:0] segment0;
	decoder digit7(data[31:28], segment7);
	decoder digit6(data[27:24], segment6);
	decoder digit5(data[23:20], segment5);
	decoder digit4(data[19:16], segment4);
	decoder digit3(data[15:12], segment3);
	decoder digit2(data[11:8] , segment2);
	decoder digit1(data[7:4]  , segment1);
	decoder digit0(data[3:0]  , segment0);
	
	initial
		counter<=3'd0;
		
	always @(posedge clk or posedge rst)
	 begin
	 	if (rst)
	 	 begin
	 	 	counter<=3'd0;
	 	 	sel<=8'b0000_0000;
	 	 	segment<=8'b0000_0000;
	 	 end
	 	 else begin
	 	 	case (counter)
	 	 		3'd0: begin sel<=8'b01111111; segment<=segment7; end
	 	 		3'd1: begin sel<=8'b10111111; segment<=segment6; end
	 	 		3'd2: begin sel<=8'b11011111; segment<=segment5; end
	 	 		3'd3: begin sel<=8'b11101111; segment<=segment4; end
				3'd4: begin sel<=8'b11110111; segment<=segment3; end
	 	 		3'd5: begin sel<=8'b11111011; segment<=segment2; end
	 	 		3'd6: begin sel<=8'b11111101; segment<=segment1; end
	 	 		3'd7: begin sel<=8'b11111110; segment<=segment0; end
	 	 	endcase
	 	 	if (counter<3'd7) 
	 	 	   counter<=counter+3'd1;
	 	 	else 
	 	 	   counter<=3'b0;
	 	 end
	 end
endmodule
