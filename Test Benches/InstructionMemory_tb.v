module inst_tb;
  reg clk;
  reg reset;
  reg [31:0] address;
  wire [31:0] inst_out;
  wire [5:0] opcode;
  wire [4:0] rs;
  wire [4:0] rt;
  wire [4:0] rd;
  wire [4:0] shamt;
  wire [5:0] funct;
  wire [14:0] addr;

  // Instantiate the module
  INST_MEM uut (
    .clk(clk),
	 .reset(reset),
    .address(address),
    .inst_out(inst_out),
    .opcode(opcode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shamt(shamt),
    .funct(funct),
    .addr(addr)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Test stimulus
  initial begin
    clk = 0;
    address = 0;

    // Wait for a few clock cycles
    #10

    // Set the address to access different instructions
    address = 0;
    #5;
    address = 4;
    #5;
    address = 8;
    #5;
    address = 12;
    #5;
    address = 16;
    #5;
    address = 20;
    #5;
	 
	 reset=1;
	 #10 reset=0;
	 
	  address = 0;
    #5;
    address = 4;
    #5;
    address = 8;
    #5;
    address = 12;
    #5;
    address = 16;
    #5;
    address = 20;
	 

    // You can continue with other addresses as needed
    // Remember to add delays between address changes to observe the output
    // ...

    // Finish simulation
    #100 $stop;
  end
endmodule
