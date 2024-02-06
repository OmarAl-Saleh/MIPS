module Branch(
input Branch_Flag,
input [3:0] ALUOp,
input [31:0] Data1,
input [31:0] Data2,
input [15:0] Target,
input [31:0] next_pc,
output reg [31:0] Branch_address,
output reg zero
);
always @(*) begin

	zero = 0 ;
	Branch_address [15:0] = Target [15:0] ;
	Branch_address [31:16] = {16{Target[15]}};
	Branch_address = Branch_address * 4 ;
	Branch_address = Branch_address + next_pc;

	if(Branch_Flag) begin

		if(ALUOp == 4'b0100)begin // beq
		
				if (Data1 == Data2)begin
					zero = 1 ;
				end
				
			 end
			 
			 else if(ALUOp == 4'b0101)begin // bne
				
				if (Data1 != Data2)begin
					zero = 1 ;
				end
				
			 end
			 
			 else if(ALUOp == 4'b0110)begin // bgt
			 
				if (Data1 > Data2)begin
					zero = 1 ;
				end
				
			 end
			 
			 else if(ALUOp == 4'b0111)begin // blt
			 
				if (Data1 < Data2)begin
					zero = 1 ;
				end
			 end
			 
			 else if(ALUOp == 4'b1000)begin // bge
			 
				if (Data1 >= Data2)begin
					zero = 1 ;
				end
				end
			 
			 else if(ALUOp == 4'b1001)begin // ble
			 
				if (Data1 <= Data2)begin
					zero = 1 ;
				end
			 end
			 
		end
	
	end



endmodule 