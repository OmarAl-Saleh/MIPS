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
	
		//testcase 3
	
	inst_mem[0] = 32'b00000000000000001110000000000000; //ADD R28,R0,R0 (R28=0)
	inst_mem[1] = 32'b10001111100010000000000000000000; //LW R8, 0(R28)
	inst_mem[2] = 32'b10001111100010010000000000000100; //LW R9, 4(R28)
	inst_mem[3] = 32'b00000001000010010100000000100000; //ADD R8, R8, R9 Hazard & Forwarding
	inst_mem[4] = 32'b10001111100010100000000000001000; //LW R10, 8(R28)
	inst_mem[5] = 32'b00000001010010100101000000100000; //ADD R10, R10, R10 Hazard & Forwarding
	inst_mem[6] = 32'b00000001000010100100000000100010; //SUB R8, R8, R10
	inst_mem[7] = 32'b00100001000010000000000000000001; //ADDI R8, R8, 1 Forwarding
	inst_mem[8] = 32'b00000000000010000100000000100010; //SUB R8, R0, R8 Forwarding
	
	
	
	//-------------------------------------------------------------

/* LAST ADDRESS */ inst_mem[9] = 32'b10110100001000100001100000100000; //Halt 
// every program should end with halt signal 

	

	 
                
            end
            1'b1: begin

          inst_out <= inst_mem[address >> 2];
             
            end
            
        endcase
    end
end

endmodule