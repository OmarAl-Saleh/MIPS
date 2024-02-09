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
  reg [31:0] mem [0:31];
  reg error;
 
  
  // Declare a memory array with parameterized size and data width.
 // reg [data_width-1:0] mem [0:size - 1];
  

 assign data_out=(read_en)? ((reset)?8'h00000000:mem[address >> 2]):32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

reg state = 1'b0;
integer i;
  
//  
  always @(*) begin

    if (reset) begin
      for (i = 0; i < size; i = i + 1) begin
         mem[i] <= 32'b0;
      end
		  
    end
	 else if (write_en || state==1'b0) begin
        case (state)
            1'b0: begin
                state <= 1'b1;
				// Enter RAM Data here 	 
					 
					 //testcaase 2
  mem[0] = 32'b00000000000000000000000000000011; // 3
  mem[1] = 32'b00000000000000000000000000000011; // 3
  mem[2] = 32'b00000000000000000000000000000011; // 3
  mem[3] = 32'b00000000000000000000000000000011; // 3
  mem[4] = 32'b00000000000000000000000000000011; // 3
	       
                
            end
            1'b1: begin

             mem[address >> 2] <= data_write;
             
            end
            
        endcase
    end
end

endmodule


