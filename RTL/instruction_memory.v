`timescale 1ns / 1ps

module instruction_memory(
    input [31:0] address_i,
    output [31:0] instruction_o
  );
  integer i;

  reg [31:0] rom [0:255];

  assign instruction_o = rom[address_i];

  initial
  begin
    for (i = 1; i < 256; i = i + 1)
    begin
      rom[i] = 32'h00000000;
    end
    rom[0] = 32'h100000B7; // LUI 2^31 into R1
  end
endmodule
