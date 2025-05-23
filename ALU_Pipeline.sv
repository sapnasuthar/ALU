module ALU_Pipeline(
  input  logic clk, rst,
  input  logic [31:0] A_in, B_in,
  input  logic [31:0] instr_in,
  output logic [31:0] Result_out,
  output logic Zero_out, Carry_out, Overflow_out, Negative_out
);

  // Stage 1 registers
  logic [31:0] A_reg, B_reg;
  logic [3:0]  ALUOp;
  logic [31:0] instr_reg;

  // Decoded instruction fields
  logic [6:0] opcode, funct7;
  logic [4:0] rd, rs1, rs2;
  logic [2:0] funct3;

  // Stage 2 outputs
  logic [31:0] Result_comb;
  logic Zero_comb, Carry_comb, Overflow_comb, Negative_comb;

  // Register stage 1
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      A_reg <= 0;
      B_reg <= 0;
      instr_reg <= 0;
    end else begin
      A_reg <= A_in;
      B_reg <= B_in;
      instr_reg <= instr_in;
    end
  end

  // Decode instruction
  InstructionDecoder decoder (
    .instruction(instr_reg),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
  );

  // Generate ALUOp
  ALUControl control (
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .ALUOp(ALUOp)
  );

  // ALU core
  ALU alu_inst (
    .A(A_reg),
    .B(B_reg),
    .ALUOp(ALUOp),
    .Result(Result_comb),
    .Zero(Zero_comb),
    .Carry(Carry_comb),
    .Overflow(Overflow_comb),
    .Negative(Negative_comb)
  );

  // Stage 2 output registers
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      Result_out <= 0;
      Zero_out <= 0;
      Carry_out <= 0;
      Overflow_out <= 0;
      Negative_out <= 0;
    end else begin
      Result_out <= Result_comb;
      Zero_out <= Zero_comb;
      Carry_out <= Carry_comb;
      Overflow_out <= Overflow_comb;
      Negative_out <= Negative_comb;
    end
  end

endmodule

