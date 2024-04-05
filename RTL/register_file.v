`timescale 1ns / 1ps

module register_file(
    input clk_i,
    input write_enable_i,
    input [4:0] reg_select_1_i,
    input [4:0] reg_select_2_i,
    input [4:0] reg_select_d_i,
    input [31:0] reg_data_d_i,

    output [31:0] reg_data_1_o,
    output [31:0] reg_data_2_o
  );

  reg [31:0] register_file [31:0];

  assign register_file[0] = 5'b00000;
  assign reg_data_1_o = register_file[reg_select_1_i];
  assign reg_data_2_o = register_file[reg_select_2_i];

  always @(posedge clk_i)
  begin
    if (write_enable_i)
    begin
      if (reg_select_d_i != 5'b00000)
      begin
        register_file[reg_select_d_i] <= reg_data_d_i;
      end
    end
  end

endmodule
