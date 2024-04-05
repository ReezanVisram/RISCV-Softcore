`timescale 1ns / 1ps

module program_counter(
    input clk_i,
    input write_enable_i,
    input [31:0] address_i,
    output [31:0] address_o,
  );
  reg [31:0] pc;

  assign address_o = pc;

  always @(posedge clk_i)
  begin
    if (write_enable_i)
    begin
      pc <= address_i;
    end
  end
endmodule
