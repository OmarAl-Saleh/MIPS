module IF_ID_Register (clk,reset,enable,Instruction_in,PC_in,Branch_Control,Instruction_out,PC_out,halt);

input clk ;
input reset; // 0-->1 to delete the previous instruction and store a nop instruction (flush) with opcode 111000 according to our control unit default value
//we use it in branch miss prediction this signal come from zero in branch alu

input enable; // 0-->1 to enable the register to received new instruction we use 
//it in hazard detection to make flush and the output opcode is 111000 it comes only from  the hazard detection unit

input halt ; // 0 ---> stop pc and regenerate halt instruction to control unit

input [31:0] Instruction_in; // the instruction come from fetch stage

input [31:0] PC_in; // the value of pc+4 come from fetch stage

input Branch_Control; // to know if the function cause reset (zero signal) is from branch instruction in ID stage

output reg [31:0] Instruction_out; // the instruction output to decode stage


  
  
  
  
  

output reg [31:0] PC_out ; // the pc output to decode stage



always@(posedge clk)
	begin
		
		if((enable == 1'b0) )
			begin
	
				if((Branch_Control == 1'b1)  )
				// case 3 : when to flush the register in reset status or when we catch a branch miss predict
					begin
			
						Instruction_out <=32'b11100000000000000000000000000000; // nop

						PC_out <= PC_in;


		
					end
					
				else
					begin
//					// case 2 : when we do not have any problem
						Instruction_out <=Instruction_in;

						PC_out <= PC_in;
		
					end
					
					
				
				 if((reset == 1'b1) ||(halt == 1'b1))
						begin
				  // to stop the pc 
						Instruction_out <=32'b10110100000000000000000000000000; // nop
				
						PC_out <= PC_in;
				  
						end
				
			end
			
			
			
			
	
	end
	
endmodule


