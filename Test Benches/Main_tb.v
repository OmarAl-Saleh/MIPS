`timescale 1ns/1ns
module Main_tb;

  reg clk;      // Clock signal
  reg reset;    // Reset signal

  // Instantiate the Main module
  Main main_inst (
    .clk(clk),
    .reset(reset)
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
    //#55000; for test case 4 & 6
	// #55000
	 #550

    // Stop simulation
    $stop;
  end

endmodule
