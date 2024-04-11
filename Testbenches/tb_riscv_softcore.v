`timescale 1ns / 1ps

module tb_riscv_softcore();

  reg clk = 0;
  parameter CLK_PERIOD = 10;

  // UUT
  RISCV_Softcore rv_softcore(
                   .clk(clk),
                   .ck_rst(ck_rst)
                 );

  always
  begin
    #(CLK_PERIOD/2) clk = ~clk;
  end


endmodule
