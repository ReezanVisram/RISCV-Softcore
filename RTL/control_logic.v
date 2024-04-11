`timescale 1ns / 1ps

module control_logic(
    input [6:0] opcode_i,
    input [2:0] funct3_i,
    input [6:0] funct7_i,

    output alu_src_o,
    output [1:0] alu_op_o
  );

endmodule
