module ALU(
	 input	clk,
    input [31:0] A, // 32-bit input A
    input [31:0] B, // 32-bit input B
    input [3:0] ALUControl, // 4-bit ALU control
    input [4:0] ShiftAmount, // 5-bit input for shift amount
    output reg [31:0] ALUOut, // 32-bit output
    output reg Zero // Zero flag
   // output reg Overflow, // Overflow flag
   // output reg CarryOut // Carry-out flag
);
reg Overflow;
reg CarryOut;
//reg [31:0] ALUOut;
/*
addu 
subu

*/
always @(*) begin
    case(ALUControl)
        4'b0000: ALUOut <= A + B; // Addition (signed)
        4'b0001: ALUOut <= A - B; // Subtraction (signed)
        4'b0010: ALUOut <= A * B; // Multiplication (signed)
        4'b0011: ALUOut <= A / B; // Division (signed/unsigned)
        4'b0100: ALUOut <= A << ShiftAmount; // Logical shift left
        4'b0101: ALUOut <= A >> ShiftAmount; // Logical shift right
    //  4'b0110: ALUOut <= {A[30:0], A[31]}; // Rotate left ERROR
    //  4'b0111: ALUOut <= {A[0], A[31:1]}; // Rotate right ERROR
        4'b1000: ALUOut <= A & B; // Logical AND
        4'b1001: ALUOut <= A | B; // Logical OR
        4'b1010: ALUOut <= A ^ B; // Logical XOR
        4'b1011: ALUOut <= ~(A | B); // Logical NOR
   //   4'b1100: ALUOut <= ~(A & B); // Logical NAND ERROR
   //   4'b1101: ALUOut <= ~(A ^ B); // Logical XNOR ERROR
        4'b1110: if(A<B) begin ALUOut <=32'b1 ; end else begin ALUOut <=32'b0; end //ALUOut <= (A > B) ? 32'b1 : 32'b0; => Greater comparison ERROR so convert to slt

   //   4'b1111: ALUOut <= (A == B) ? 32'b1 : 32'b0; // Equal comparison ERROR 


        default: ALUOut <= 32'b0; // Default operation
    endcase
end

always @(*) begin
    if (ALUControl == 4'b0000) begin // Addition (signed)
        Overflow <= (A[31] == B[31] && A[31] != ALUOut[31]);
        CarryOut <= (A[31] & B[31]) | (A[31] & ALUOut[31]) | (B[31] & ALUOut[31]);
    end else if (ALUControl == 4'b0001) begin // Subtraction (signed)
        Overflow <= (A[31] != B[31] && A[31] != ALUOut[31]);
        CarryOut <= (A[31] & B[31]) | (A[31] & ALUOut[31]) | (B[31] & ALUOut[31]);
    end else if (ALUControl == 4'b0010) begin // Multiplication (signed)
        Overflow <= (A[31] == B[31] && A[31] != ALUOut[31]);
        CarryOut <= 1'b0; // No carry-out for multiplication
    end else if (ALUControl == 4'b0011) begin // Division (signed/unsigned)
        Overflow <= (B == 32'b0); // Detect division by zero
        CarryOut <= 1'b0;
    end else begin
        Overflow <= 1'b0;
        CarryOut <= 1'b0;
    end
end


always @* begin
    if (Overflow) begin

        ALUOut = 32'bx; 
end
end


endmodule
