module ControlUnit(Clock,Reset,opcode,RegDst,ALUSrc,MemtoReg,MemWrite,MemRead,ALUOp,RegWrite,Branch,Jump,funct,halt);
input wire [5:0] opcode; 
input Clock , Reset ;  // Reset : 1 --> on | 0--> off
input wire [5:0] funct;
// wires
output wire ALUSrc,MemWrite,MemRead,RegWrite,Branch;
output wire [3:0] ALUOp;
output wire [1:0] Jump;
output wire [1:0] MemtoReg;
output wire [1:0] RegDst;
output wire halt;
// reg type
 reg reg_ALUSrc,reg_MemWrite,reg_MemRead,reg_RegWrite,reg_Branch;
 reg [3:0] reg_ALUOp;
 reg [1:0] reg_Jump;
 reg [1:0] reg_MemtoReg;
 reg [1:0] reg_RegDst; 
 reg [5:0] reset_opcode ;
 reg reg_halt;
	
	
//************************** Singnal classification ********************************
	
//	    opcode,  // 6-bit opcode from the instruction
//     RegDst,      // Control signal for selecting the destination register
//     ALUSrc,      // Control signal for ALU source selection (0 for register, 1 for immediate)
//     MemWrite,    // Control signal for memory write
//     MemRead,     // Control signal for memory read
//     Branch,      // Control signal for branching
//     ALUOp,       // Control signal for ALU operation
//     RegWrite     // Control signal for register write
//     reset_reg    // will handle the default value if the reset is on 
//		 pc_load (    0->stall),(1->load)
//     pc_Store     // to enable REG 31 to store the return address when using JAL Instruction 
//     JUMP[1:0]    // (MSB) --> is to indicate JS Instruction with Pull the stack (LSB) --> indicate jump instruction
//     MemToReg[1:0] // MSB) --> is to indicate JAL Instruction with Push the stack 
//                      (LSB) --> Control signal for selecting the source for register write data

//*********************************************************************************************************************

always @(*)
begin
	if(Reset==1'b1)
	reset_opcode <=6'b111000; // this bits will call the default value and make the control unit reset
	else
	reset_opcode <=opcode;
	
end 


//101101 halt opcode 

always @(*) 

	if(Reset==1'b1)begin 
	 // defualt value we can use it if we will implement reset or unsupported instructions
		 reg_ALUSrc   = 1'b0;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 2'b00;
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b0;
       reg_ALUOp    = 4'b0000;
       reg_RegDst   = 2'b00;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b00;
		 reg_halt     = 1'b0;
		 
end
	
	
	else begin
	case(opcode)
	
	6'b000000:begin 
		if(funct == 6'b001000)begin 
		//Jump Register (JS) instruction
		 reg_ALUSrc   = 1'b0;
		 reg_RegWrite = 1'b1;// for Stack Implementation
       reg_MemtoReg = 2'b11; // for Stack implementation (customize only for JS function to be MemToReg[1]=1 same as JAL Instruction)
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b1;// for Stack Implementation
       reg_ALUOp    = 4'b0000;
       reg_RegDst   = 2'b00;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b10;
		 reg_halt     = 1'b0;

		 
		end
		else begin
		// R-type instruction 
       reg_ALUSrc   = 1'b0;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 2'b00;
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b0;
       reg_ALUOp    = 4'b0010;
       reg_RegDst   = 2'b01;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b00;
		 reg_halt     = 1'b0;
		 
	end
	end
	
		6'b100011:begin 
		// load instruction 
       reg_ALUSrc   = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 2'b01;
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b1;
       reg_ALUOp    = 4'b0000;
       reg_RegDst   = 2'b00;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b00;
		 reg_halt     = 1'b0;
		 
	
	end
	
	   6'b101011:begin
		// store instruction 
       reg_ALUSrc   = 1'b1;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 2'b00; 
       reg_MemWrite = 1'b1;
       reg_MemRead  = 1'b0;
       reg_ALUOp    = 4'b0000;
       reg_RegDst   = 2'b00;  
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b00;
		 reg_halt     = 1'b0;
		 
		 
	end
	
		6'b001000:begin
		//immediate instruction (addi)
		 reg_ALUSrc   = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 2'b00;
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b0;
       reg_ALUOp    = 4'b0000;
       reg_RegDst   = 2'b00;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b00;
		 reg_halt     = 1'b0;
		 
		 
	end
	
		6'b001100:begin
		//immediate instruction (andi)
		 reg_ALUSrc   = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 2'b00;
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b0;
       reg_ALUOp    = 4'b0001;
       reg_RegDst   = 2'b00;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b00;
		 reg_halt     = 1'b0;
		 
		 
	end
			6'b001101:begin
		//immediate instruction (ori)
		 reg_ALUSrc   = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 2'b00;
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b0;
       reg_ALUOp    = 4'b0011;
       reg_RegDst   = 2'b00;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b00;
		 reg_halt     = 1'b0;
		 
		 
	end
	
			6'b000010:begin
		//Jump instruction (j)
		 reg_ALUSrc   = 1'b0;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 2'b00;
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b0;
       reg_ALUOp    = 4'b0000;
       reg_RegDst   = 2'b00;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b01;
		 reg_halt     = 1'b0;
		 
		 
	end
	
		6'b000011:begin
		//Jump and link instruction (jal)
		 reg_ALUSrc 	= 1'b0;
		 reg_RegWrite 	= 1'b1;
       reg_MemtoReg 	= 2'b10;// for JAL instruction
       reg_MemWrite 	= 1'b1; // for Stack implemntation
       reg_MemRead 	= 1'b0;
       reg_ALUOp		= 4'b0000;
       reg_RegDst		= 2'b10;
		 reg_Branch		= 1'b0;
		 reg_Jump 		= 2'b01;// for JS Instruction
		 reg_halt     = 1'b0;
		
	end
	
		6'b000100:begin
		//branch equal
		 reg_ALUSrc		= 1'b0;
		 reg_RegWrite	= 1'b0;
       reg_MemtoReg	= 2'b00;
       reg_MemWrite	= 1'b0;
       reg_MemRead	= 1'b0;
       reg_ALUOp		= 4'b0100;
       reg_RegDst		= 2'b00;
		 reg_Branch		= 1'b1;
		 reg_Jump		= 2'b00;
		 reg_halt     = 1'b0;
		 
		 
	end
	
	
		6'b000101:begin
		//branch not equal
		 reg_ALUSrc		= 1'b0;
		 reg_RegWrite	= 1'b0;
       reg_MemtoReg	= 2'b00;
       reg_MemWrite	= 1'b0;
       reg_MemRead	= 1'b0;
       reg_ALUOp		= 4'b0101;
       reg_RegDst		= 2'b00;
		 reg_Branch		= 1'b1;
		 reg_Jump		= 2'b00;
		 reg_halt     = 1'b0;
		 
		 
	end
	
		6'b000110:begin
		//branch greater than
		 reg_ALUSrc		= 1'b0;
		 reg_RegWrite	= 1'b0;
       reg_MemtoReg	= 2'b00;
       reg_MemWrite	= 1'b0;
       reg_MemRead	= 1'b0;
       reg_ALUOp		= 4'b0110;
       reg_RegDst		= 2'b00;
		 reg_Branch		= 1'b1;
		 reg_Jump		= 2'b00;
		 reg_halt     = 1'b0;
		 
		 
	end
	
		6'b000111:begin
		//branch less than
	 	 reg_ALUSrc		= 1'b0;
		 reg_RegWrite	= 1'b0;
       reg_MemtoReg	= 2'b00;
       reg_MemWrite	= 1'b0;
       reg_MemRead	= 1'b0;
       reg_ALUOp		= 4'b0111;
       reg_RegDst		= 2'b00;
		 reg_Branch		= 1'b1;
		 reg_Jump		= 2'b00;
		 reg_halt     = 1'b0;
		 
		 
	end
	
		6'b001001:begin
		//branch greater or equal
		 reg_ALUSrc		= 1'b0;
		 reg_RegWrite	= 1'b0;
       reg_MemtoReg	= 2'b00;
       reg_MemWrite	= 1'b0;
       reg_MemRead	= 1'b0;
       reg_ALUOp		= 4'b1000;
       reg_RegDst		= 2'b00;
		 reg_Branch		= 1'b1;
		 reg_Jump		= 2'b00;
		 reg_halt     = 1'b0;
		
		 
	end
	
		6'b001010:begin
		//branch less or equal
		 reg_ALUSrc		= 1'b0;
		 reg_RegWrite	= 1'b0;
       reg_MemtoReg	= 2'b00;
       reg_MemWrite	= 1'b0;
       reg_MemRead	= 1'b0;
       reg_ALUOp		= 4'b1001;
       reg_RegDst		= 2'b00;
		 reg_Branch		= 1'b1;
		 reg_Jump		= 2'b00;
		 reg_halt     = 1'b0;
		 
	end
	
	// halt instruction 
	
	6'b101101:begin
		//branch less or equal
		 reg_ALUSrc		= 1'b0;
		 reg_RegWrite	= 1'b0;
       reg_MemtoReg	= 2'b00;
       reg_MemWrite	= 1'b0;
       reg_MemRead	= 1'b0;
       reg_ALUOp		= 4'b0000;
       reg_RegDst		= 2'b00;
		 reg_Branch		= 1'b0;
		 reg_Jump		= 2'b00;
		 reg_halt     = 1'b1;
		 
	end
	
//	6'b111000:begin
//		//branch less or equal
//		 reg_ALUSrc		= 1'b0;
//		 reg_RegWrite	= 1'b0;
//       reg_MemtoReg	= 2'b00;
//       reg_MemWrite	= 1'b0;
//       reg_MemRead	= 1'b0;
//       reg_ALUOp		= 4'b0000;
//       reg_RegDst		= 2'b00;
//		 reg_Branch		= 1'b0;
//		 reg_Jump		= 2'b00;
//		 reg_halt     = 1'b1;
//		 
//	end
//	
	
	
	
	default : begin 
	 // defualt value we can use it if we will implement reset or unsupported instructions
		 reg_ALUSrc   = 1'b0;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 2'b00;
       reg_MemWrite = 1'b0;
       reg_MemRead  = 1'b0;
       reg_ALUOp    = 2'b00;
       reg_RegDst   = 2'b00;
		 reg_Branch   = 1'b0;
		 reg_Jump     = 2'b00;
		 reg_halt     = 1'b0;
		 
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
assign Branch= reg_Branch;
assign Jump = reg_Jump;
assign halt = reg_halt;


endmodule 