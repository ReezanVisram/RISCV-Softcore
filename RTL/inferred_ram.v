`timescale 1ns / 1ps

module inferred_ram(
    input clk_i,
    input write_enable_i,
    input [31:0] address_i,
    input [31:0] data_i,
    output reg [31:0] data_o
  );

  reg [31:0] memory [0:2047];

  always @(posedge clk_i)
  begin
    if (write_enable_i)
    begin
      memory[address_i] <= data_i;
    end
    else
    begin
      data_o <= memory[address_i];
    end
  end

  initial
  begin
    memory[0] = 32'hffffffff;
  end

endmodule
