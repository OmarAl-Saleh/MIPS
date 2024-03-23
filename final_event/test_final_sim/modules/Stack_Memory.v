module Stack_Memory(JAL_signal,JS_signal,Top_Stack_old,Top_Stack_new);

input JAL_signal,JS_signal; // to indicate if the instruction is JAL or JS

input [31:0] Top_Stack_old ;

output reg [31:0] Top_Stack_new ;


//*****size of stack********
// First entry in address Entry(22) : 88 32'h00000058
// last entry in address Entry(31) : 124 32'h0000007C
//**********************************************************


always@(*)
 begin
	
//

// check if the stack pointer is in allowed range otherwise I assign the fist index to him (its to avoid initial begin )
   if( Top_Stack_old < 32'h00000058  || Top_Stack_old > 32'h0000007C )
		begin  Top_Stack_new <= 32'h00000058; end
		

   else 
		
	begin

		
// JAL PUSH Operation		
   
	
 
		if(JAL_signal == 1'b1 && Top_Stack_old != 32'h0000007C ) // check if the stack full
			
			begin
			
				Top_Stack_new <= Top_Stack_old+4;
				
			
			end
			
// JS POP Operation 
		else if(JS_signal == 1'b1 && Top_Stack_old != 32'h00000058 ) // check if the stack empty
			
			begin
				
				
				Top_Stack_new <= Top_Stack_old-4;
				
			
			end
			
		else 
		
		 begin
			
			Top_Stack_new <= Top_Stack_old;
				
		 
		 end
 
 
 
 
	end
 
 end 
 
 
 
 endmodule 