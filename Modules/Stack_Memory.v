module Stack_Memory(JAL_signal,JS_signal,Top_Stack_old,Top_Stack_new,Load_RAM_signal,Store_RAM_signal);

//input [4:0] Size;

input JAL_signal,JS_signal;

input [31:0] Top_Stack_old ;

output reg [31:0] Top_Stack_new ;

output reg Load_RAM_signal,Store_RAM_signal ;

//reg Full_Flag , Empty_Flag; we may have exception for it 


// we can change the condition if want to handle the stack overflow exception

always@(*)
 begin
	
// JAL PUSH Operation
 
		if(JAL_signal == 1'b1 && Top_Stack_old != 32'hFFFFFFFF ) // check if the stack full
			
			begin
			
				Top_Stack_new <= Top_Stack_old+4;
				Store_RAM_signal <= 1;
				Load_RAM_signal<=0;
			
			end
			
// JS POP Operation 
		else if(JS_signal == 1'b1 && Top_Stack_old != 32'h00000000 ) // check if the stack empty
			
			begin
				
				
				Top_Stack_new <= Top_Stack_old-4;
				Store_RAM_signal <= 0;
				Load_RAM_signal<=1;
			
			
			end
			
		else 
		
		 begin
			
			Top_Stack_new <= Top_Stack_old;
				Store_RAM_signal <= 0;
				Load_RAM_signal<=0;
			
		 
		 end
 
 
 
 
 
 
 end 
 
 
 
 endmodule 