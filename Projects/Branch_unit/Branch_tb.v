module Branch_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in simulation time units

  // Signals
  reg Branch_Flag;
  reg [3:0] ALUOp;
  reg [31:0] Data1;
  reg [31:0] Data2;
  reg [15:0] Target;
  reg [31:0] next_pc;

  wire [31:0] Branch_address;
  wire zero;

  // Instantiate the module under test
  Branch uut (
    .Branch_Flag(Branch_Flag),
    .ALUOp(ALUOp),
    .Data1(Data1),
    .Data2(Data2),
    .Target(Target),
    .next_pc(next_pc),
    .Branch_address(Branch_address),
    .zero(zero)
  );

  // Clock generation
  reg clk = 0;
  always #((CLK_PERIOD / 2)) clk =~ clk;

  // Initial block for testbench
  initial begin
    // Initialize inputs
    Branch_Flag = 0;
    ALUOp = 4'b0100; // You can change this to test different ALUOp values
    Data1 = 32'h00000001;
    Data2 = 32'h00000001;
    Target = 16'h0001;
    next_pc = 32'h00000004;

	 
    // Apply inputs and observe outputs for a few clock cycles
    #10 Branch_Flag = 1;
  
	#10 Data1 = 32'h00000001;
       Data2 = 32'h00000010;
	
	#10 ALUOp = 4'b0101;
    

    // End simulation after some time
    #100 $stop;
  end




endmodule 