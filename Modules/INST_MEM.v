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
					 
	/*Address 0 */  inst_mem[0] = 32'b00000000000000000000100000100000; //ADD R1, R0, R0   
	/*Address 4 */  inst_mem[1] = 32'b00000000000000000001000000100000; //ADD R2, R0, R0
	/*Address 8 */  inst_mem[2] = 32'b00100000000010010000000001100100; //ADDI R9, R0, 100
	/*Address 12 */ inst_mem[3] = 32'b00010000001010010000000000000010; //BEQ R1, R9, EXIT //START
	/*Address 16 */ inst_mem[4] = 32'b00100000001000010000000000000001; //ADDI R1, R1, 1
	/*Address 20 */ inst_mem[5] = 32'b00001000000000000000000000000011; //JUMP START
	/*Address 24 */ inst_mem[6] = 32'b00000000001000100001100000100000; //ADD R3, R1, R2 //EXIT
	
	inst_mem[7] = 32'b11100000000001000000000000001100; //nop
	inst_mem[8] = 32'b11100000000001000000000000001100; //nop
	inst_mem[9] = 32'b11100000000001000000000000001100; //nop
	inst_mem[10] = 32'b11100000000001000000000000001100; //nop
	inst_mem[11] = 32'b11100000000001000000000000001100; //nop
	inst_mem[12] = 32'b11100000000001000000000000001100; //nop
	inst_mem[13] = 32'b11100000000001000000000000001100; //nop
	inst_mem[14] = 32'b11100000000001000000000000001100; //nop
	inst_mem[15] = 32'b11100000000001000000000000001100; //nop
	inst_mem[16] = 32'b11100000000001000000000000001100; //nop
	inst_mem[17] = 32'b11100000000001000000000000001100; //nop
	inst_mem[18] = 32'b11100000000001000000000000001100; //nop
	inst_mem[19] = 32'b11100000000001000000000000001100; //nop
   inst_mem[20] = 32'b11100000000001000000000000001100; //nop
   inst_mem[21] = 32'b11100000000001000000000000001100; //nop
   inst_mem[22] = 32'b11100000000001000000000000001100; //nop
	inst_mem[23] = 32'b11100000000001000000000000001100; //nop
	inst_mem[24] = 32'b11100000000001000000000000001100; //nop
	inst_mem[25] = 32'b11100000000001000000000000001100; //nop
	inst_mem[26] = 32'b11100000000001000000000000001100; //nop
	inst_mem[27] = 32'b11100000000001000000000000001100; //nop
	inst_mem[28] = 32'b11100000000001000000000000001100; //nop
	inst_mem[29] = 32'b11100000000001000000000000001100; //nop
	inst_mem[30] = 32'b11100000000001000000000000001100; //nop
	inst_mem[31] = 32'b11100000000001000000000000001100; //nop
	inst_mem[32] = 32'b11100000000001000000000000001100; //nop

	
	

	 
                
            end
            1'b1: begin

          inst_out <= inst_mem[address >> 2];
             
            end
            
        endcase
    end
end

endmodule
