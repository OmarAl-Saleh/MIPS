module RAM (
  input clk,
  input [31:0] address,
  input [31:0] data_write,
  input write_en,
  input read_en,
  output reg [31:0] data_out
);

  // Declare a 32-bit wide memory array with 32 entries (each entry is 32 bits wide).
  reg [31:0] mem [0:31]; 

  initial begin
  mem[0] = 32'b00000000000000000000000000000010; //2
  mem[1] = 32'b00000000000000000000000000000011; //3
  mem[2] = 32'b00000000000000000000000000001000; //8
  mem[3] = 32'b00000000000000000000000000001100; //12
  mem[4] = 32'b00000000000000000000000000000110; //6
  mem[5] = 32'b00000000000000000000000000010100; //20
  mem[6] = 32'b00000000000000000000000000011000; //24
  mem[7] = 32'b00000000000000000000000000011100; //28
  mem[8] = 32'b00000000000000000000000000100000; //32
  mem[9] = 32'b00000000000000000000000000100100; //36
  
  end
  
  always @(posedge clk) begin
		if (write_en) begin
      if (address >= 1024) begin
        // Error: Address out of bounds.
        data_out <= 32'hFFFFFFFF;
      end 
		else begin
        // Write data 
        mem[address >> 2] <= data_write;
		 
      end
    end 
	 
	 
		if(read_en)begin
      if (address >= 1024) begin
        // Error: Address out of bounds.
        data_out <= 32'hEEEEEEEE; 
      end else begin
        // Read data 
        data_out <= mem[address >> 2];
      end
    end
  end

endmodule
