`timescale 1ns/1ns

module Hazard_Unit_tb;

  // Inputs
  reg [4:0] D_rs, D_rt;
  reg [4:0] EX_rt;
  reg EX_MemRead;
  reg ID_Branch;
  reg [4:0] MEM_rt;
  reg MEM_MemRead;

  // Outputs
  wire ID_EX_FLUSH, IF_ID_write, PC_write;
  /*
  Hazard_Unit(D_rs,D_rt,EX_rt,EX_MemRead,ID_EX_FLUSH,IF_ID_write,PC_write,ID_Branch,MEM_rt,MEM_MemRead);
  */

  // Instantiate Hazard_Unit module
  Hazard_Unit uut (
    .D_rs(D_rs),
    .D_rt(D_rt),
    .EX_rt(EX_rt),
    .EX_MemRead(EX_MemRead),
	 .ID_EX_FLUSH(ID_EX_FLUSH),
	 .IF_ID_write(IF_ID_write),
    .PC_write(PC_write),
    .ID_Branch(ID_Branch),
    .MEM_rt(MEM_rt),
    .MEM_MemRead(MEM_MemRead)
    
  );

  // Initial block to apply test vectors
  initial begin
    // Test case 1: Load-use hazard (load dependancy in EX stage)
    D_rs = 5; D_rt = 0; EX_rt = 5; EX_MemRead = 1; ID_Branch = 0; MEM_rt = 0; MEM_MemRead = 0;
    #20;

    // Test case 2: Data hazard for branches (instruction dependency in EX stage )
    D_rs = 2; D_rt = 3; EX_rt = 3; EX_MemRead = 0; ID_Branch = 1; MEM_rt = 0; MEM_MemRead = 0;
    #20;
	 
	 // Test case 3: Data hazard for branches (load instruction dependency in Mem stage)
    D_rs = 2; D_rt = 3; EX_rt = 5; EX_MemRead = 0; ID_Branch = 1; MEM_rt = 1; MEM_MemRead = 1;
    #20;

    // Test case 4: No hazard
    D_rs = 1; D_rt = 2; EX_rt = 3; EX_MemRead = 0; ID_Branch = 0; MEM_rt = 0; MEM_MemRead = 0;
    #20;

    // Add more test cases as needed

//    // Terminate simulation
//    $finish;
  end
  
   initial #100 $stop;

endmodule
