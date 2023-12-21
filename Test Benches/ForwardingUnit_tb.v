`timescale 1ns / 1ns

module ForwardingUnit_tb;

    // Inputs
    reg [4:0] rs1_ID_EX;
    reg [4:0] rs2_ID_EX;
    reg [4:0] rd_EX_MEM;
    reg [4:0] rd_MEM_WB;
    reg RegWrite_EX_MEM;
    reg RegWrite_MEM_WB;

    // Outputs
    wire [1:0] forwardA;
    wire [1:0] forwardB;

    // Instantiate the Unit Under Test (UUT)
    ForwardingUnit uut (
        .rs1_ID_EX(rs1_ID_EX),
        .rs2_ID_EX(rs2_ID_EX),
        .rd_EX_MEM(rd_EX_MEM),
        .rd_MEM_WB(rd_MEM_WB),
        .RegWrite_EX_MEM(RegWrite_EX_MEM),
        .RegWrite_MEM_WB(RegWrite_MEM_WB),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    initial begin
        // Initialize Inputs
        rs1_ID_EX = 0;
        rs2_ID_EX = 0;
        rd_EX_MEM = 0;
        rd_MEM_WB = 0;
        RegWrite_EX_MEM = 0;
        RegWrite_MEM_WB = 0;

        // Add stimulus here
        #10; // Wait for 10ns
        rs1_ID_EX = 5;
        rs2_ID_EX = 6;
        rd_EX_MEM = 5; // Forwarding condition for rs1 from EX/MEM
        rd_MEM_WB = 6; // Forwarding condition for rs2 from MEM/WB
        RegWrite_EX_MEM = 1;
        RegWrite_MEM_WB = 1;

        #10; // Wait for 10ns
        rs1_ID_EX = 3;
        rs2_ID_EX = 4;
        rd_EX_MEM = 0; // No forwarding
        rd_MEM_WB = 0; // No forwarding
        RegWrite_EX_MEM = 0;
        RegWrite_MEM_WB = 0;
		  
		   #10; // Wait for 10ns
			// double data hazards
        rs1_ID_EX = 5;
        rs2_ID_EX = 6;
        rd_EX_MEM = 5; // Forwarding condition for rs1 from EX/MEM
        rd_MEM_WB = 5; // Forwarding condition for rs2 from MEM/WB
        RegWrite_EX_MEM = 1;
        RegWrite_MEM_WB = 1;


        // Continue with other scenarios...
		  
    end
	 
	 initial #100 $stop;

endmodule
