`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 00:15:45
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
    input reset,
    input cont,
    input step,
    input clk,
    input mem,
    input [7:0] addr,
    output [7:0] sel,
    output [7:0] seg,
    output [15:0] led
    );
    wire clk_slow_slow,clk_slow;
    wire [31:0] read;
    wire [31:0]  memory_addr,memory_data,register_addr,register_data;
    assign memory_addr={24'b00000000_00000000_00000000,addr[7:0]};
    assign register_addr={27'b00000000_00000000_00000000_000,addr[4:0]};
    assign read= mem ? memory_data:register_data;
    assign led = mem ? memory_addr:register_addr;
    
    MulticycleCPU CPU_MEM(
    .clk(step),
    .reset(reset),
    .memory_addr(memory_addr),
    .memory_data(memory_data),
    .register_addr(register_addr),
    .register_data(register_data)
    );
    
    //clk_divide clk_slow_seg_gen(clk, reset, clk_slow_seg);
    clk_wiz clk_slow_IP(
        .clk(clk), 
        .reset(reset), 
        .clk_slow_reg(clk_slow),
        .locked()
        );
        
    clk_divide clk_slow_seg_gen(clk_slow, reset, clk_slow_slow);
        
    seg data_displayer(
    .clk(clk_slow_slow),
    .rst(reset),
    .data(read),
    .sel(sel),
    .segment(seg)
    );
    
   // LED led_module();
endmodule
