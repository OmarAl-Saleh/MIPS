`timescale 1ns/1ns

module Main_tb;

  reg clk;      // Clock signal
  reg reset;    // Reset signal
  wire [31:0] ReadData1;
  wire [31:0] ReadData2;
  wire [31:0] Writedata;

  // Instantiate the Main module
  Main main_inst (
    .clk(clk),
    .reset(reset),
	 .ReadData1(ReadData1),
	 .ReadData2(ReadData2),
	 .Writedata(Writedata)
  );

  // Clock generation
  always begin
    #10 clk = ~clk; // Toggle the clock every 5 time units
  end

  initial begin
    // Initialize signals
	clk = 0;
    reset = 0;

    // Apply reset
   // reset = 1;
   // #20 reset = 0;  // De-assert reset after 20 time units

    // Wait for a few clock cycles
		#350;
	// #6500; for test case 5 & 6 

    // Stop simulation
    $stop;
  end

endmodule
