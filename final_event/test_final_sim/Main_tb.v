`timescale 1ns/1ns
module Main_tb;

  reg clk;      // Clock signal
  reg reset;    // Reset signal
 // reg halt;
  integer clk_count = 0; // Clock counter

  // Instantiate the Main module
  Main main_inst (
    .clk(clk),
    .reset(reset)
  );
  

  // Clock generation
  always begin
    #1 clk = ~clk; // Toggle the clock every 5 time units
		
	 clk_count = clk_count + 1; // Increment clock counter
	  

  end

  initial begin
    // Initialize signals
	clk = 0;
    reset = 0;

    // Apply reset
   // reset = 1;
   // #20 reset = 0;  // De-assert reset after 20 time units

    // Wait for a few clock cycles
    #55000; //for test case 4 & 6
    //#550
     //#100
	 //#1500
   

    // Stop simulation
    $stop;
  end

endmodule
