`timescale 1ns / 1ps

module control_logic(
    input [6:0] opcode_i,
    input [2:0] funct3_i,
    input [6:0] funct7_i,

    output alu_src_o,
  );

  always @(*)
  begin
    case (opcode_i)
      7'b011011:
      begin
        assign alu_src_o = 0'b0;
      end
      default:
        assign alu_src_o = 0'bX;
    endcase
  end
endmodule
