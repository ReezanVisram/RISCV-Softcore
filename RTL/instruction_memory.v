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

    // LUI 55555000 into x12
    rom[24] = 8'h37;
    rom[25] = 8'h56;
    rom[26] = 8'h55;
    rom[27] = 8'h55;

    // Add 2^12 to the PC (28) and store it in x6 (should be 29)
    rom[28] = 8'h17;
    rom[29] = 8'h13;
    rom[30] = 8'h00;
    rom[31] = 8'h00;

    // Jump to address 48 and store PC + 4 in x8
    rom[32] = 8'h67;
    rom[33] = 8'h04;
    rom[34] = 8'h00;
    rom[35] = 8'h03;
  end
endmodule
