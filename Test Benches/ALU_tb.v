module ALU_tb;

 
   reg clk;
   reg [31:0] A, B;
   reg [3:0] ALUControl;
   reg [4:0] ShiftAmount;
   wire [31:0] ALUOut;
   wire Zero;

   
   ALU alu (
      .clk(clk),
      .A(A),
      .B(B),
      .ALUControl(ALUControl),
      .ShiftAmount(ShiftAmount),
      .ALUOut(ALUOut),
      .Zero(Zero)
   );

   // Clock generation
   always begin
      #5 clk = ~clk;
   end

   // Test vectors
   initial begin
      // Initialize signals
      clk = 0;
      A = 32'hABCD1234;
      B = 32'h56781234;
      ALUControl = 4'b0000; // Addition
      ShiftAmount = 5'b00000;

      // Apply inputs and monitor outputs
      $display("Testing Addition");
      $display("Input A: %h", A);
      $display("Input B: %h", B);
      $display("ALUControl: %b", ALUControl);
      $display("ShiftAmount: %b", ShiftAmount);

      // Apply inputs
      #10 A = 32'h12345678; // Update input A
      #10 B = 32'h87654321; // Update input B
      ALUControl = 4'b0001; // Subtraction
      #10 ALUControl = 4'b0010; // Multiplication
      #10 ALUControl = 4'b0011; // Division
      #10 ALUControl = 4'b0100; // Logical shift left
      #10 ALUControl = 4'b0101; // Logical shift right
      #10 ALUControl = 4'b1000; // Logical AND
      #10 ALUControl = 4'b1001; // Logical OR
      #10 ALUControl = 4'b1010; // Logical XOR
      #10 ALUControl = 4'b1011; // Logical NOR
     

      // Check results
      $display("Output ALUOut: %h", ALUOut);
      $display("Zero Flag: %b", Zero);

      // Add more test cases as needed

      $finish; // Finish simulation
   end

endmodule
