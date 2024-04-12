`timescale 1ns / 1ps

module control_logic(
    input [6:0] opcode_i,
    input [2:0] funct3_i,
    input [6:0] funct7_i,

    output mem_to_reg_o,
    output reg_write_o,
    output mem_write_o,
    output [1:0] alu_src_o, // 00 = immediate_i, 01 = immediate_s, 10 = rs2, 11 = xx
    output [1:0] mem_mode_o
  );

  always @(*)
  begin
    case (opcode_i)
      7'b0000011: // LB, LH, LW
      begin
        mem_to_reg_o = 1'b1;
        reg_write_o = 1'b1;
        mem_write_o = 1'b0;
        alu_src_o = 2'b00;
      end

      default:
      begin
        mem_to_reg_o = 1'bx;
        reg_write_o = 1'bx;
        mem_write_o = 1'bx;
        alu_src_o = 2'bxx;
        mem_mode_o = 2'bxx;
      end
    endcase
  end

endmodule
