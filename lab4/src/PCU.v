`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 11:31:56
// Design Name: 
// Module Name: PCU
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


module PCU(
    input clk,
    input rst,
    input [11:0] rgb,
    input [3:0] dir,
    output reg [7:0]x,
    output reg [7:0]y,
    output [15:0]paddr,
    output [11:0]pdata
    );
    
    wire [3:0] en_dir;
    assign paddr={x,y};
    assign pdata={rgb};
    
    Move_control dir1(clk,rst,dir[0],en_dir[0]);
    Move_control dir2(clk,rst,dir[1],en_dir[1]);
    Move_control dir3(clk,rst,dir[2],en_dir[2]);
    Move_control dir4(clk,rst,dir[3],en_dir[3]);
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            x <= 8'd128;
            y <= 8'd128;
        end
        else
        begin 
            if(en_dir[0]&&y>0)
            y<=y-1;
            else if(en_dir[1]&&y<255)
            y<=y+1;
            if(en_dir[2]&&x>0)
            x<=x-1;
            else if(en_dir[3]&&x<255)
            x<=x+1;
        end
    end

endmodule
