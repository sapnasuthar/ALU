module ALUControl(
  input  logic [6:0] funct7,
  input  logic [2:0] funct3,
  input  logic [6:0] opcode,
  output logic [3:0] ALUOp
);
  always_comb begin
    case (opcode)
      7'b0110011: begin // R-type
        case ({funct7, funct3})
          10'b0000000_000: ALUOp = 4'b0000; // ADD
          10'b0100000_000: ALUOp = 4'b0001; // SUB
          10'b0000000_111: ALUOp = 4'b0010; // AND
          10'b0000000_110: ALUOp = 4'b0011; // OR
          10'b0000000_100: ALUOp = 4'b0100; // XOR
          10'b0000000_001: ALUOp = 4'b0111; // SLL
          10'b0000000_101: ALUOp = 4'b1000; // SRL
          10'b0100000_101: ALUOp = 4'b1001; // SRA
          default: ALUOp = 4'b1111;
        endcase
      end
      default: ALUOp = 4'b1111;
    endcase
  end
endmodule
