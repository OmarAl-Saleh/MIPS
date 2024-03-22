module Instruction_Decoder(Instruction_in,opcode,rs,rt,rd,shamt,funct,addr,jump);
input [31:0] Instruction_in;
  output reg [5:0] opcode;
  output reg [4:0] rs;
  output reg [4:0] rt;
  output reg [4:0] rd;
  output reg [4:0] shamt;
  output reg [5:0] funct;
  output reg [15:0] addr;
  output reg [25:0] jump;
  
  always@(*)
	begin
	
		opcode <= Instruction_in [31:26];
		rs <= Instruction_in [25:21];
		rt <= Instruction_in [20:16];
		rd <= Instruction_in [15:11];
		shamt <= Instruction_in [10:6];
		funct <= Instruction_in [5:0];
		addr <= Instruction_in [15:0];
		jump <= Instruction_in [25:0];
	
	
	end 
	
	
	
	endmodule 