`timescale 1ns / 1ps

module arithmetic_logic_unit(
    input [2:0] alu_control_i,
    input [31:0] data_1_i,
    input [31:0] data_2_i,

    output reg [31:0] alu_result_o
  );

  always @(*)
  begin
    case (alu_control_i)
      3'b010: // Addition
      begin
        alu_result_o = data_1_i + data_2_i;
      end
    endcase

  end


endmodule
