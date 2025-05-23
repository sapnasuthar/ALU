`timescale 1ns / 1ps

module ALU_Pipeline_tb;

  logic clk, rst;

  logic [31:0] A_in, B_in, instr_in;
  logic [31:0] Result_out;
  logic        Zero_out, Carry_out, Overflow_out, Negative_out;

  // DUT instantiation
  ALU_Pipeline dut (
    .clk(clk), .rst(rst),
    .A_in(A_in), .B_in(B_in), .instr_in(instr_in),
    .Result_out(Result_out),
    .Zero_out(Zero_out), .Carry_out(Carry_out),
    .Overflow_out(Overflow_out), .Negative_out(Negative_out)
  );

  // Clock generation
  always #5 clk = ~clk;

  // R-type instruction encoder
  function logic [31:0] encode_rtype(
    input [6:0] funct7,
    input [4:0] rs2, rs1,
    input [2:0] funct3,
    input [4:0] rd,
    input [6:0] opcode
  );
    return {funct7, rs2, rs1, funct3, rd, opcode};
  endfunction

  initial begin
    clk = 0;
    rst = 1;
    A_in = 0;
    B_in = 0;
    instr_in = 0;
    #20;
    rst = 0;

    $display("=== RISC-V Randomized ALU Tests ===");

    for (int i = 0; i < 10; i++) begin
      A_in = $urandom;
      B_in = $urandom;

      case (i % 5)
        0: instr_in = encode_rtype(7'b0000000, 5'd2, 5'd1, 3'b000, 5'd3, 7'b0110011); // ADD
        1: instr_in = encode_rtype(7'b0100000, 5'd2, 5'd1, 3'b000, 5'd3, 7'b0110011); // SUB
        2: instr_in = encode_rtype(7'b0000000, 5'd2, 5'd1, 3'b111, 5'd3, 7'b0110011); // AND
        3: instr_in = encode_rtype(7'b0000000, 5'd2, 5'd1, 3'b110, 5'd3, 7'b0110011); // OR
        4: instr_in = encode_rtype(7'b0000000, 5'd2, 5'd1, 3'b100, 5'd3, 7'b0110011); // XOR
      endcase

      #10;
      $display("Cycle %0d:", i);
      $display("  A     = 0x%h", A_in);
      $display("  B     = 0x%h", B_in);
      $display("  Instr = 0x%h", instr_in);
      $display("  Result= 0x%h | Z=%b N=%b", Result_out, Zero_out, Negative_out);
      $display("");
    end

    $display("=== Random ALU Test Complete ===");
    $finish;
  end

endmodule

