`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:30:33 04/30/2018 
// Design Name: 
// Module Name:    MulticycleCPU 
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
module MulticycleCPU(
	input clk,
	input reset,
	input  [31:0] memory_addr,
	output [31:0] memory_data,
	input  [31:0] register_addr,
    output [31:0] register_data
	);
	
	wire [1:0] ALUop,ALUSrcB,PCSrc;
	wire [2:0] Funct_im;
	wire [3:0] ALUControl;
    wire [4:0] Write_Register;
    wire [31:0] Read_Data1,Read_Data2,Write_Data;
	wire [31:0] A,B,newAddress,Mem_Data,Mem_Data_out,currentAddress,ALU_out,memaddr,Ins_out,ALU_A,ALU_B,ALUOut;
    wire [31:0] Extend_Immediate,JumpAddress;   
	
    wire Zero,lorD,PCen,Branch,PCWrite,IRWrite,ALUSrcA,RegWrite,MemtoReg,MemWrite,ExtSel,RegDst,Zero_Ctr;

	//assign out=Ins_out;
	assign PCen=(~Zero&Branch)|PCWrite;
	assign JumpAddress={currentAddress[31:28],Ins_out[25:0]};
	
	PC pc(clk,reset,PCen,newAddress,currentAddress);
	
	Mux Mux_lord(lorD,ALUOut,currentAddress,memaddr);
	
    ins_Data_Memory  Memory(
        .clk(clk),
        .we(MemWrite),
        .a(memaddr[7:0]),
        .d(B),
        .spo(Mem_Data),
        .dpra(memory_addr),
        .dpo(memory_data)
        );  
        
	InstrReg Instruction_reg(IRWrite,Mem_Data,Ins_out);
	
    Control control(clk,reset,Ins_out[31:26],PCSrc,ALUSrcA,ALUSrcB,lorD,MemtoReg,IRWrite,RegWrite,MemWrite,ExtSel,RegDst,Branch,PCWrite,ALUop,Zero_Ctr,Funct_im);

	Reg_clk Memory_data_register(clk,Mem_Data,Mem_Data_out);
	
	Mux Mux_MemtoReg(MemtoReg,Mem_Data_out,ALUOut,Write_Data);
	
	Mux #(4)Mux_RegDst(RegDst,Ins_out[15:11],Ins_out[20:16],Write_Register);
	
	REG_FILE Register_File(
	   .clk(clk),
	   .wEna(RegWrite),
	   .Read_Data1(Read_Data1),
	   .Read_Data2(Read_Data2),
	   .Write_Register(Write_Register),
	   .Write_Data(Write_Data),
	   .Read_Register1(Ins_out[25:21]),
       .Read_Register2(Ins_out[20:16]),
       .register_addr(register_addr),
       .register_data(register_data)
	   );
	   
	Reg_clk RegA(clk,Read_Data1,A);
	
	Reg_clk	RegB(clk,Read_Data2,B);
	
	SignExtend signex(
	   .en(ExtSel),
	   .Immediate(Ins_out[15:0]),
	   .Extend_Immediate(Extend_Immediate)
	   );
	   
    Mux	Mux_SrcA(ALUSrcA,A,currentAddress,ALU_A);
    
    Mux4to1 Mux_SrcB(ALUSrcB,B,32'd1,Extend_Immediate,Extend_Immediate,ALU_B);
    
	ALUcontrol ALU_con(
	.ALUop(ALUop),
	.funct(Ins_out[5:0]),
	.funct_imm(Funct_im),
	.ALUControl(ALUControl)
	);
	
	ALU alu(
	.alu_a(ALU_A),
	.alu_b(ALU_B),
	.alu_op(ALUControl),
	.Zero_Ctr(Zero_Ctr),
	.alu_out(ALU_out),
	.zero(Zero)
	);
	
	Reg_clk	Reg_ALU(clk,ALU_out,ALUOut);
	
	Mux3to1 MuxPC(PCSrc,ALU_out,ALUOut,JumpAddress,newAddress);
	
endmodule

