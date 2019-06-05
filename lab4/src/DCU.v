`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 11:47:11
// Design Name: 
// Module Name: DCU
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


module DCU(
   input clk,
   input rst,
   input [7:0]x,
   input [7:0]y,
   input [11:0]vdata,
   output [15:0]vaddr,
   output reg [3:0]vga_r,
   output reg [3:0]vga_g,
   output reg [3:0]vga_b,
   output reg vga_hs,
   output reg vga_vs
    );
    
    parameter UP = 172,DOWN = 428,LEFT = 272,RIGHT = 528;
    parameter HSPW=120,HBP=64,H_en=800,HFP=56,H_SUM=1040;
    parameter VSPW=6,VBP=23,V_en=600,VFP=37,V_SUM=666;
    parameter cross_width=5;
    
    wire [7:0]x_clk,y_clk;
    reg[11:0]h_clk,v_clk;
    wire background_singal,paper_singal,cross_singal;
    
    assign x_clk=h_clk -(HSPW+HBP-1)- LEFT;
    assign y_clk=v_clk -(VSPW+VBP-1)- UP;
    assign vaddr=(paper_singal && background_singal) ? {x_clk,y_clk} : 0;
    
    assign cross_singal=(((x_clk<=x+cross_width)&&(x_clk>=x-cross_width))&&(y_clk==y))||(((y_clk<=y+cross_width)&&(y_clk>=y-cross_width))&&(x_clk==x));
    assign background_singal = (x_clk+LEFT > 0) && (h_clk < H_SUM-HFP) && (y_clk+UP > 0) && (v_clk < V_SUM-VFP);  
    assign paper_singal = (x_clk>=0 ) && (x_clk+LEFT< RIGHT) && (y_clk>= 0) && (y_clk+UP< DOWN);  
        
    
    always @(posedge clk or posedge rst) 
    begin  
         if (rst) 
           h_clk <= 12'd0;  
         else if (h_clk == H_SUM-1)
           h_clk <= 12'd0;
         else
           h_clk <= h_clk + 1;  
    end  
         
    always @(posedge clk or posedge rst) 
    begin  
         if (rst)
           v_clk <= 12'd0;  
         else if (v_clk ==V_SUM-1)
           v_clk <= 12'd0;  
         else if (h_clk == H_SUM-1)
           v_clk <= v_clk + 1;
   end  
       
    always @(posedge clk or posedge rst) 
    begin  
         if (rst)
           vga_hs <= 1'b0;
         else if (h_clk == 0)
           vga_hs <=1'b0; 
         else if (h_clk == HSPW-1)
           vga_hs <= 1'b1;
   end 
       
    always @(posedge clk or posedge rst) 
    begin  
         if (rst) 
           vga_vs <= 1'b0;
         else if (v_clk == 0)
           vga_vs <=1'b0;
         else if (v_clk == VSPW-1)
           vga_vs <= 1'b1;
    end    
    
      always @(posedge clk or posedge rst) begin  
        if (rst) 
           { vga_r,vga_b,vga_g} <=12'b0;
       else if(background_singal&&cross_singal)
            {vga_r,vga_g,vga_b}<=12'b0;
       else if(background_singal&&paper_singal)
            {vga_r,vga_g,vga_b}<=vdata;
       else if(background_singal)
            {vga_r,vga_g,vga_b}<=12'b0;
        end  
        
endmodule

