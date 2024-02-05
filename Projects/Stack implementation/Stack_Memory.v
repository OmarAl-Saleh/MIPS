module Stack_Memory(JAL_signal,JS_signal,Top_Stack_old,Top_Stack_new);

//input [4:0] Size;
//input clk;
input JAL_signal,JS_signal; // JAL signal = MemToReg[1] || JS_signal=JUMP[1]

input [31:0] Top_Stack_old ;

output reg [31:0] Top_Stack_new ;

//output reg Load_RAM_signal,Store_RAM_signal ; // signal that will be oring with control signal to control the RAM Operations

//reg Full_Flag , Empty_Flag; we may have exception for it 


// we can change the condition if want to handle the stack overflow exception

//*****size of stack********
// First entry in address Entry(22) : 88 32'h00000058
// last entry in address Entry(31) : 124 32'h0000007C



always@(*)
 begin
	
//

// check if the stack pointer is in allowed range otherwise I assign the fist index to him (its to avoid initial begin )
   if( Top_Stack_old < 32'h00000058  || Top_Stack_old > 32'h0000007C || Top_Stack_old == 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx )
		begin  Top_Stack_new <= 32'h00000058; end
		

   else 
		
	begin

		
// JAL PUSH Operation		
   
	
 
		if(JAL_signal == 1'b1 && Top_Stack_old != 32'h0000007C ) // check if the stack full
			
			begin
			
				Top_Stack_new <= Top_Stack_old+4;
				//Store_RAM_signal <= 1;
				//Load_RAM_signal<=0;
			
			end
			
// JS POP Operation 
		else if(JS_signal == 1'b1 && Top_Stack_old != 32'h00000058 ) // check if the stack empty
			
			begin
				
				
				Top_Stack_new <= Top_Stack_old-4;
				//Store_RAM_signal <= 0;
				//Load_RAM_signal<=1;
			
			
			end
			
		else 
		
		 begin
			
			Top_Stack_new <= Top_Stack_old;
				//Store_RAM_signal <= 0;
				//Load_RAM_signal<=0;
			
		 
		 end
 
 
 
 
	end
 
 end 
 
 
 
 endmodule 