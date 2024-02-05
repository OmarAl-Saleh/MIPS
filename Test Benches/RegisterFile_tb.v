`timescale 1ns/1ns

module RegisterFile_tb();

  // Inputs
  reg Clock;
  reg Reset;
  reg PC_Store;
  reg PUSH_Stack;
  reg PULL_Stack;
  reg [4:0] ReadReg1;
  reg [4:0] ReadReg2;
  reg [4:0] WriteReg;
  reg [31:0] WriteData;
  reg Reg_write_Control;


  // Outputs
  wire [31:0] ReadData1;
  wire [31:0] ReadData2;
  wire [31:0] StackData;

  // Instantiate the RegisterFile module
  RegisterFile uut (
    .Clock(Clock),
    .Reset(Reset),
    .ReadReg1(ReadReg1),
    .ReadReg2(ReadReg2),
    .WriteReg(WriteReg),
    .WriteData(WriteData),
    .Reg_write_Control(Reg_write_Control),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
	 .PC_Store(PC_Store),
	 .PUSH_Stack(PUSH_Stack),
	 .PULL_Stack(PULL_Stack),
	 .StackData(StackData)
  );

  // Clock generation
  always begin
  // posedge = odd every 10 --> 30 --> 50 ...
  // the other inputs changed every even clock =  20 --> 40 --> 60 ..
  // we must not make the clock posedge with same rate with others because we have small delay generally in simulation or in FBGA
    Clock = 0;
    #10;
    Clock = 1;
    #10;
  end

  // Initialize inputs
  initial begin
    Reset = 1;
    ReadReg1 = 0;
    ReadReg2 = 0;
    WriteReg = 0;
    WriteData = 0;
    Reg_write_Control = 0;
	 PC_Store=0;
	 PUSH_Stack=0;
    PULL_Stack=0;

    // Apply reset
    Reset = 0;
//    #20;
//    Reset = 1;
//
//    // Write some data to the registers
//	 ReadReg1 = 5'b11111;
//    ReadReg2 = 5'b00010;
//    WriteReg = 5'b11111;
//    WriteData = 32'h12345678;
//    Reg_write_Control = 1;
//    #20;
//	 
//    WriteReg = 5'b00010;
//    WriteData = 32'h9ABCDEF0;
//    Reg_write_Control = 1;
//    #20;
//
//    // Read data from the registers
//    ReadReg1 = 5'b11111;
//    ReadReg2 = 5'b00010;
//    Reg_write_Control = 0;
//    #20;
//	 
	  // Write some data to the registers2
    WriteReg = 5'b11101;// reg 27
    WriteData = 32'h00000002;
    Reg_write_Control = 1;
	 PULL_Stack=1;
	 //Reset = 0; 
    #20;
//    WriteReg = 5'b00101;
//    WriteData = 32'h00000005;
//    Reg_write_Control = 1;
//    #20;
//
//    // Read data from the registers2
//    ReadReg1 = 5'b0010;
//    ReadReg2 = 5'b11111;
//    Reg_write_Control = 0;
//    #20;
	 // push to the stack
	 ReadReg1 = 0;
    ReadReg2 = 0;
    WriteReg = 0;
    WriteData = 0;
    Reg_write_Control = 1;
	 PC_Store=0;
	 PUSH_Stack=1;
    PULL_Stack=0;
	 
	 #20;
	  // pull from the stack 
	 
	 ReadReg1 = 0;
    ReadReg2 = 0;
    WriteReg = 0;
    WriteData = 0;
    Reg_write_Control = 1;
	 PC_Store=0;
	 PUSH_Stack=0;
    PULL_Stack=1;
	 
	 #20;
	 
	 
	 ReadReg1 = 0;
    ReadReg2 = 0;
    WriteReg = 32'h00000068;
    WriteData = 0;
    Reg_write_Control = 1;
	 PC_Store=1;
	 PUSH_Stack=0;
    PULL_Stack=0;
	 
	 #20;
	 
	 
	 ReadReg1 = 0;
    ReadReg2 = 0;
    WriteReg = 0;
    WriteData = 0;
    Reg_write_Control = 1;
	 PC_Store=0;
	 PUSH_Stack=0;
    PULL_Stack=1;
	 
	 #20;
	 
	 
	 ReadReg1 = 0;
    ReadReg2 = 0;
    WriteReg = 0;
    WriteData = 0;
    Reg_write_Control = 1;
	 PC_Store=0;
	 PUSH_Stack=0;
    PULL_Stack=1;
	 
	 #20;



  end
  
  
    initial #150 $stop;
  
  
endmodule
