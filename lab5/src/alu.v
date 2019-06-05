`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:51 04/11/2018 
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
    input Zero_Ctr,
    output reg [31:0] alu_out,
    output  zero
);
    parameter A_ADD = 4'b0010;
    parameter A_SUB = 4'b0110;
    parameter A_AND = 4'b0000;
    parameter A_OR  = 4'b0001;
    parameter A_XOR = 4'b0111;
    parameter A_NOR = 4'b1100;
    parameter A_SLT = 4'b0011;

    assign zero=(Zero_Ctr)?(alu_out?1:0):(alu_out?0:1);
    always @(*)
    begin
    case (alu_op)
	    A_ADD : alu_out =   alu_a + alu_b ;
        A_SUB : alu_out =   alu_a - alu_b ;
        A_AND : alu_out =   alu_a & alu_b ;
        A_OR  : alu_out =   alu_a | alu_b ;
        A_XOR : alu_out =   alu_a ^ alu_b ;
        A_NOR : alu_out = ~(alu_a | alu_b);
        A_SLT : alu_out = ((alu_a < alu_b)? 1 : 0);
     default: alu_out = 32'h0;
    endcase
 
end

endmodule

 /*  
    if(~Zero_Ctr)
        begin
	    if (alu_out)  
	       zero = 0;
        else  
           zero = 1;
        end
    else
        begin
        if (alu_out)  
            zero = 1;
        else  
            zero = 0;
    end
    */