`timescale 1ns/1ns

module IF_ID_Register_tb;

  // Inputs
  reg clk;
  reg reset;
  reg enable;
  reg [31:0] Instruction_in;
  reg [31:0] PC_in;
  reg Branch_Control;

  // Outputs
  wire [31:0] Instruction_out;
  wire [31:0] PC_out;

  // Instantiate the module
  IF_ID_Register uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .Instruction_in(Instruction_in),
    .PC_in(PC_in),
    .Branch_Control(Branch_Control),
    .Instruction_out(Instruction_out),
    .PC_out(PC_out)
  );

  // Clock generation
  always begin
    clk = 0;
    #10;
    clk = 1;
    #10;
  end

  // Stimulus
  initial begin
  #20;
    // case 2 : Natural state
    reset = 0;
    enable = 1;
    Instruction_in = 32'hFFFFFFFF;
    PC_in = 32'h00000001;
    Branch_Control = 0;
	 
	 	#20;

	 
	 // case 1 : hazard is detect
	 
	 reset = 0;
    enable = 0;// hazard signal
    Instruction_in = 32'hFFFFFFFF;
    PC_in = 32'h00000001;
    Branch_Control = 0;
	 
	 	 #20;

	 // case 3 : branch miss prediction
	 reset = 1;// miss predict signal
    enable = 1;
    Instruction_in = 32'hFFFFFFFF;
    PC_in = 32'h00000001;
    Branch_Control = 1; // branch signal
	 
	 	 #20;

	 
	  // case 2 : Natural state
    reset = 0;
    enable = 1;
    Instruction_in = 32'h00000000;
    PC_in = 32'h00000002;
    Branch_Control = 0;
	 
	 
		
  end
  
  
   initial #150 $stop;

endmodule
