`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 17:19:06
// Design Name: 
// Module Name: Move_control
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


module Move_control(
    input clk,
    input rst,
    input dir,
    output en_dir
    );
    reg [20:0]cnt;
    assign en_dir=(cnt == 1) || (cnt >= 100);
    always @(posedge clk or posedge rst)
    begin
    if(rst)
        cnt<=0;
    else if(en_dir)
        cnt<=cnt+1;
    else 
        cnt<=0;
    end
endmodule

