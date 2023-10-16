
`timescale 1ns / 1ns
module ControlUnit_tb();

  // Input signals
  reg Clock = 0;
  reg Reset = 0;
  reg [5:0] opcode = 6'b000000; // Example: R-type instruction

  // Output signals
  wire RegDst, ALUSrc, MemtoReg, MemWrite, MemRead, RegWrite; 
  wire [1:0] ALUOp;

  // Instantiate the ControlUnit module
  ControlUnit UUT (
    .Clock(Clock),
    .Reset(Reset),
    .opcode(opcode),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
  );

  // Clock generation
  always begin
    #10 Clock = ~Clock; // Toggle the clock every 5 time units
  end

  initial begin
    // Reset the control unit
    Reset = 1'b0;
    #20 Reset = 1'b1;

    // Test case 1: R-type instruction
    opcode = 6'b000000;
    #20;
    
    // Test case 2: Load instruction
    opcode = 6'b100011;
    #20;
    

    // Test case 3: Store instruction
    opcode = 6'b101011;
    #20;
   
  end
  
  initial #100 $stop;

endmodule

