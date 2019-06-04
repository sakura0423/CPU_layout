`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:40 05/28/2018 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
	 input clk,
	 input rst_n,
	 input continue_sig,
	 input [5:0] board_mem_read_addr,
	 output [31:0] board_mem_read_result,
	 output at_breakpoint
);
	  
	 wire jump_taken;
	 wire branch_taken;
	 
	 wire [31:0] if_id_instruction;
	 wire [31:0] if_id_pc_next;
	 
	 wire [4:0] id_ex_rs;
	 wire [4:0] id_ex_rt;
	 wire [4:0] id_ex_rd;
	 wire [31:0] id_ex_imm_sign_extended;
	 wire [4:0] id_ex_shamt;
	 reg [31:0] id_ex_reg_a_data;
	 reg [31:0] id_ex_reg_b_data;
	 wire [31:0] id_ex_pc_next;
	 wire [3:0] id_ex_ctrl_alu_control;
	 wire id_ex_ctrl_alu_src;
	 wire id_ex_ctrl_alu_shift_shamt;
	 wire id_ex_ctrl_branch;
	 wire id_ex_ctrl_jump;
	 wire id_ex_ctrl_jump_reg;
	 wire [2:0] id_ex_ctrl_load_type;
	 wire [1:0] id_ex_ctrl_store_type;
	 wire [2:0] id_ex_ctrl_branch_type;
	 wire id_ex_ctrl_mem_to_reg;
	 wire id_ex_ctrl_mem_write;
	 wire id_ex_ctrl_reg_dst;
	 wire id_ex_ctrl_reg_write;
	 
	 assign at_breakpoint = stall_breakpoint;
	 	
	 wire ex_mem_alu_beq_sig;
	 wire ex_mem_alu_bgez_sig;
	 wire ex_mem_alu_bgtz_sig;
	 wire ex_mem_alu_blez_sig;
	 wire ex_mem_alu_bltz_sig;
	 wire ex_mem_alu_bne_sig;
	 wire [31:0] ex_mem_alu_out;
	 wire ex_mem_ctrl_branch;
	 wire [2:0] ex_mem_ctrl_branch_type;
	 wire ex_mem_ctrl_jump;
	 wire ex_mem_ctrl_jump_reg;
	 wire [2:0] ex_mem_ctrl_load_type;
	 wire ex_mem_ctrl_mem_to_reg;
	 wire ex_mem_ctrl_mem_write;
	 wire ex_mem_ctrl_reg_write;
	 wire [1:0] ex_mem_ctrl_store_type;
	 wire [31:0] ex_mem_pc_branch;
	 wire [31:0] ex_mem_pc_jump;
	 wire [4:0] ex_mem_rd;
	 wire [31:0] ex_mem_reg_b_data;
		
	 wire [2:0] mem_wb_ctrl_load_type;
	 wire mem_wb_ctrl_reg_write;
	 wire mem_wb_ctrl_mem_to_reg;
	 wire [31:0] mem_wb_data;
	 wire [4:0] mem_wb_rd;
	 wire [1:0] mem_wb_low_two_bits;
	 
	 wire final_reg_write;
	 wire [31:0] final_data_reg_write;
	 wire [4:0] final_dst_reg_write;

	 wire [31:0] regfile_reg_a_data;
	 wire [31:0] regfile_reg_b_data;
	 
	 wire flush_if;
	 wire flush_id;
	 wire flush_ex;
	 wire stall;
	 wire stall_breakpoint;
	 wire continue_en;
	 
	 if_stage instruction_fetch (
    .clk(clk), 
    .rst_n(rst_n), 
    .jump_taken(jump_taken), 
    .branch_taken(branch_taken), 
    .pc_jump(ex_mem_pc_jump), 
    .pc_branch(ex_mem_pc_branch), 
    .if_id_instruction(if_id_instruction), 
    .if_id_pc_next(if_id_pc_next),
	 .flush_if(flush_if),
	 .stall(stall),
	 .stall_breakpoint(stall_breakpoint),
	 .continue_en(continue_en)
    );

	 id_stage instruction_decode (
    .clk(clk), 
    .rst_n(rst_n), 
    .if_id_instruction(if_id_instruction), 
    .if_id_pc_next(if_id_pc_next), 
    .id_ex_rs(id_ex_rs), 
    .id_ex_rt(id_ex_rt), 
    .id_ex_rd(id_ex_rd), 
    .id_ex_imm_sign_extended(id_ex_imm_sign_extended), 
    .id_ex_shamt(id_ex_shamt), 
    .id_ex_pc_next(id_ex_pc_next), 
    .id_ex_ctrl_alu_control(id_ex_ctrl_alu_control), 
    .id_ex_ctrl_alu_src(id_ex_ctrl_alu_src), 
    .id_ex_ctrl_alu_shift_shamt(id_ex_ctrl_alu_shift_shamt), 
    .id_ex_ctrl_branch(id_ex_ctrl_branch), 
    .id_ex_ctrl_jump(id_ex_ctrl_jump), 
    .id_ex_ctrl_jump_reg(id_ex_ctrl_jump_reg), 
    .id_ex_ctrl_load_type(id_ex_ctrl_load_type), 
    .id_ex_ctrl_store_type(id_ex_ctrl_store_type), 
    .id_ex_ctrl_branch_type(id_ex_ctrl_branch_type), 
    .id_ex_ctrl_mem_to_reg(id_ex_ctrl_mem_to_reg), 
    .id_ex_ctrl_mem_write(id_ex_ctrl_mem_write), 
    .id_ex_ctrl_reg_dst(id_ex_ctrl_reg_dst), 
    .id_ex_ctrl_reg_write(id_ex_ctrl_reg_write), 
    .stall(stall),
	 .flush_id(flush_id),
	 .stall_breakpoint(stall_breakpoint),
	 .continue_sig(continue_sig),
	 .continue_en(continue_en)
    );
	 
	 ex_stage instruction_execute (
    .clk(clk), 
    .rst_n(rst_n), 
    .id_ex_rs(id_ex_rs), 
    .id_ex_rt(id_ex_rt), 
    .id_ex_rd(id_ex_rd), 
    .id_ex_imm_sign_extended(id_ex_imm_sign_extended), 
    .id_ex_shamt(id_ex_shamt), 
    .id_ex_reg_a_data(id_ex_reg_a_data), 
    .id_ex_reg_b_data(id_ex_reg_b_data), 
    .id_ex_pc_next(id_ex_pc_next), 
    .id_ex_ctrl_alu_control(id_ex_ctrl_alu_control), 
    .id_ex_ctrl_alu_src(id_ex_ctrl_alu_src), 
    .id_ex_ctrl_alu_shift_shamt(id_ex_ctrl_alu_shift_shamt), 
    .id_ex_ctrl_branch(id_ex_ctrl_branch), 
    .id_ex_ctrl_jump(id_ex_ctrl_jump), 
    .id_ex_ctrl_jump_reg(id_ex_ctrl_jump_reg), 
    .id_ex_ctrl_load_type(id_ex_ctrl_load_type), 
    .id_ex_ctrl_store_type(id_ex_ctrl_store_type), 
    .id_ex_ctrl_branch_type(id_ex_ctrl_branch_type), 
    .id_ex_ctrl_mem_to_reg(id_ex_ctrl_mem_to_reg), 
    .id_ex_ctrl_mem_write(id_ex_ctrl_mem_write), 
    .id_ex_ctrl_reg_dst(id_ex_ctrl_reg_dst), 
    .id_ex_ctrl_reg_write(id_ex_ctrl_reg_write), 
    .mem_wb_data(mem_wb_data), 
    .mem_wb_rd(mem_wb_rd), 
    .mem_wb_ctrl_reg_write(mem_wb_ctrl_reg_write), 
    .ex_mem_alu_beq_sig(ex_mem_alu_beq_sig), 
    .ex_mem_alu_bgez_sig(ex_mem_alu_bgez_sig), 
    .ex_mem_alu_bgtz_sig(ex_mem_alu_bgtz_sig), 
    .ex_mem_alu_blez_sig(ex_mem_alu_blez_sig), 
    .ex_mem_alu_bltz_sig(ex_mem_alu_bltz_sig), 
    .ex_mem_alu_bne_sig(ex_mem_alu_bne_sig), 
    .ex_mem_alu_out(ex_mem_alu_out), 
    .ex_mem_ctrl_branch(ex_mem_ctrl_branch), 
    .ex_mem_ctrl_branch_type(ex_mem_ctrl_branch_type), 
    .ex_mem_ctrl_jump(ex_mem_ctrl_jump), 
    .ex_mem_ctrl_jump_reg(ex_mem_ctrl_jump_reg), 
    .ex_mem_ctrl_load_type(ex_mem_ctrl_load_type), 
    .ex_mem_ctrl_mem_to_reg(ex_mem_ctrl_mem_to_reg), 
    .ex_mem_ctrl_mem_write(ex_mem_ctrl_mem_write), 
    .ex_mem_ctrl_reg_write(ex_mem_ctrl_reg_write), 
    .ex_mem_ctrl_store_type(ex_mem_ctrl_store_type), 
    .ex_mem_pc_branch(ex_mem_pc_branch), 
    .ex_mem_pc_jump(ex_mem_pc_jump), 
    .ex_mem_rd(ex_mem_rd), 
    .ex_mem_reg_b_data(ex_mem_reg_b_data),
	 .flush_ex(flush_ex)
    );
	 
	 mem_stage instruction_mem (
    .clk(clk), 
    .rst_n(rst_n), 
    .ex_mem_alu_beq_sig(ex_mem_alu_beq_sig), 
    .ex_mem_alu_bgez_sig(ex_mem_alu_bgez_sig), 
    .ex_mem_alu_bgtz_sig(ex_mem_alu_bgtz_sig), 
    .ex_mem_alu_blez_sig(ex_mem_alu_blez_sig), 
    .ex_mem_alu_bltz_sig(ex_mem_alu_bltz_sig), 
    .ex_mem_alu_bne_sig(ex_mem_alu_bne_sig), 
    .ex_mem_alu_out(ex_mem_alu_out), 
    .ex_mem_ctrl_branch(ex_mem_ctrl_branch), 
    .ex_mem_ctrl_branch_type(ex_mem_ctrl_branch_type), 
    .ex_mem_ctrl_jump(ex_mem_ctrl_jump), 
    .ex_mem_ctrl_jump_reg(ex_mem_ctrl_jump_reg), 
    .ex_mem_ctrl_load_type(ex_mem_ctrl_load_type), 
    .ex_mem_ctrl_mem_to_reg(ex_mem_ctrl_mem_to_reg), 
    .ex_mem_ctrl_mem_write(ex_mem_ctrl_mem_write), 
    .ex_mem_ctrl_reg_write(ex_mem_ctrl_reg_write), 
    .ex_mem_ctrl_store_type(ex_mem_ctrl_store_type), 
    .ex_mem_pc_branch(ex_mem_pc_branch), 
    .ex_mem_pc_jump(ex_mem_pc_jump), 
    .ex_mem_rd(ex_mem_rd), 
    .ex_mem_reg_b_data(ex_mem_reg_b_data), 
    .branch_taken(branch_taken), 
    .jump_taken(jump_taken), 
    .mem_wb_ctrl_load_type(mem_wb_ctrl_load_type), 
    .mem_wb_ctrl_reg_write(mem_wb_ctrl_reg_write), 
    .mem_wb_data(mem_wb_data), 
    .mem_wb_rd(mem_wb_rd), 
    .mem_wb_low_two_bits(mem_wb_low_two_bits),
	 .mem_wb_ctrl_mem_to_reg(mem_wb_ctrl_mem_to_reg),
	 .board_mem_read_addr(board_mem_read_addr),
	 .board_mem_read_result(board_mem_read_result)
    );
	 
	 wb_stage instruction_write_back (
    .mem_wb_ctrl_load_type(mem_wb_ctrl_load_type), 
    .mem_wb_ctrl_reg_write(mem_wb_ctrl_reg_write), 
    .mem_wb_rd(mem_wb_rd), 
    .mem_wb_data(mem_wb_data), 
    .mem_wb_low_two_bits(mem_wb_low_two_bits), 
    .final_reg_write(final_reg_write), 
    .final_data_reg_write(final_data_reg_write), 
    .final_dst_reg_write(final_dst_reg_write),
	 .mem_wb_ctrl_mem_to_reg(mem_wb_ctrl_mem_to_reg)
    );

	 flush_control flush_control_module (
    .branch_taken(branch_taken), 
    .jump_taken(jump_taken), 
    .flush_if(flush_if), 
    .flush_id(flush_id), 
    .flush_ex(flush_ex)
    );
	
	 reg_file regfile_stack (
    .clk(clk), 
    .rst_n(rst_n), 
    .rAddr(if_id_instruction[25:21]), 
    .rDout(regfile_reg_a_data), 
    .rAddr2(if_id_instruction[20:16]), 
    .rDout2(regfile_reg_b_data), 
    .wAddr(final_dst_reg_write), 
    .wIn(final_data_reg_write), 
    .wEna(final_reg_write)
    );
	 
	 always @(posedge clk or negedge rst_n)
	 begin
	   if (~rst_n)
		begin
		  id_ex_reg_a_data <= 32'b0;
		  id_ex_reg_b_data <= 32'b0;
		end
		else
		begin
		  id_ex_reg_a_data <= regfile_reg_a_data;
		  id_ex_reg_b_data <= regfile_reg_b_data;
		end
	 end
endmodule
