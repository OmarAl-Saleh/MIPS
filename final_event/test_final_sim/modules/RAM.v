module RAM #(
  parameter size = 32,
  parameter data_width = 32
)(
  input clk,
  input reset,                   // Reset signal
  input [31:0] address,
  input [data_width-1:0] data_write,
  input write_en,
  input read_en,
  output wire [data_width-1:0] data_out

 // output reg error
);
  reg [31:0] mem [0:size - 1];
  reg error;

 
  // Declare a memory array with parameterized size and data width.
 // reg [data_width-1:0] mem [0:size - 1];
  

 assign data_out=(read_en)?(mem[address >> 2]):32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

reg state = 1'b0;

  
//  
  always @(posedge clk) begin

	 if (write_en || state==1'b0) begin
        case (state)
            1'b0: begin
                state <= 1'b1;
				// Enter RAM Data here 	
				
						//testcase 1
						
						

	//		 BM1
	mem[0]=32'b00000000000000001111000111100000;
	mem[1]=32'b00000000000000000000000000011110;					
					
			


			
			//BM2	
	/*		
   mem[0]=32'b00000000000000000111110100000000;
	mem[1]=32'b00000000000000000011101000000001;
	mem[2]=32'b00000000000000000001011010000011;
	mem[3]=32'b00000000000000000000111110010011;
	mem[4]=32'b00000000000000000000010000000000;
	mem[5]=32'b00000000000000000000001111010110;
	mem[6]=32'b00000000000000000000000110010001;
	mem[7]=32'b00000000000000000000000101110101;
	mem[8]=32'b00000000000000000000000010110111;
	mem[9]=32'b00000000000000000000000001011110;
	mem[10]=32'b00000000000000000000000001000100;
	mem[11]=32'b00000000000000000000000000011001;
	mem[12]=32'b00000000000000000000000000000110;
	mem[13]=32'b11111111111111111111111111111111;
	mem[14]=32'b11111111111111111111111111011001;
	mem[15]=32'b11111111111111111111111011100100;
	mem[16]=32'b11111111111111111111110110010100;
	mem[17]=32'b11111111111111111101110001110010;
	mem[18]=32'b11111111111111111011000001101001;
	mem[19]=32'b11111111111111111000011011101000;

	*/

	

//	
  
	       
                
            end
            1'b1: begin

             mem[address >> 2] <= data_write;
             
            end
            
        endcase
    end
end

endmodule


