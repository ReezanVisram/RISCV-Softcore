`timescale 1ns / 1ps

module instruction_memory(
    input [31:0] address_i,
    output [31:0] instruction_o
  );
  integer i;

  reg [7:0] rom [0:1023];

  assign instruction_o = {rom[address_i + 3], rom[address_i + 2], rom[address_i + 1], rom[address_i]};

  initial
  begin
    for (i = 0; i < 1024; i = i + 1)
    begin
      rom[i] = 32'h00000000;
    end
    // rom[0] = 32'h00402103;
    // rom[4] = 32'h00202423; // Store word in x2 at address x0 (0) + 8

    // Load word at address x0 (0) + 00000004 into x2
    rom[0] = 8'h03;
    rom[1] = 8'h21;
    rom[2] = 8'h40;
    rom[3] = 8'h00;

    // Load byte at address x0 (0) + 4 into x3
    rom[4] = 8'h83;
    rom[5] = 8'h01;
    rom[6] = 8'h40;
    rom[7] = 8'h00;

    // Load halfword at address x0 (0) + 4 into x4
    rom[8] = 8'h03;
    rom[9] = 8'h12;
    rom[10] = 8'h40;
    rom[11] = 8'h00;

    // Store byte in x2 at address x0(0) + 32
    rom[12] = 8'h23;
    rom[13] = 8'h00;
    rom[14] = 8'h20;
    rom[15] = 8'h02;

    // Store halfword in x2 at address x0 (0) + 48
    rom[16] = 8'h23;
    rom[17] = 8'h18;
    rom[18] = 8'h20;
    rom[19] = 8'h02;

    // Store word in x2 at address x0(0) + 64
    rom[20] = 8'h23;
    rom[21] = 8'h20;
    rom[22] = 8'h20;
    rom[23] = 8'h04;
  end
endmodule
