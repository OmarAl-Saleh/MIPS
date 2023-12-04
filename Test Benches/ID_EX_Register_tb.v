`timescale 1ns/1ns

module ID_EX_Register_tb;

 

  // Signals
  reg clk, reset;
  reg [31:0] In_Reg_File_Data1, In_Reg_File_Data2, In_offset;
  reg [4:0] In_Rs, In_Rt, In_Rd;
  reg In_ALUSrc, In_MemWrite, In_MemRead, In_RegWrite;
  reg [3:0] In_ALUOp;
  reg [1:0] In_MemtoReg, In_RegDst;
  wire [31:0] Out_Reg_File_Data1, Out_Reg_File_Data2, Out_offset;
  wire [4:0] Out_Rs, Out_Rt, Out_Rd;
  wire Out_ALUSrc, Out_MemWrite, Out_MemRead, Out_RegWrite;
  wire [3:0] Out_ALUOp;
  wire [1:0] Out_MemtoReg, Out_RegDst;

  // Instantiate the module
  ID_EX_Register uut (
    .clk(clk),
    .reset(reset),
    .In_Reg_File_Data1(In_Reg_File_Data1),
    .In_Reg_File_Data2(In_Reg_File_Data2),
    .In_offset(In_offset),
    .In_Rs(In_Rs),
    .In_Rt(In_Rt),
    .In_Rd(In_Rd),
    .In_ALUSrc(In_ALUSrc),
    .In_MemWrite(In_MemWrite),
    .In_MemRead(In_MemRead),
    .In_RegWrite(In_RegWrite),
    .In_ALUOp(In_ALUOp),
    .In_MemtoReg(In_MemtoReg),
    .In_RegDst(In_RegDst),
    .Out_Reg_File_Data1(Out_Reg_File_Data1),
    .Out_Reg_File_Data2(Out_Reg_File_Data2),
    .Out_offset(Out_offset),
    .Out_Rs(Out_Rs),
    .Out_Rt(Out_Rt),
    .Out_Rd(Out_Rd),
    .Out_ALUSrc(Out_ALUSrc),
    .Out_MemWrite(Out_MemWrite),
    .Out_MemRead(Out_MemRead),
    .Out_RegWrite(Out_RegWrite),
    .Out_ALUOp(Out_ALUOp),
    .Out_MemtoReg(Out_MemtoReg),
    .Out_RegDst(Out_RegDst)
  );

  // Clock generation
  always begin
    clk = 0;
    #10;
    clk = 1;
    #10;
  end
  // Initial block
  initial begin
    // Initialize inputs
    clk = 0;
    reset = 0;
    In_Reg_File_Data1 = 32'hA5A5A5A5;
    In_Reg_File_Data2 = 32'h12345678;
    In_offset = 32'hFFFF0000;
    In_Rs = 5'b00100;
    In_Rt = 5'b01000;
    In_Rd = 5'b11111;
    In_ALUSrc = 1'b1;
    In_MemWrite = 1'b0;
    In_MemRead = 1'b0;
    In_RegWrite = 1'b1;
    In_ALUOp = 4'b0011;
    In_MemtoReg = 2'b10;
    In_RegDst = 2'b01;

    // Apply reset
   
    #10 ;

    // Apply other inputs
    #10 reset = 1;
    // Add more input assignments and delays as needed
//
//    // Check the outputs
//    $display("Output values:");
//    $display("Out_Reg_File_Data1 = %h", Out_Reg_File_Data1);
//    $display("Out_Reg_File_Data2 = %h", Out_Reg_File_Data2);
//    $display("Out_offset = %h", Out_offset);
//    $display("Out_Rs = %h", Out_Rs);
//    $display("Out_Rt = %h", Out_Rt);
//    $display("Out_Rd = %h", Out_Rd);
//    $display("Out_ALUSrc = %h", Out_ALUSrc);
//    $display("Out_MemWrite = %h", Out_MemWrite);
//    $display("Out_MemRead = %h", Out_MemRead);
//    $display("Out_RegWrite = %h", Out_RegWrite);
//    $display("Out_ALUOp = %h", Out_ALUOp);
//    $display("Out_MemtoReg = %h", Out_MemtoReg);
//    $display("Out_RegDst = %h", Out_RegDst);
//
//    // Add more output checks as needed
//
//    // Stop simulation
//    $stop;
  end
 initial #50 $stop;
endmodule