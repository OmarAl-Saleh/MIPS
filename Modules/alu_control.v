module alu_control(
input clk,
input [5:0] FuncField,
input [1:0] ALUOp,
output reg [3:0] Operation);



    always @(ALUOp , FuncField) begin
	   if (ALUOp == 2'b00) begin
		Operation = 4'b0000;
		end
		else if(ALUOp == 2'b10) begin
        case (FuncField)
            6'b100000: Operation = 4'b0000;  // add 
            6'b100010: Operation = 4'b0001;  // sub
				6'b011000: Operation = 4'b0010;  //mul
				6'b011010: Operation = 4'b0011;  //div
				6'b000000: Operation = 4'b0100;  //sll
				6'b000010: Operation = 4'b0101;  //srl
				6'b100100: Operation = 4'b1000;  // and
            6'b100101: Operation = 4'b1001;  // or
				6'b100110: Operation = 4'b1010;  //xor
				6'b100111: Operation = 4'b1011;  //nor
            6'b101010: Operation = 4'b1110;  // SLT
				6'b100001: Operation = 4'b0110;	//addu
				6'b100011: Operation = 4'b0111;  //subu
				
            default: Operation <= 4'b0000;   // Default add operation
        endcase
		  
    end
	 
	 else if(ALUOp == 2'b01)begin
		Operation = 4'b1000;  // andi
	 end

	  else if(ALUOp == 2'b11)begin
		Operation = 4'b1001;  // ori
	 end

	 
	 else begin Operation = 4'b1111;
	 end
	 end
endmodule