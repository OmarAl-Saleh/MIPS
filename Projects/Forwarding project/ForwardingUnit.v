module ForwardingUnit (
    input [4:0] rs1_ID_EX,
    input [4:0] rs2_ID_EX,
    input [4:0] rd_EX_MEM,
    input [4:0] rd_MEM_WB,
    input RegWrite_EX_MEM,
    input RegWrite_MEM_WB,
    output reg [1:0] forwardA, 
    output reg [1:0] forwardB
);

// Forwarding logic for ALU inputs
always@(*)
begin
    // Default: No forwarding
    forwardA = 2'b00;
    forwardB = 2'b00;

    // Forwarding for rs1
    if (RegWrite_EX_MEM && (rd_EX_MEM != 0) && (rd_EX_MEM == rs1_ID_EX)) begin
        forwardA = 2'b10;  // Forward from EX/MEM
    end else if (RegWrite_MEM_WB && (rd_MEM_WB != 0) && (rd_MEM_WB == rs1_ID_EX)) begin
        forwardA = 2'b01;  // Forward from MEM/WB
    end

    // Forwarding for rs2
    if (RegWrite_EX_MEM && (rd_EX_MEM != 0) && (rd_EX_MEM == rs2_ID_EX)) begin
        forwardB = 2'b10;  // Forward from EX/MEM
    end else if (RegWrite_MEM_WB && (rd_MEM_WB != 0) && (rd_MEM_WB == rs2_ID_EX)) begin
        forwardB = 2'b01;  // Forward from MEM/WB
    end
end

endmodule 