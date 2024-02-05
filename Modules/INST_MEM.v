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
					 
					 //testcase 1
	
					inst_mem[0] = 32'b10001100000010000000000000000000; //LW R8, 0(R0)
					inst_mem[1] = 32'b10001100000010010000000000100000; //LW R9, 0x20(R0)
					inst_mem[2] = 32'b10001100000010100000000001010000; //LW R10, 0x50(R0)
					inst_mem[3] = 32'b10001100000010110000000000001000; //LW R11, 0x8(R0)

	 
                
            end
            1'b1: begin

          inst_out <= inst_mem[address >> 2];
             
            end
            
        endcase
    end
end

endmodule
