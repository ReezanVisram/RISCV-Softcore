`timescale 1ns / 1ps

module data_memory(
    input clk_i,
    input write_enable_i,
    input [31:0] address_i,
    input [31:0] data_i,
    input [2:0] funct3_i,
    output reg [31:0] data_o
  );
  integer i;

  reg [7:0] memory [0:1023];

  always @(*)
  begin
    case (funct3_i)
      3'b000:
      begin
        data_o = {{24{memory[address_i][7]}}, memory[address_i]};
      end
      3'b001:
      begin
        data_o = {{16{memory[address_i + 1][7]}}, memory[address_i + 1], memory[address_i]};
      end
      3'b010:
      begin
        data_o = {memory[address_i + 3], memory[address_i + 2], memory[address_i + 1], memory[address_i]};
      end
      3'b100:
      begin
        data_o = {24'h000000, memory[address_i]};
      end
      3'b101:
      begin
        data_o = {16'h0000, memory[address_i + 1], memory[address_i]};
      end
      default:
      begin
        // NOP
      end
    endcase
  end

  always @(posedge clk_i)
  begin
    if (write_enable_i)
    begin
      case (funct3_i)
        3'b000:
        begin
          memory[address_i] <= data_i[7:0];
        end
        2'b001:
        begin
          memory[address_i] <= data_i[15:8];
          memory[address_i + 1] <= data_i[7:0];
        end
        2'b010:
        begin
          memory[address_i] <= data_i[31:24];
          memory[address_i + 1] <= data_i[23:16];
          memory[address_i + 2] <= data_i[15:8];
          memory[address_i + 3] <= data_i[7:0];
        end
        default:
        begin
          // NOP
        end
      endcase
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
