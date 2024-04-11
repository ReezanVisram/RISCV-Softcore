`timescale 1ns / 1ps

module program_counter(
    input clk_i,
    input reset_i,
    input [31:0] address_i,
    output [31:0] address_o
  );
  reg [31:0] pc;

  assign address_o = pc;

  always @(posedge clk_i, posedge reset_i)
  begin
    if (reset_i)
    begin
      pc <= 32'h00000000;
    end
    else if (clk_i)
    begin
      pc <= address_i;
    end
  end

  initial
  begin
    pc <= 32'h00000000;
  end
endmodule
