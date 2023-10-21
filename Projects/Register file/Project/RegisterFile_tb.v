`timescale 1ns/1ns

module RegisterFile_tb();

  // Inputs
  reg Clock;
  reg Reset;
  reg [4:0] ReadReg1;
  reg [4:0] ReadReg2;
  reg [4:0] WriteReg;
  reg [31:0] WriteData;
  reg Reg_write_Control;

  // Outputs
  wire [31:0] ReadData1;
  wire [31:0] ReadData2;

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
    .ReadData2(ReadData2)
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
    Reset = 0;
    ReadReg1 = 0;
    ReadReg2 = 0;
    WriteReg = 0;
    WriteData = 0;
    Reg_write_Control = 0;

    // Apply reset
    Reset = 0;
    #20;
    Reset = 1;

    // Write some data to the registers
    WriteReg = 5'b00000;
    WriteData = 32'h12345678;
    Reg_write_Control = 1;
    #20;
    WriteReg = 5'b00001;
    WriteData = 32'h9ABCDEF0;
    Reg_write_Control = 1;
    #20;

    // Read data from the registers
    ReadReg1 = 5'b00000;
    ReadReg2 = 5'b00001;
    Reg_write_Control = 0;
    #20;
	 
	  // Write some data to the registers2
    WriteReg = 5'b00010;
    WriteData = 32'h00000002;
    Reg_write_Control = 1;
	 //Reset = 0; 
    #20;
    WriteReg = 5'b00101;
    WriteData = 32'h00000005;
    Reg_write_Control = 1;
    #20;

    // Read data from the registers2
    ReadReg1 = 5'b0010;
    ReadReg2 = 5'b00101;
    Reg_write_Control = 0;
    #20;

  end
  
  
    initial #150 $stop;
  
  
endmodule