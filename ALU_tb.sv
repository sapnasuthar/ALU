// TESTBENCH
`timescale 1ns / 1ps

module alu_tb;

  // Inputs
  logic [31:0] A, B;
  logic [3:0]  ALUOp;

  // Outputs
  logic [31:0] Result;
  logic        Zero, Carry, Overflow, Negative;

  // Instantiate the ALU
  ALU uut (
    .A(A),
    .B(B),
    .ALUOp(ALUOp),
    .Result(Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow),
    .Negative(Negative)
  );

  // Test Procedure
  initial begin
    $display("Starting ALU Testbench...");

    // ADD (No overflow)
    A = 32'd10; B = 32'd5; ALUOp = 4'b0000; #10;
    $display("ADD: Result=%0d, C=%b, OF=%b, N=%b, Z=%b", Result, Carry, Overflow, Negative, Zero);

    // ADD (Overflow case)
    A = 32'sd2147483647; B = 32'sd1; ALUOp = 4'b0000; #10;
    $display("ADD Overflow: Result=%0d, C=%b, OF=%b, N=%b, Z=%b", Result, Carry, Overflow, Negative, Zero);

    // SUB (Zero + flag)
    A = 32'd15; B = 32'd15; ALUOp = 4'b0001; #10;
    $display("SUB (Zero): Result=%0d, C=%b, OF=%b, N=%b, Z=%b", Result, Carry, Overflow, Negative, Zero);

    // SUB (Overflow)
    A = -32'sd2147483648; B = 32'sd1; ALUOp = 4'b0001; #10;
    $display("SUB Overflow: Result=%0d, C=%b, OF=%b, N=%b, Z=%b", Result, Carry, Overflow, Negative, Zero);

    // AND
    A = 32'hFF00FF00; B = 32'h0F0F0F0F; ALUOp = 4'b0010; #10;
    $display("AND: Result=0x%h, Z=%b", Result, Zero);

    // OR
    A = 32'hAA00AA00; B = 32'h00FF00FF; ALUOp = 4'b0011; #10;
    $display("OR : Result=0x%h, Z=%b", Result, Zero);

    // XOR
    A = 32'hFFFF0000; B = 32'h0000FFFF; ALUOp = 4'b0100; #10;
    $display("XOR: Result=0x%h, Z=%b", Result, Zero);

    // NOT A
    A = 32'hAAAAAAAA; ALUOp = 4'b0101; #10;
    $display("NOT A: Result=0x%h, Z=%b", Result, Zero);

    // NOT B
    B = 32'h55555555; ALUOp = 4'b0110; #10;
    $display("NOT B: Result=0x%h, Z=%b", Result, Zero);

    // SHIFT LEFT
    A = 32'h00000001; B = 32'd4; ALUOp = 4'b0111; #10;
    $display("SLL: Result=0x%h, Z=%b", Result, Zero);

    // SHIFT RIGHT LOGICAL
    A = 32'h80000000; B = 32'd4; ALUOp = 4'b1000; #10;
    $display("SRL: Result=0x%h, Z=%b", Result, Zero);

    // SHIFT RIGHT ARITHMETIC
    A = -32'd16; B = 32'd2; ALUOp = 4'b1001; #10;
    $display("SRA: Result=%0d (0x%h), Z=%b", Result, Result, Zero);

    $display("Testbench complete.");
    $finish;
  end

endmodule

