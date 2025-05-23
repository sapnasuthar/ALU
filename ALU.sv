module ALU (
  input  logic [31:0] A, B,
  input  logic [3:0] ALUOp,
  output logic [31:0] Result,
  output logic Zero, Carry, Overflow, Negative
);

  logic [32:0] tmp;

  always_comb begin
    Carry = 0;
    Overflow = 0;
    case (ALUOp)
      4'b0000: begin // ADD
        tmp = A + B;
        Result = tmp[31:0];
        Carry = tmp[32];
        Overflow = (~A[31] & ~B[31] & Result[31]) | (A[31] & B[31] & ~Result[31]);
      end
      4'b0001: begin // SUB
        tmp = A - B;
        Result = tmp[31:0];
        Carry = tmp[32];
        Overflow = (A[31] & ~B[31] & ~Result[31]) | (~A[31] & B[31] & Result[31]);
      end
      4'b0010: Result = A & B;
      4'b0011: Result = A | B;
      4'b0100: Result = A ^ B;
      4'b0101: Result = ~A;
      4'b0110: Result = ~B;
      4'b0111: Result = A << B[4:0];
      4'b1000: Result = A >> B[4:0];
      4'b1001: Result = $signed(A) >>> B[4:0];
      default: Result = 32'd0;
    endcase

    Zero = (Result == 0);
    Negative = Result[31];
  end

endmodule

