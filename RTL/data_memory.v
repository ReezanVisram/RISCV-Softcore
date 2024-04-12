`timescale 1ns / 1ps

module data_memory(
    input clk_i,
    input write_enable_i,
    input [31:0] address_i,
    input [1:0] mem_mode_i,
    input [31:0] data_i,
    output reg [31:0] data_o
  );
  integer i;

  reg [7:0] memory [0:1023];

  always @(*)
  begin
    case (mem_mode_i)
      2'b00:
      begin
        data_o = {memory[address_i], 24'h000000};
      end
      2'b01:
      begin
        data_o = {memory[address_i + 1], memory[address_i], 16'h0000};
      end
      2'b10:
      begin
        data_o = {memory[address_i + 3], memory[address_i + 2], memory[address_i + 1], memory[address_i]};
      end
      default:
      begin
        data_o = 32'bX;
      end
    endcase
  end

  always @(posedge clk_i)
  begin
    if (write_enable_i)
    begin
      memory[address_i] <= data_i;
    end
  end

  initial
  begin
    for (i = 0; i < 256; i = i + 1)
    begin
      memory[i] = 0;
    end
    // memory[4] = 32'h88913416;
    memory[4] = 8'h16;
    memory[5] = 8'h34;
    memory[6] = 8'h91;
    memory[7] = 8'h88;
  end
endmodule
