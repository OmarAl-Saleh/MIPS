module RAM #(
  parameter size = 64,
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
  reg [31:0] mem [0:31];
  reg error;
 
  
  // Declare a memory array with parameterized size and data width.
 // reg [data_width-1:0] mem [0:size - 1];
  

 assign data_out=(read_en)? ((reset)?8'h00000000:mem[address >> 2]):32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

reg state = 1'b0;
integer i;
  
//  
  always @(*) begin

 if (write_en || state==1'b0) begin
        case (state)
            1'b0: begin
                state <= 1'b1;
				// Enter RAM Data here 	
				
				mem[0]=32'b00000000000000001111000111100000;
	         mem[1]=32'b00000000000000000000000000011110;
			
                
            end
            1'b1: begin

             mem[address >> 2] <= data_write;
             
            end
            
        endcase
    end
end

endmodule


