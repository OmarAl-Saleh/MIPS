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
//  
//  always @(*) begin
//    if (reset) begin
//     
//      for (i = 0; i < size; i = i + 1) begin
//        inst_mem[i] <= 32'b0;
//      end
//    end 
//	 else begin
//    inst_out <= inst_mem[address >> 2];
//  end
//  end
//  
//  
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
	/*Address 0 */  inst_mem[0] = 32'b00000000000000000100000000100000; //ADD R8, R0, R0
	/*Address 4 */  inst_mem[1] = 32'b00100000000010010000000000001010; //ADDI R9, R9, 10
	/*Address 8 */  inst_mem[2] = 32'b00000001000010010101000000100010; //SUB R10, R8, R9 //Loop Forwarding 
	/*Address 12 */ inst_mem[3] = 32'b00100000000011000000000000000001; //ADDI R12, R0, 1
	/*Address 16 */ inst_mem[4] = 32'b00011001000010010000000000000010; //BGT R8, R9, DONE
	/*Address 20 */ inst_mem[5] = 32'b00100001000010000000000000000001; //ADDI R8, R8, 1
	/*Address 24 */ inst_mem[6] = 32'b00001000000000000000000000000010; //JUMP LOOP
	/*Address 28 */ inst_mem[7] = 32'b00000001001000000110100000100000; //ADD R13, R9, R0 //DONE
	/*Address 32 */ inst_mem[8] = 32'b00100000000011100000000000011011; //ADDI R14, R0, 1B(27)
	/*Address 36 */ inst_mem[9] = 32'b00110001110011100000000000010111; //ANDI R14, R14, 17(23) Forwarding
	
	
	/* LAST ADDRESS */ inst_mem[10] = 32'b10110100001000100001100000100000; //Halt 
	// every program should end with halt signal 

	

	 
                
            end
            1'b1: begin

          inst_out <= inst_mem[address >> 2];
             
            end
            
        endcase
    end
end

endmodule
