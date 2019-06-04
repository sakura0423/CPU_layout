`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:51 04/11/2019
// Design Name: 
// Module Name:    alu 
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
module ALU(
 input signed [31:0] alu_a,
 input signed [31:0] alu_b,
 input [3:0] alu_op,
 input [2:0] AluzeroCtr,
 output reg [31:0] alu_out,
 output reg zero
);
parameter A_ADD = 4'b0010;
parameter A_SUB = 4'b0110;
parameter A_AND = 4'b0000;
parameter A_OR = 4'b0001;
parameter A_XOR = 4'b0111;
parameter A_NOR = 4'b1100;
parameter A_SLL = 4'b1000;
parameter A_SRL = 4'b1001;
parameter A_SRA = 4'b1010;
parameter A_LUI = 4'b1011;
parameter A_SLT = 4'b0011;

always @(*)
begin
    case (alu_op)
	  A_ADD : alu_out = alu_a + alu_b;
     A_SUB : alu_out = alu_a - alu_b;
     A_AND : alu_out = alu_a & alu_b;
     A_OR : alu_out = alu_a | alu_b;
     A_XOR : alu_out = alu_a ^ alu_b;
     A_NOR: alu_out = ~(alu_a | alu_b);
	  A_SLL: alu_out = alu_a << alu_b;
	  A_SRL: alu_out = alu_a >> alu_b;
	  A_SRA: alu_out = ($signed(alu_a)) >>> alu_b;
	  A_LUI: begin
	  alu_out[15:0] = alu_a[15:0];
	  alu_out[31:16] = alu_b[15:0];
	  end
	  A_SLT: alu_out = ((alu_a < alu_b)? 1 : 0); 
	  
     default: alu_out = 32'h0;
    endcase
end

always@(*)
begin
	case(AluzeroCtr)
	3'b000://equal to label
	begin
	if(alu_out == 0) zero = 1;
	else zero = 0;
	end
	
	3'b001://inequal to label
	begin
	if(alu_out != 0) zero = 1;
	else zero = 0;
	end
	
	3'b010://greater to label
	begin
	if(alu_out > 0) zero = 1;
	else zero = 0;
	end
	
	3'b011://greater or equal to label
	begin
	if(alu_out >= 0) zero = 1;
	else zero = 0;
	end
	
	3'b100://smaller to label
	begin
	if(alu_out < 0) zero = 1;
	else zero = 0;
	end
	
	3'b101://smaller or equal to label
	begin
	if(alu_out <= 0) zero = 1;
	else zero = 0;
	end
	
	3'b110://a >= to label
	begin
	if(alu_a >= 0) zero = 1;
	else zero = 0;
	end
	
	3'b111://a < to label
	begin
	if(alu_a < 0) zero = 1;
	else zero = 0;
	end
	default:;
	endcase
end

endmodule
