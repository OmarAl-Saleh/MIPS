module EX_MEM_Register (
// input signals
	
	clk,In_Address,In_Write_Data, In_Rd,
	 
	// output signals
	Out_Address,Out_Write_Data, Out_Rd,
	// control unit input signals
	
	// MEM signals
	In_MemWrite,In_MemRead,
	
	// WB signals
	In_RegWrite, In_MemtoReg,
	
	// control unit output signals
	
	// MEM signals
	Out_MemWrite,Out_MemRead,
	
	// WB signals
	Out_RegWrite, Out_MemtoReg,
	In_PC,Out_PC,
	
	// halt signal
	In_halt,Out_halt
); 


input clk ;

input [31:0] In_Address,In_Write_Data,In_PC ; // this refer to ALU reselt as an address and Read data 2 from register file as an write data to store in memory

input [4:0] In_Rd; // the values come from the instruction in ID stage

input In_MemWrite,In_MemRead,In_RegWrite;

input [1:0] In_MemtoReg;

input In_halt;

output reg [31:0]  Out_Address,Out_Write_Data,Out_PC ;

output reg [4:0]   Out_Rd; 

output reg Out_MemWrite,Out_MemRead,Out_RegWrite;
							 

output reg [1:0] Out_MemtoReg;

output reg Out_halt;

						 
						 
always @(posedge clk)
	begin
		
			
			Out_Address <= In_Address;
			Out_Write_Data <= In_Write_Data;
					
			Out_Rd <=In_Rd;
			
			Out_MemWrite <= In_MemWrite;
			Out_MemRead <= In_MemRead;
			Out_RegWrite <= In_RegWrite;
			
			Out_MemtoReg<=In_MemtoReg;
			
			Out_PC<=In_PC;
			
			Out_halt<=In_halt;
			
	
	end


						 
							 
endmodule 