`timescale 1ns / 1ps

module alu(
    input [31:0] data_1_i,
    input [31:0] data_2_i,
    input [2:0] funct3_i,
    input [6:0] funct7_i,

    output [31:0] alu_result_o
  );

  always @(*)
  begin
    case (funct3_i)
      3'b000:
      begin
        if (funct7_i[5])
        begin
          alu_result_o = data_1_i - data_2_i;
        end
        else
        begin
          alu_result_o = data_1_i + data_2_i;
        end
      end
      3'b001:
      begin
        alu_result_o = data_1_i << data_2_i;
      end
      3'b010:
      begin
        if ($signed(data_1_i) < $signed(data_2_i))
        begin
          alu_result_o = 8'h00000001;
        end
        else
        begin
          alu_result_o = 8'h00000000;
        end
      end
      3'b011:
      begin
        if (data_1_i < data_2_i)
        begin
          alu_result_o = 8'h00000001;
        end
        else
        begin
          alu_result_o = 8'h00000000;
        end
      end
      3'b100:
      begin
        alu_result_o = data_1_i ^ data_2_i;
      end
      3'b101:
      begin
        if (funct7_i[5])
        begin
          alu_result_o = data_1_i >>> data_2_i;
        end
        else
        begin
          alu_result_o = data_1_i >> data_2_i;
        end
      end
      3'b110:
      begin
        alu_result_o = data_1_i | data_2_i;
      end
      3'b111:
      begin
        alu_result_o = data_1_i & data_2_i;
      end
    endcase
  end
endmodule
