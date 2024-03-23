module MEM_WB_Register (
// input signals
	
	clk,In_RAM_Data,In_Immediate_Data, In_Rd,
	 
	// output signals
	Out_RAM_Data,Out_Immediate_Data, Out_Rd,
	// control unit input signals
	
	
	// WB signals
	In_RegWrite, In_MemtoReg,
	
	// control unit output signals
	
	// WB signals
	Out_RegWrite, Out_MemtoReg,
	In_PC,Out_PC,
	
	//halt signal
	In_halt,Out_halt
	
); 


input clk ;

input [31:0] In_RAM_Data,In_Immediate_Data,In_PC ; // this refer to RAM output data and Immediate data

input [4:0] In_Rd; // the values come from the instruction in ID stage

input In_RegWrite;

input [1:0] In_MemtoReg;

input In_halt;


output reg [31:0]  Out_RAM_Data,Out_Immediate_Data,Out_PC ;

output reg [4:0]   Out_Rd; 

output reg Out_RegWrite;
							 

output reg [1:0] Out_MemtoReg;

output reg Out_halt;
						 
						 
always @(posedge clk)
	begin
		
			
			Out_RAM_Data <= In_RAM_Data;
			Out_Immediate_Data <= In_Immediate_Data;
					
			Out_Rd <=In_Rd;
			
			Out_RegWrite <= In_RegWrite;
			Out_MemtoReg<=In_MemtoReg;
			
			Out_PC<=In_PC;
			
			Out_halt<=In_halt;
			
	
	end
	
endmodule
