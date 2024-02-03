`timescale 1ns/1ns

module Stack_Memory_tb;

  // Inputs
  reg JAL_signal, JS_signal;
  reg [31:0] Top_Stack_old;

  // Outputs
  wire [31:0] Top_Stack_new;
  wire Load_RAM_signal, Store_RAM_signal;

  // Instantiate the Stack_Memory module
  Stack_Memory uut (
    .JAL_signal(JAL_signal),
    .JS_signal(JS_signal),
    .Top_Stack_old(Top_Stack_old),
    .Top_Stack_new(Top_Stack_new),
    .Load_RAM_signal(Load_RAM_signal),
    .Store_RAM_signal(Store_RAM_signal)
  );

  // Initial stimulus
  initial begin
   // $dumpfile("dump.vcd");
    //$dumpvars(0, tb_Stack_Memory);

    // Test JAL_PUSH operation
    JAL_signal = 1;
    JS_signal = 0;
    Top_Stack_old = 32'h00000000;

    #10; // Wait for a few simulation cycles

    // Test JS_POP operation
    JAL_signal = 0;
    JS_signal = 1;
    Top_Stack_old = 32'hFFFFFFFF;

    #10; // Wait for a few simulation cycles
	 
	 JAL_signal = 1;
    JS_signal = 0;
    Top_Stack_old = 32'hFFFFFFFF;

    #10; // Wait for a few simulation cycles
	 
	 JAL_signal = 0;
    JS_signal = 1;
    Top_Stack_old = 32'h00000000;

    #10; // Wait for a few simulation cycles

   
    $stop;
  end

endmodule
