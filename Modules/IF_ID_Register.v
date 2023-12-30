module IF_ID_Register (clk,reset,enable,Instruction_in,PC_in,Branch_Control,Instruction_out,PC_out, opcode,rs,rt,rd,shamt,funct,addr,jump);

input clk ;
input reset; // 0-->1 to delete the previous instruction and store a nop instruction (flush) with opcode 111000 according to our control unit default value
//we use it in branch miss prediction this signal come from zero in branch alu

input enable; // 0-->1 to enable the register to received new instruction we use 
//it in hazard detection to make flush and the output opcode is 111000 it comes only from  the hazard detection unit

input [31:0] Instruction_in; // the instruction come from fetch stage

input [31:0] PC_in; // the value of pc+4 come from fetch stage

input Branch_Control; // to know if the function cause reset (zero signal) is from branch instruction in ID stage

output reg [31:0] Instruction_out; // the instruction output to decode stage

  output reg [5:0] opcode;
  output reg [4:0] rs;
  output reg [4:0] rt;
  output reg [4:0] rd;
  output reg [4:0] shamt;
  output reg [5:0] funct;
  output reg [15:0] addr;
  output reg [25:0] jump;
  
  
  
  
  
  

output reg [31:0] PC_out ; // the pc output to decode stage


//32'b000000 00000000000000000000000000;

always@(posedge clk)
	begin
		
		if((enable == 1'b0) && (Branch_Control == 1'b0))
			begin
	
				if((reset == 1'b1)  )
				// when to flush the register in reset status
					begin
				
						Instruction_out <=32'b11100000000000000000000000000000; // nop
						opcode <= 6'b111000;
						// rubish values do not care because of that I use Instruction Out
						rs <= Instruction_out [25:21];
						rt <= Instruction_out [20:16];
						rd <= Instruction_out [15:11];
						shamt <= Instruction_out [10:6];
						funct <= Instruction_out [5:0];
						addr <= Instruction_out [15:0];
						jump <= Instruction_out [25:0];
						PC_out <= PC_in;
		
					end
					
				else
					begin
					// case 2 : when we do not have any problem
						Instruction_out <=Instruction_in;
						opcode <= Instruction_in [31:26];
						rs <= Instruction_in [25:21];
						rt <= Instruction_in [20:16];
						rd <= Instruction_in [15:11];
						shamt <= Instruction_in [10:6];
						funct <= Instruction_in [5:0];
						addr <= Instruction_in [15:0];
						jump <= Instruction_in [25:0];
						PC_out <= PC_in;
		
					end
				
			end
			
		//else 
		// case 1 : when we have a branch miss prediction so we want to output a flush and delete the value that was store in the register
		// case 2 : when we catch a hazard we want to keep the old value in the register so we do not do anything we remain the values as it 
      
			/*begin
			
				Instruction_out <=32'b11100000000000000000000000000000; // nop
				opcode <= Instruction_in [31:26];
				rs <= Instruction_in [25:21];
				rt <= Instruction_in [20:16];
				rd <= Instruction_in [15:11];
				shamt <= Instruction_in [10:6];
				funct <= Instruction_in [5:0];
				addr <= Instruction_in [15:0];
				jump <= Instruction_in	 [25:0];
				PC_out <= PC_in;
			
			end*/
			
			
			
	
	end
	
	
endmodule



