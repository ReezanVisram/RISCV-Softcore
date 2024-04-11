`timescale 1ns / 1ps

module instruction_decoder(
    input [31:0] instruction_i,

    output [6:0] opcode_o,
    output [2:0] funct3_o,
    output [6:0] funct7_o,

    output [4:0] rs1_o,
    output [4:0] rs2_o,
    output [4:0] rd_o,

    // All immediates are sign-extended to 32 bits
    output [31:0] immediate_i_o,
    output [31:0] immediate_s_o,
    output [31:0] immediate_u_o,
    output [31:0] immediate_b_o,
    output [31:0] immediate_j_o
  );
  assign opcode_o = instruction_i[6:0];
  assign rd_o = instruction_i[11:7];
  assign funct3_o = instruction_i[14:12];
  assign rs1_o = instruction_i[19:15];
  assign rs2_o = instruction_i[24:20];

  assign immediate_i_o = {{20{instruction_i[31]}}, instruction_i[31:20]};
  assign immediate_s_o = {{20{instruction_i[31]}}, instruction_i[31:25], instruction_i[11:7]};
  assign immediate_u_o = {instruction_i[31:12], 4'h000};
  assign immediate_b_o = {{20{instruction_i[31]}}, instruction_i[31], instruction_i[7], instruction_i[30:25], instruction_i[11:8], 0'b0};
  assign immedaite_j_o = {{12{instruction_i[31]}}, instruction_i[31], instruction_i[19:12], instruction_i[20], instruction_i[30:21]};

endmodule
