`timescale 1ns / 1ps

module RISCV_Softcore(
    input clk,
    input ck_rst
  );

  // Control Signals
  wire mem_to_reg;
  wire reg_write;
  wire mem_write;
  wire [1:0] alu_src; // 00 = immediate_i, 01 = immediate_s, 10 = rs2, 11 = invalid

  reg [2:0] alu_control;

  reg [31:0] pc_addition_constant;

  wire [31:0] next_instr_addr;
  wire [31:0] curr_instr_addr;

  wire [31:0] instruction;

  wire [31:0] reg_data_1;
  wire [31:0] reg_data_2;

  wire [6:0] opcode;
  wire [2:0] funct3;
  wire [6:0] funct7;

  wire [4:0] reg_select_1;
  wire [4:0] reg_select_2;
  wire [4:0] reg_select_d;

  wire [31:0] immediate_i;
  wire [31:0] immediate_s;
  wire [31:0] immediate_u;
  wire [31:0] immediate_b;
  wire [31:0] immediate_j;

  wire [31:0] reg_d_data;
  wire [31:0] alu_result;

  reg [31:0] write_data;

  reg [31:0] alu_input;

  always @(*)
  begin
    case (alu_src)
      2'b00:
      begin
        alu_input = immediate_i;
      end
      2'b01:
      begin
        alu_input = immediate_s;
      end
      2'b10:
      begin
        alu_input = reg_data_2;
      end
      default:
      begin

      end
    endcase

    write_data = reg_data_2;
  end

  control_logic ctrl_log(
                  .opcode_i(opcode),
                  .funct3_i(funct3),
                  .funct7_i(funct7),
                  .mem_to_reg_o(mem_to_reg),
                  .reg_write_o(reg_write),
                  .mem_write_o(mem_write),
                  .alu_src_o(alu_src)
                );


  program_counter pc(
                    .clk_i(clk),
                    .reset_i(ck_rst),
                    .address_i(next_instr_addr),
                    .address_o(curr_instr_addr)
                  );

  arithmetic_logic_unit pc_alu(
                          .alu_control_i(alu_control),
                          .data_1_i(curr_instr_addr),
                          .data_2_i(pc_addition_constant),
                          .alu_result_o(next_instr_addr)
                        );

  instruction_memory instr_mem(
                       .address_i(curr_instr_addr),
                       .instruction_o(instruction)
                     );

  instruction_decoder instr_dec(
                        .instruction_i(instruction),
                        .opcode_o(opcode),
                        .funct3_o(funct3),
                        .funct7_o(funct7),
                        .rs1_o(reg_select_1),
                        .rs2_o(reg_select_2),
                        .rd_o(reg_select_d),
                        .immediate_i_o(immediate_i),
                        .immediate_s_o(immediate_s),
                        .immediate_u_o(immediate_u),
                        .immediate_b_o(immediate_b),
                        .immediate_j_o(immediate_j)
                      );

  register_file reg_file(
                  .clk_i(clk),
                  .write_enable_i(reg_write),
                  .reg_select_1_i(reg_select_1),
                  .reg_select_2_i(reg_select_2),
                  .reg_select_d_i(reg_select_d),
                  .reg_data_d_i(reg_d_data),
                  .reg_data_1_o(reg_data_1),
                  .reg_data_2_o(reg_data_2)
                );

  arithmetic_logic_unit alu(
                          .alu_control_i(alu_control),
                          .data_1_i(reg_data_1),
                          .data_2_i(alu_input),
                          .alu_result_o(alu_result)
                        );

  data_memory data_mem(
                .clk_i(clk),
                .write_enable_i(mem_write),
                .address_i(alu_result),
                .data_i(write_data),
                .funct3_i(funct3),
                .data_o(reg_d_data)
              );
  initial
  begin
    pc_addition_constant = 32'h00000004;
    alu_control = 3'b010;
  end
endmodule
