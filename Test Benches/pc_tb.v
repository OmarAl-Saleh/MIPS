module pc_tb;

  reg clk;      // Clock signal
  reg reset;    // Reset signal
  wire [31:0] pc_out;  // Output from the PC module

  // Instantiate the PC module
  PC #(
    .first_address(16),  // Set first_address parameter to 16
    .pc_inc(4)          // Set pc_inc parameter to 4
  ) pc_inst (
    .clk(clk),
    .reset(reset),
    .pc(pc_out)
  );

  // Clock generation
  always begin
    #5 clk = ~clk; // Toggle the clock every 5 time units
  end

  initial begin
    // Initialize signals
    clk = 0;
    reset = 0;

    // Apply reset
    reset = 1;
    #10 reset = 0;  // De-assert reset after 10 time units

    // Wait for some time
    #50;

    // Apply reset again
    reset = 1;
    #10 reset = 0;  // De-assert reset after 10 time units

    // Wait for a few clock cycles
    #50;

    // Stop simulation
    #100 $stop;
  end

  // Display the PC value
  initial begin
    $display("PC = %h", pc_out);
  end

endmodule