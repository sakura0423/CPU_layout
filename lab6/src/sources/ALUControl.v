`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:52:17 04/29/2019 
// Design Name: 
// Module Name:    ALUControl 
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
module ALUcontrol(
	input [2:0] ALUop,
	input [5:0] funct,
	output reg [3:0] ALUControl,
	output reg ALUSrc_shamt
    );
always@(*)
begin
	ALUSrc_shamt = 0;
	case(ALUop)
		3'b010:
		begin
		case(funct)
		6'b100000: ALUControl = 4'b0010;//add
		6'b100001: ALUControl = 4'b0010;//addu
		6'b100010: ALUControl = 4'b0110;//sub
		6'b100011: ALUControl = 4'b0110;//subu
		6'b100100: ALUControl = 4'b0000;//and
		6'b100101: ALUControl = 4'b0001;//or
		6'b100111: ALUControl = 4'b1100;//nor
		6'b100011: ALUControl = 4'b0111;//xor
		6'b000000: begin//sll
		ALUSrc_shamt = 1;
		ALUControl = 4'b1000;
		end
		6'b000100: ALUControl = 4'b1000;//sllv
		6'b000010: begin//srl
		ALUSrc_shamt = 1;
		ALUControl = 4'b1001;
		end
		6'b000110: ALUControl = 4'b1001;//srlv
		6'b000011: begin//sra
		ALUSrc_shamt = 1;
		ALUControl = 4'b1010;
		end
		6'b000111: ALUControl = 4'b1010;//srav
		6'b101100: ALUControl = 4'b0011;//slt
		6'b101101: ALUControl = 4'b0011;//sltu
		6'b001000: ALUControl = 4'b0010;//jr
		
		default: ALUControl = 4'b1111;
		endcase
		end
		
		3'b000: ALUControl = 4'b0010;//add
		3'b001: ALUControl = 4'b0110;//sub
		3'b011: ALUControl = 4'b0000;//and
		3'b100: ALUControl = 4'b0001;//or
		3'b101: ALUControl = 4'b0111;//xor
		3'b110: ALUControl = 4'b1011;//lui
		3'b111: ALUControl = 4'b0011;//slt
		default:;
	endcase
end
endmodule
