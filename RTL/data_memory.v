`timescale 1ns / 1ps

module data_memory(
    input clk_i,
    input write_enable_i,
    input [31:0] address_i,
    input [31:0] data_i,
    output [31:0] data_o
  );
  integer i;

  reg [31:0] memory [0:255];

  assign data_o = memory[address_i];

  always @(posedge clk_i)
  begin
    if (write_enable_i)
    begin
      memory[address_i] <= data_i;
    end
  end

  initial
  begin
    for (i = 1; i < 256; i = i + 1)
    begin
      memory[i] = 0;
    end
    memory[4] = 32'h88913416;
  end
endmodule
