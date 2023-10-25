module alu_control_tb;
  reg [1:0] ALUOp;
  reg [5:0] FuncField;
  wire [3:0] Operation;

  alu_control uut (
    .ALUOp(ALUOp),
	 .FuncField(FuncField),
    .Operation(Operation)
  );

  initial begin
    $display("Testing ALU Control Unit");

    // Test cases
	
    FuncField = 6'b000000;
    ALUOp = 2'b00;
    #10 $display("Input: FuncField = %b, ALUOp = %b, Output: Operation = %b", FuncField, ALUOp, Operation);
    
    FuncField = 6'b100000;
    ALUOp = 2'b10;
    #10 $display("Input: FuncField = %b, ALUOp = %b, Output: Operation = %b", FuncField, ALUOp, Operation);
	 
	  FuncField = 6'b100010;
    ALUOp = 2'b10;
    #10 $display("Input: FuncField = %b, ALUOp = %b, Output: Operation = %b", FuncField, ALUOp, Operation);
	 
	  FuncField = 6'b011000;
    ALUOp = 2'b10;
    #10 $display("Input: FuncField = %b, ALUOp = %b, Output: Operation = %b", FuncField, ALUOp, Operation);
	 
	  FuncField = 6'b011010;
    ALUOp = 2'b10;
    #10 $display("Input: FuncField = %b, ALUOp = %b, Output: Operation = %b", FuncField, ALUOp, Operation);
	 
	  ALUOp = 2'b00;
    FuncField = 6'b000000;
    
    #10 $display("Input: FuncField = %b, ALUOp = %b, Output: Operation = %b", FuncField, ALUOp, Operation);
	 
	 
     
	  ALUOp = 2'b11;
    FuncField = 6'b000000;
    
    #10 $display("Input: FuncField = %b, ALUOp = %b, Output: Operation = %b", FuncField, ALUOp, Operation);
	 
    

    #50 $stop;
  end

endmodule
