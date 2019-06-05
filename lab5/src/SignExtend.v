`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:52 04/25/2018 
// Design Name: 
// Module Name:    SignExtend 
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
module SignExtend(
    input en,                
    input [15:0] Immediate,        
    output [31:0] Extend_Immediate   
    );

    assign Extend_Immediate[15:0] = Immediate;
    assign Extend_Immediate[31:16] = en ? (Immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;

endmodule
