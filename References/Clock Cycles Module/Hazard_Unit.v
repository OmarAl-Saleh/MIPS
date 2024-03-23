module Hazard_Unit(D_rs,D_rt,EX_rt,EX_MemRead,ID_EX_FLUSH,IF_ID_write,PC_write,ID_Branch,MEM_rt,MEM_MemRead);


input [4:0] D_rs, D_rt ; // this signals is rs and rt for the instruction in ID stage

input [4:0] EX_rt ; input EX_MemRead;// this signals is rt and Memory read control signal for instruction EX stage (first preceding)

input ID_Branch  ; // this a control signal from the id Unit to determin if we have a branch instruction in id stage or not 

input [4:0] MEM_rt ; // this signal is rt for the instruction in Mem stage (second preceding instruction)

input MEM_MemRead ; // this signal is memory read control signal for instruction in Memory stage to determin if is load instruction

output wire ID_EX_FLUSH ,IF_ID_write , PC_write ;// this signals is to implement the stall 
reg reg_ID_EX_FLUSH ,reg_IF_ID_write , reg_PC_write ;






 always@(*)
 begin
 
 // first type of hazard is load-use hazard that occure when we find a depandancy between load instruction and its followed instruction
 
 reg_ID_EX_FLUSH <= 0; // to solve test case 5 bug
 reg_IF_ID_write <= 1; 
 reg_PC_write <= 1; 
				
	if((EX_MemRead == 1'b1) && (ID_Branch == 1'b0))
		begin
			if((D_rs == EX_rt) || (D_rt == EX_rt))
				begin
			
				reg_ID_EX_FLUSH <= 1; //(Reset for ID_EX_REG) to select zeroes for the control mux that control the flow of ID/EX register
				reg_IF_ID_write <= 0; // to disable the the IF/ID register so he can't load new values and keep his old value
				reg_PC_write <= 0; // to disable the the PC so he can't load new values and keep his old value
				
				
				end
	
		end
		
	//second type hazard is Data hazards for branches that occur when we find a depandancy between branch and first preceding or second preceding if is it a load instruction
	
	else 
		begin
			
		if (ID_Branch == 1'b1)
				begin
				
				if  ( ((D_rs == EX_rt) || (D_rt == EX_rt)) || ( (MEM_MemRead == 1'b1) && ( (D_rs == MEM_rt) || (D_rt == MEM_rt) ) ))  				
					begin
			
					reg_ID_EX_FLUSH <= 1; // to select zeroes for the control mux that control the flow of ID/EX register
					reg_IF_ID_write <= 0; // to disable the the IF/ID register so he can't load new values and keep his old value
					reg_PC_write <= 0; // to disable the the PC so he can't load new values and keep his old value
				
				
					end
				
			
				end
		
		
	
		else 
				begin 
					reg_ID_EX_FLUSH <= 0; 
					reg_IF_ID_write <= 1; 
					reg_PC_write <= 1; 
				
	
				end
		end

  end

  // assign output wires
   assign ID_EX_FLUSH = reg_ID_EX_FLUSH;
   assign IF_ID_write = reg_IF_ID_write;
	assign PC_write = reg_PC_write;
	
  
  
  
  endmodule 