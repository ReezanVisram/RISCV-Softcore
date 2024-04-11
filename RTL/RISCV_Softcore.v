`timescale 1ns / 1ps

module RISCV_Softcore(
    input clk,
    input ck_rst
  );
  reg write_pc;
  reg write_reg_file;

  wire [31:0] next_instr_addr;
  wire [31:0] curr_instr_addr;

  wire [31:0] instruction;

  wire [31:0] reg_data_1;
  wire [31:0] reg_data_2;

  program_counter pc(
                    .clk_i(clk),
                    .reset_i(ck_rst),
                    .write_enable_i(write_pc),
                    .address_i(next_instr_addr),
                    .address_o(curr_instr_addr)
                  );

  instruction_memory instr_mem(
                       .address_i(curr_instr_addr),
                       .instruction_o(instruction)
                     );

  register_file reg_file(
                  .clk_i(clk),
                  .write_enable_i(write_reg_file),
                  .reg_select_1_i(instruction[19:15]),
                  .reg_select_2_i(instruction[24:20]),
                  .reg_select_d_i(instruction[11:7]),
                  .reg_data_d_i({instruction[31:12], 12'h0000}),
                  .reg_data_1_o(reg_data_1),
                  .reg_data_2_o(reg_data_2)
                );

  initial
  begin
    write_pc = 0;
    write_reg_file = 1;
  end

endmodule;
