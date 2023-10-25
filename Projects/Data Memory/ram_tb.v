module ram_tb;

  // Parameters
  parameter DATA_WIDTH = 32;
  parameter SIZE = 32;

  // Signals
  reg clk;
  reg reset;                  
  reg [31:0] address;
  reg [DATA_WIDTH-1:0] data_write;
  reg write_en;
  reg read_en;
  wire [DATA_WIDTH-1:0] data_out;
  wire error;

  // Instantiate the RAM module
  RAM #(
    .size(SIZE),
    .data_width(DATA_WIDTH)
  ) ram (
    .clk(clk),
    .reset(reset),           
    .address(address),
    .data_write(data_write),
    .write_en(write_en),
    .read_en(read_en),
    .data_out(data_out)

  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    clk = 0;
    reset = 0;             
    address =    32'b00000000000000000000000000010100;
    data_write = 32'b00000000000000000000000000001011;
    write_en = 1;
    read_en = 0;

	 // Perform a read operation
    #5 address = 32'b00000000000000000000000000010100;
    write_en = 0;
    read_en = 1;
	 
	 // Perform a read operation
    #10 address = 32'b00000000000000000000000000001000; // Read from address 8
    write_en = 0;
    read_en = 1;
	 /*
	 
    // Assert and deassert the reset signal
    #10 reset = 1;         // Assert reset
    #10 reset = 0;         // Deassert reset

    // Perform a write operation
    #10 address = 8; // Write to address 8
    write_en = 1;
    read_en = 0;
    data_write = 32'b11001100110011001100110011001100;
	 

    // Perform a read operation
    #10 address = 8; // Read from address 8
    write_en = 0;
    read_en = 1;

    // Wait for a few clock cycles

    // Perform an out-of-bounds read operation
    #10 address = 1025; // Out-of-bounds address
    write_en = 0;
    read_en = 1;
    */
    // Finish the simulation
    #80 $stop;
  end

  // Display results
  initial begin
    $monitor("time=%0t: data_out=%h, error=%b", $time, data_out, error);
  end

endmodule

