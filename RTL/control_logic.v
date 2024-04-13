`timescale 1ns / 1ps

module control_logic(
    input [6:0] opcode_i,
    input [2:0] funct3_i,
    input [6:0] funct7_i,

    output reg reg_write_enable_o,
    output reg mem_write_enable_o,
    output reg [1:0] alu_src_o, // 00 = immediate_i, 01 = immediate_s, 10 = rs2, 11 = invalid
    output reg [1:0] reg_write_src_o // 00 = immediate_u, 01 = alu_result, 10 = data_mem_o, 11 = invalid
  );

  always @(*)
  begin
    case (opcode_i)
      7'b0110111: // LUI
      begin
        reg_write_enable_o = 1'b1;
        mem_write_enable_o = 1'b0;
        alu_src_o = 2'b11;
        reg_write_src_o = 2'b00;
      end
      7'b0000011: // LB, LH, LW
      begin
        reg_write_enable_o = 1'b1;
        mem_write_enable_o = 1'b0;
        alu_src_o = 2'b00;
        reg_write_src_o = 2'b10;
      end
      7'b0100011: // SB, SH, SW
      begin
        reg_write_enable_o = 1'b0;
        mem_write_enable_o = 1'b1;
        alu_src_o = 2'b01;
        reg_write_src_o = 2'b11;
      end
      default:
      begin

      end
    endcase
  end

endmodule
