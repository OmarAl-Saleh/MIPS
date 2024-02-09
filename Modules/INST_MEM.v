module INST_MEM #(
  parameter size = 32,          
  parameter data_width = 32    
)(
 // input clk,
  input reset,                   
  input [31:0] address,
  output reg [31:0] inst_out

);
   reg [31:0] inst_mem [0:size - 1];

  
 
 integer i;

//  endmodule 

reg state = 1'b0;
  
  
//  
  always @(*) begin

    if (reset) begin
      for (i = 0; i < size; i = i + 1) begin
        inst_mem[i] <= 32'b0;
      end
		  
    end else begin
        case (state)
            1'b0: begin
                state <= 1'b1;
					 // Enter here the Instructions of the program 
	
    
	// THIS TEST FOR STACK TESTING USING JAL & JS INSTRUCTIONS (Nested Subroutine) 3 push 3 pull 
	// the goal is test the stack functionality 
	
	/*Address 0 */inst_mem[0] = 32'b00001100000000000000000000000100;//JAL Jump to address 16 and save R31 = 4
	/*Address 4 */inst_mem[1] = 32'b10001100000000010000000000000100;//lw reg1=3 (the jump will skip it and return later) 
	/*Address 8 */inst_mem[2] = 32'b00000000000000001110000000000000; //ADD R28,R0,R0 (R28=0)  
	
   /* Address 12 */ inst_mem[3] = 32'b10110100001000100001100000100000; //Halt (stop PC & End the Program)
	
	// the PC final value will be 16
	
	/*Address 16 */inst_mem[4] = 32'b00001100000000000000000000000111;//JAL Jump to address 28 and save R31 = 20

	   
   /*Address 20 */inst_mem[5] = 32'b00000011111001010010000000001000;// JS jump to address store in REG 31 so jump to address 4 
	
	
	/*Address 28 */inst_mem[7] = 32'b00001100000000000000000000001111;//JAL Jump to address 60 and save R31 = 32
		
	/*Address 32 */inst_mem[8] = 32'b00000011111001010010000000001000;// JS jump to address store in REG 31 so jump to address 20 
		
		
    /*Address 60 */inst_mem[15] = 32'b00000011111001010010000000001000;// JS jump to address store in REG 31 so jump to address 32 
	 
	  // In this instruction we need JUMP Forwarding Unit between JAL MEM Stage instruction and JS ID Stage Instruction
	
//-------------------------------------------------------------

//

///* LAST ADDRESS */ inst_mem[3] = 32'b10110100001000100001100000100000; //Halt 
// every program should end with halt signal 

	

	 
                
            end
            1'b1: begin

          inst_out <= inst_mem[address >> 2];
             
            end
            
        endcase
    end
end

endmodule
