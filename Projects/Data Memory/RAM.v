module RAM #(
  parameter size = 32,
  parameter data_width = 32,
  parameter once=1
)(
  input clk,
  input reset,                   // Reset signal
  input [31:0] address,
  input [data_width-1:0] data_write,
  input write_en,
  input read_en,
  output reg [data_width-1:0] data_out

 // output reg error
);
  reg [31:0] mem [0:31];
  reg error;
  reg first=once;
  
  
  // Declare a memory array with parameterized size and data width.
 // reg [data_width-1:0] mem [0:size - 1];
  
 always @(first)begin
  mem[0] = 32'b00000000000000000000000000000010; // 2
  mem[1] = 32'b00000000000000000000000000000011; // 3
  mem[2] = 32'b00000000000000000000000000001000; // 8
  mem[3] = 32'b00000000000000000000000000001100; // 12
  mem[4] = 32'b00000000000000000000000000000110; // 6
  mem[5] = 32'b00000000000000000000000000010100; // 20
  mem[6] = 32'b00000000000000000000000000011000; // 24
  mem[7] = 32'b00000000000000000000000000011100; // 28
  mem[8] = 32'b00000000000000000000000000100000; // 32
  mem[9] = 32'b00000000000000000000000000100100; // 36
first=0;
end
  
 
  
	integer i;
	
  always @(*) begin
    if (reset) begin

      for (i = 0; i < size; i = i + 1) begin
        mem[i] <= 32'b0;
      end
      error <= 0;
      data_out <= 32'b0;
			
		end 
	 
	 else if (write_en) begin
          // Write data 
          mem[address >> 2] <= data_write;
			 data_out <= data_write;
        end

     else if (read_en) begin
          // Read data 
          data_out <= mem[address >> 2];
        end

  end

  

  
endmodule


/* if (address >= 1024) begin
          // Error: Address out of bounds.
          data_out <= 32'hFFFFFFFF;
          error <= 1;
        end 
        else begin*/
		  
		  /* if (address >= 1024) begin
          // Error: Address out of bounds.
          data_out <= 32'hEEEEEEEE; 
          error <= 1;
        end else begin*/