module alu_control(
input clk,
input [5:0] FuncField,
input [3:0] ALUOp,
output reg [3:0] Operation,
output reg [2:0] branch_type
);

always @(*)
begin
    case (ALUOp)
	     4'b0000: Operation=4'b0000;
        4'b0010: begin // R-type instructions
            case (FuncField)
                6'b100000: Operation = 4'b0000;  // add
                6'b100010: Operation = 4'b0001;  // sub
                6'b011000: Operation = 4'b0010;  // mul
                6'b011010: Operation = 4'b0011;  // div
                6'b000000: Operation = 4'b0100;  // sll
                6'b000010: Operation = 4'b0101;  // srl
                6'b100100: Operation = 4'b1000;  // and
                6'b100101: Operation = 4'b1001;  // or
                6'b100110: Operation = 4'b1010;  // xor
                6'b100111: Operation = 4'b1011;  // nor
                6'b101010: Operation = 4'b1110;  // SLT
                6'b100001: Operation = 4'b0110;  // addu
                6'b100011: Operation = 4'b0111;  // subu
                default: Operation = 4'b0000;   // Default to add operation
            endcase
        end
        4'b0001: Operation = 4'b1000;  // andi
        4'b0011: Operation = 4'b1001;  // ori
        4'b0100: begin // beq
            Operation = 4'b0001;
            branch_type = 3'b001;
        end
        4'b0101: begin // bne
            Operation = 4'b0001;
            branch_type = 3'b010;
        end
        4'b0110: begin // bgt
            Operation = 4'b1110;
            branch_type = 3'b011;
        end
        4'b0111: begin // blt
            Operation = 4'b1101;
            branch_type = 3'b100;
        end
        4'b1000: begin // bge
            Operation = 4'b1100;
            branch_type = 3'b101;
        end
        4'b1001: begin // ble
            Operation = 4'b1100;
            branch_type = 3'b110;
        end
        default: Operation = 4'b1111;
    endcase
end

endmodule

//-----------------------------------Previous Version --------------------------------------------------------------------

//module alu_control(
//input clk,
//input [5:0] FuncField,
//input [3:0] ALUOp,
//output reg [3:0] Operation,
//output reg [2:0] branch_type
//);
//
//
//
//    always @(ALUOp , FuncField) begin
//	   if (ALUOp == 4'b0000) begin
//		Operation = 4'b0000;
//		end
//		else if(ALUOp == 4'b0010) begin
//        case (FuncField)
//            6'b100000: Operation = 4'b0000;  // add 
//            6'b100010: Operation = 4'b0001;  // sub
//				6'b011000: Operation = 4'b0010;  //mul
//				6'b011010: Operation = 4'b0011;  //div
//				6'b000000: Operation = 4'b0100;  //sll
//				6'b000010: Operation = 4'b0101;  //srl
//				6'b100100: Operation = 4'b1000;  // and
//            6'b100101: Operation = 4'b1001;  // or
//				6'b100110: Operation = 4'b1010;  //xor
//				6'b100111: Operation = 4'b1011;  //nor
//            6'b101010: Operation = 4'b1110;  // SLT
//				6'b100001: Operation = 4'b0110;	//addu
//				6'b100011: Operation = 4'b0111;  //subu
//				
//            default: Operation <= 4'b0000;   // Default add operation
//        endcase
//		  
//    end
//	 
//	 else if(ALUOp == 4'b0001)begin
//		Operation = 4'b1000;  // andi
//	 end
//
//	  else if(ALUOp == 4'b0011)begin
//		Operation = 4'b1001;  // ori
//	 end
//	 
//	 else if(ALUOp == 4'b0100)begin
//		Operation = 4'b0001;  // beq
//		branch_type = 3'b001;
//	 end
//	 
//	 else if(ALUOp == 4'b0101)begin
//		Operation = 4'b0001;  // bne
//		branch_type = 3'b010;
//	 end
//	 
//	 else if(ALUOp == 4'b0110)begin
//		Operation = 4'b1110;  // bgt
//		branch_type = 3'b011;
//	 end
//	 
//	 else if(ALUOp == 4'b0111)begin
//		Operation = 4'b1101;  // blt
//		branch_type = 3'b100;
//	 end
//	 
//	 else if(ALUOp == 4'b1000)begin
//		Operation = 4'b1100;  // bge
//		branch_type = 3'b101;
//	 end
//	 
//	 else if(ALUOp == 4'b1001)begin
//		Operation = 4'b1100;  // ble
//		branch_type = 3'b110;
//	 end
//	 
//	  
//	 
//	 
//	 
//	 else begin Operation = 4'b1111;
//	 end
//	 end
//endmodule 