module ControlUnit(Clock,Reset,opcode,RegDst,ALUSrc,MemtoReg,MemWrite,MemRead,ALUOp,RegWrite);
input wire [5:0] opcode; 
input Clock , Reset ;  // Reset : 1 --> on | 0--> off
// wires
output wire RegDst,ALUSrc,MemtoReg,MemWrite,MemRead,RegWrite;
output wire [1:0] ALUOp;
// reg type
 reg reg_RegDst,reg_ALUSrc,reg_MemtoReg,reg_MemWrite,reg_MemRead,reg_RegWrite;
 reg [1:0] reg_ALUOp;
	reg [5:0] reset_opcode ;
//	    opcode,  // 6-bit opcode from the instruction
//     RegDst,      // Control signal for selecting the destination register
//     ALUSrc,      // Control signal for ALU source selection (0 for register, 1 for immediate)
//     MemtoReg,    // Control signal for selecting the source for register write data
//     MemWrite,    // Control signal for memory write
//     MemRead,     // Control signal for memory read
//     Branch,      // Control signal for branching
//     ALUOp,       // Control signal for ALU operation
//     RegWrite     // Control signal for register write
//     reset_reg    // will handle the default value if the reset is on 


always @(*)
begin
	if(Reset==1'b1)
	reset_opcode <=6'b111000; // this bits will call the default value and make the control unit reset
	else
	reset_opcode <=opcode;
	
end 




always @(*) 

	if(Reset==1'b1)begin 
	 // defualt value we can use it if we will implement reset or unsupported instructions
		 reg_ALUSrc = 1'b0;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 1'b0;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;
end
	
	
	else begin
	case(opcode)
	
	6'b000000:begin 
		// R-type instruction 
       reg_ALUSrc = 1'b0;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 1'b0;
      reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b10;
       reg_RegDst = 1'b1;
	
	end
	
		6'b100011:begin 
		// load instruction 
       reg_ALUSrc = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 1'b1;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b1;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;
	
	end
	
	   6'b101011:begin
		// store instruction 
       reg_ALUSrc = 1'b1;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 1'b0; //error (should be 0 ) i am an idiot ...*****
       reg_MemWrite = 1'b1;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;  //don't care
	
	end
	
		6'b001000:begin
		//Addi instruction
		 reg_ALUSrc = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 1'b0;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;
	end
	
	// we can here add two cases for branch and jump control signals 
	
	default : begin 
	 // defualt value we can use it if we will implement reset or unsupported instructions
		 reg_ALUSrc = 1'b0;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 1'b0;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;
	
	

end

endcase
end

// assign the output wires 
assign RegDst = reg_RegDst;
assign ALUSrc = reg_ALUSrc;
assign MemtoReg = reg_MemtoReg;
assign MemWrite = reg_MemWrite;
assign MemRead = reg_MemRead;
assign RegWrite = reg_RegWrite;
assign ALUOp = reg_ALUOp;

endmodule 