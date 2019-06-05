`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 10:44:28
// Design Name: 
// Module Name: top
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


module top(
    input [11:0]rgb,
    input [3:0] dir,
    input en_draw,
    input clk,
    input rst,
    output [3:0]vga_r,
    output [3:0]vga_g,
    output [3:0]vga_b,
    output vga_hs,
    output vga_vs
    );
    
    wire [7:0]x,y;
    wire [15:0]paddr;
    wire [11:0]pdata;
    wire clk_slow;
    wire [15:0]vaddr;
    wire [11:0]vdata;
    
    clk_wiz tranfer(
        .clk_in(clk),
        .clk_out(clk_slow),
        .reset(rst)
        );
    
    dist_mem_gen VRAM(
        .a(paddr),
        .d(pdata),
        .clk(clk_slow),
        .we(en_draw),
        .dpo(vdata),
        .dpra(vaddr)
        );
   
    PCU pcu(
        .clk(vga_vs),
        .rst(rst),
        .rgb(rgb),
        .dir(dir),
        .x(x),
        .y(y),
        .paddr(paddr),
        .pdata(pdata)
        );
        
    DCU dcu(
        .clk(clk_slow),
        .rst(rst),
        .x(x),
        .y(y),
        .vdata(vdata),
        .vaddr(vaddr),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hs(vga_hs),
        .vga_vs(vga_vs)
    );
endmodule
