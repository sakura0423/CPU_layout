`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:56 04/11/2019 
// Design Name: 
// Module Name:    control 
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
module Control(
	 input clk,
	 input reset,
	 input [5:0] op,                  // op操作符
	 output reg [1:0] PCSrc,         // PC多路选择器
     output reg ALUSrcA,
	 output reg [1:0] ALUSrcB,       // ALU多路选择器
	 output reg lorD,
     output reg MemtoReg,            // 多路选择器
	 output reg IRWrite,
     output reg RegWrite,            // (RF)写使能信号，为1时，在时钟上升沿写入
     output reg MemWrite,            // (DM)数据存储器读写控制信号，为1写，为0读
     output reg ExtSel,              // (EXT)控制补位，如果为1，进行符号扩展，如果为0，全补0
     output reg RegDst,              // 多路选择器
	 output reg Branch,
	 output reg PCWrite,
	 output reg [1:0] ALUop,
	 output reg Zero_Ctr,
	 output reg [2:0] Funct_im
);
reg [2:0] current_state,next_state;
parameter [5:0]  R_type = 6'b000000,
                  addi   = 6'b001000,
                  andi   = 6'b001100,
                  ori    = 6'b001101,
                  xori   = 6'b001110,
                  slti   = 6'b001010,   
                  sw     = 6'b101011,  
                  lw     = 6'b100011,
			      bqtz   = 6'b000111,
			      beq    = 6'b000100,
			      bne    = 6'b000101,
                  j      = 6'b000010,   
                  halt   = 6'b111111;

parameter [2:0] //IDLE = 3'b111,
			     IF   = 3'b000,   
                 ID   = 3'b001,  
                 EX   = 3'b010,  
                 MEM  = 3'b011,  
                 WB   = 3'b100;

    always @(posedge clk or posedge reset) 
    begin
	   if (reset)
	       begin
	       current_state <= IF;
	       //current_state <= IDLE;
	       //IRWrite <= 1;
	       end
	   else 
           current_state <= next_state;
    end

    always@(*)
    begin
    case(current_state)
    /*
	        IDLE: 
	           next_state <= IF;
	*/
            IF: 
               next_state <= ID;
            ID: 
               next_state <= EX;
		    EX: 
			     begin
			     if (op == bqtz||op == j||op ==beq||op ==bne)
			         next_state <= IF;
			     else
			         next_state <= MEM;
			     end
			MEM: 
			     begin
			     if(op == lw)
			         next_state <= WB;
			     else
			         next_state <= IF;
			     end
			WB: 
			     next_state <= IF;
			default:;
		endcase
	end

    always@(posedge clk or posedge reset)
    begin
	   lorD <= 0;
	   Branch <= 0;//
	   PCWrite <= 0;
	   IRWrite <= 0;
	   RegDst <= 0;
	   ALUSrcA <= 0;
	   ALUSrcB <= 2'b01;
       ExtSel <= 0;//
       RegWrite <= 0;
       MemWrite <= 0;
       MemtoReg <= 0;
	   ALUop <= 2'b00;
	   PCSrc <= 2'b00;
	   Zero_Ctr <= 0;
	   Funct_im <= 3'b000;
	if (reset) ;
	else
	   begin
	   case (next_state)

		IF:
		  PCWrite <= 1;
		
		ID:
		  begin
		  ALUSrcB <= 2'b11;
		  IRWrite <= 1;
		  ExtSel <= 1;
		  end
		
		EX:
		  begin
		  case(op)
	      lw,sw:
	           begin
			   ALUSrcA <= 1;
			   ALUSrcB <= 2'b10;
			   ExtSel <= 1;
			   end
			
		  R_type:
		      begin
			  ALUSrcA <= 1;
			  ALUSrcB <= 2'b00;
			  ALUop <= 2'b10;
			  end
			
		  bne:
		      begin
              ALUSrcA <= 1;
              ALUSrcB <= 2'b00;
              ALUop <= 2'b01;
              PCSrc <= 2'b01;
              Branch <= 1;
              ExtSel <= 1;
              Zero_Ctr <= 0;
              end
		  beq:
		      begin
              ALUSrcA <= 1;
              ALUSrcB <= 2'b00;
              ALUop <= 2'b01;
              PCSrc <= 2'b01;
              Branch <= 1;
              ExtSel <= 1;
              Zero_Ctr <= 1;
              end

			
		  addi:
		  begin
                        ALUop <= 2'b11;
                        ALUSrcA <= 1;
                        ALUSrcB <= 2'b10;
                        ExtSel <= 1;
                        Funct_im <= 3'b000;
                        end
		  
		  andi:
		  begin
                        ALUop <= 2'b11;
                        ALUSrcA <= 1;
                        ALUSrcB <= 2'b10;
                        ExtSel <= 1;
                        Funct_im <= 3'b001;
                        end
		  ori:
		  begin
                        ALUop <= 2'b11;
                        ALUSrcA <= 1;
                        ALUSrcB <= 2'b10;
                        ExtSel <= 1;
                        Funct_im <= 3'b010;
                        end
		  xori:
		  begin
                        ALUop <= 2'b11;
                        ALUSrcA <= 1;
                        ALUSrcB <= 2'b10;
                        ExtSel <= 1;
                        Funct_im <= 3'b011;
                        end
		  slti:
		      begin
		      ALUop <= 2'b11;
			  ALUSrcA <= 1;
			  ALUSrcB <= 2'b10;
			  ExtSel <= 1;
			  Funct_im <= 3'b100;
			  end
			
		  j:
		      begin
			  PCSrc <= 2'b10;
			  PCWrite <= 1;
			  end
		endcase
		end
		
		MEM:
		  begin
		  case(op)
			lw:
			     lorD <= 1;
			sw:
			     begin
			     lorD <= 1;
			     MemWrite <= 1;
			     end
			R_type:
			     begin
			     RegDst <= 1;
			     RegWrite <= 1;
			     end
			addi,andi,ori,xori,slti:
			     RegWrite <= 1;
			endcase
		end
		 
		WB:
		begin
			MemtoReg <= 1;
			RegWrite <= 1;
		end
		default:;
	endcase
	end
end


endmodule


