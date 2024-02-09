module ID_EX_Register (
// input signals
	clk,reset
	,In_Reg_File_Data1,In_Reg_File_Data2,
	In_offset,In_Rs,In_Rt,In_Rd,
	// output signals
   Out_Reg_File_Data1,Out_Reg_File_Data2,
	Out_offset,Out_Rs,Out_Rt,Out_Rd,
	// control unit input signals
	// EX signals
	In_ALUSrc, In_ALUOp ,In_RegDst,In_func, In_shamt,
	
	// MEM signals
	In_MemWrite,In_MemRead,
	
	// WB signals
	In_RegWrite, In_MemtoReg,
	
	// control unit output signals
	// EX signals
	Out_ALUSrc, Out_ALUOp ,Out_RegDst,Out_func, Out_shamt,
	
	// MEM signals
	Out_MemWrite,Out_MemRead,
	
	// WB signals
	Out_RegWrite, Out_MemtoReg, 
	// JAL PC WB Value 
	In_PC,Out_PC
); 


input clk , reset ; // reset is active when we catch a hazard in decode we use it instead of a mux to make all the values equal zeroes

input [31:0] In_Reg_File_Data1,In_Reg_File_Data2,In_offset,In_PC ; // the data come from the register file and the offset from the sign extend 

input [4:0] In_Rs,In_Rt,In_Rd; // the values come from the instruction in ID stage

input In_ALUSrc,In_MemWrite,In_MemRead,In_RegWrite;

input [3:0] In_ALUOp;
input [1:0] In_MemtoReg;
input [1:0] In_RegDst;

input [5:0] In_func;

input [4:0] In_shamt;

output reg [31:0]  Out_Reg_File_Data1, Out_Reg_File_Data2, Out_offset,Out_PC ;

output reg [4:0]   Out_Rs , Out_Rt  , Out_Rd; 

output reg Out_ALUSrc,Out_MemWrite,Out_MemRead,Out_RegWrite;
							 
output reg [3:0] Out_ALUOp;
output reg [1:0] Out_MemtoReg;
output reg [1:0] Out_RegDst;

output reg [5:0] Out_func;

output reg [5:0] Out_shamt;
						 
						 
always @(posedge clk)
	begin
		
		if(reset == 1'b1) // if it one so we catch a hazard
			begin
			
			Out_Reg_File_Data1<=32'b0;
			Out_Reg_File_Data2<=32'b0;
			Out_offset<=32'b0;
			
			Out_Rs <=5'b0;
			Out_Rt <=5'b0;
			Out_Rd <=5'b0;
			
			Out_ALUSrc <= 1'b0;
			Out_MemWrite <= 1'b0;
			Out_MemRead <= 1'b0;
			Out_RegWrite <= 1'b0;
			
			Out_ALUOp<=4'b0000;
			Out_MemtoReg<=2'b0;
			Out_RegDst<=2'b0;
			
			Out_func<=6'b000000;
			Out_shamt<=5'b00000;
			Out_PC<=32'b0;
			
			
			
			end
			
		else
			begin
			
			Out_Reg_File_Data1<= In_Reg_File_Data1;
			Out_Reg_File_Data2<= In_Reg_File_Data2;
			Out_offset<= In_offset;
			
			Out_Rs <=In_Rs;
			Out_Rt <=In_Rt;
			Out_Rd <=In_Rd;
			
			Out_ALUSrc <= In_ALUSrc;
			Out_MemWrite <= In_MemWrite;
			Out_MemRead <= In_MemRead;
			Out_RegWrite <= In_RegWrite;
			
			Out_ALUOp<=In_ALUOp;
			Out_MemtoReg<=In_MemtoReg;
			Out_RegDst<=In_RegDst;
			
			Out_func<=In_func;
			Out_shamt<=In_shamt;
			
			Out_PC<=In_PC;
			
			end
			
	
	
	end


						 
							 
endmodule 