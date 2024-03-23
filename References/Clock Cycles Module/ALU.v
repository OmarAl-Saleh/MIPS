module ALU(
	 input	clk,
    input [31:0] A, // 32-bit input A
    input [31:0] B, // 32-bit input B
    input [3:0] ALUControl, // 4-bit ALU control
    input [4:0] ShiftAmount, // 5-bit input for shift amount
    input [2:0] branch_type,
	 output reg [31:0] ALUOut, // 32-bit output
    output reg Zero // Zero flag
   
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
        4'b0110: ALUOut <= A + B; // addu
		  4'b0111: ALUOut <= A - B; // subu
        4'b1000: ALUOut <= A & B; // Logical AND
        4'b1001: ALUOut <= A | B; // Logical OR
        4'b1010: ALUOut <= A ^ B; // Logical XOR
        4'b1011: ALUOut <= ~(A | B); // Logical NOR
        4'b1100: ALUOut <= (branch_type == 3'b101) ? (A >= B) ? 32'b1 : 32'b0 :
                (branch_type == 3'b110) ? (A <= B) ? 32'b1 : 32'b0 : 32'b0;
        4'b1101: ALUOut <= (A < B) ? 32'b1 : 32'b0; // less than
		  4'b1110: ALUOut <= (A > B) ? 32'b1 : 32'b0; // greater than
		  
	/*	  4'b1101: begin
    if (A[31] != B[31]) // Signs are different
        ALUOut <= (A[31] > B[31]) ? 32'b1 : 32'b0; // Compare signs
    else // Signs are the same
        ALUOut <= (A < B) ? 32'b1 : 32'b0; // Compare magnitudes
end
		  
		  4'b1110: begin
    if (A[31] != B[31]) // Signs are different
        ALUOut <= (A[31] < B[31]) ? 32'b1 : 32'b0; // Compare signs
    else // Signs are the same
        ALUOut <= (A > B) ? 32'b1 : 32'b0; // Compare magnitudes
end
		*/  




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
	 end else if ((ALUOut < A) && (ALUOut < B) && (ALUControl == 4'b0110)) begin
	 Overflow <= 1'b0;
	 CarryOut <= 1'b1;
    end else begin
        Overflow <= 1'b0;
        CarryOut <= 1'b0;
    end
end




always @(*) begin
case(branch_type)
				3'b001: Zero <= (ALUOut == 32'b0) ? 1'b1 : 1'b0; // beq
            3'b010: Zero <= (ALUOut != 32'b0) ? 1'b1 : 1'b0; // bne
            3'b011: Zero <= (ALUOut == 32'b1) ? 1'b1 : 1'b0; // bgt
            3'b100: Zero <= (ALUOut == 32'b1) ? 1'b1 : 1'b0; // blt
            3'b101: Zero <= (ALUOut == 32'b1) ? 1'b1 : 1'b0; // bge
            3'b110: Zero <= (ALUOut == 32'b1) ? 1'b1 : 1'b0; // ble

default: Zero <= 1'b0;
endcase
end


endmodule
