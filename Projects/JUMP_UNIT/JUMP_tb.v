module JUMP_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in simulation time units

  // Signals
  reg JUMP_FLAG;
  reg [25:0] jump_offset;
  reg [31:0] next_pc;

  wire [31:0] JUMP_address;

  // Instantiate the module under test
  JUMP uut (
    .JUMP_FLAG(JUMP_FLAG),
    .jump_offset(jump_offset),
    .next_pc(next_pc),
    .JUMP_address(JUMP_address)
  );

  // Clock generation
  reg clk = 0;
  always #((CLK_PERIOD / 2)) clk =~ clk;

  // Initial block for testbench
  initial begin
    // Initialize inputs
    JUMP_FLAG = 0;
    jump_offset = 26'b00000000000000000000000011;
    next_pc = 32'h00000004;

    // Apply inputs and observe outputs for a few clock cycles
    #10 JUMP_FLAG = 1;
    #10;JUMP_FLAG = 0;

    // You can add more test cases here

    // End simulation after some time
    #100 $finish;
  end

endmodule
