module INST_MEM #(
  parameter size = 64,          
  parameter data_width = 32    
)(
 // input clk,
  input reset,                   
  input [31:0] address,
  output reg [31:0] inst_out

);
   reg [31:0] inst_mem [0:size - 1];

  
 
integer i ; 

//  endmodule 

reg state = 1'b0;
  
  
//  
  always @(*) 

 begin
        case (state)
            1'b0: begin
                state <= 1'b1;
					 // Enter here the Instructions of the program
					 
		 
	
		
      
		
	
	//-------------------------------------------------------------

/* LAST ADDRESS */ //inst_mem[4] = 32'b10110100001000100001100000100000; //Halt 
// every program should end with halt signal 

	

	 
                
            end
            1'b1: begin

          inst_out <= inst_mem[address >> 2];
             
            end
            
        endcase
   
end

endmodule