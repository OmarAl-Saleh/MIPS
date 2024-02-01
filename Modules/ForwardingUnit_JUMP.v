module ForwardingUnit_JUMP (
    input [1:0] JS_JUMP,// signal indicate that the instruction in ID stage is JS instruction
    input [1:0] EX_MEM_MemtoReg,// signal indicate that the instruction in MEM stage is JAL instruction
    output reg forwardA 
);

// Forwarding logic for ALU inputs
always@(*)
begin
    // Default: No forwarding
    forwardA = 1'b0;
   // forwardB = 2'b00;

    // Forwarding for rs1
    if (JS_JUMP[1]==1'b1 && EX_MEM_MemtoReg[1]==1'b1 ) 
	 begin
        forwardA = 1'b1 ; // Forward from EX/MEM
    end 
	 
//	 else if (RegWrite_MEM_WB && (rd_MEM_WB != 0) && (rd_MEM_WB == rs1_ID_EX)) begin
//        forwardA = 2'b01;  // Forward from MEM/WB
//    end

    // Forwarding for rs2
//    if (RegWrite_EX_MEM && (rd_EX_MEM != 0) && (rd_EX_MEM == rs2_ID_EX)) begin
//        forwardB = 2'b10;  // Forward from EX/MEM
//    end else if (RegWrite_MEM_WB && (rd_MEM_WB != 0) && (rd_MEM_WB == rs2_ID_EX)) begin
//        forwardB = 2'b01;  // Forward from MEM/WB
//    end
end

endmodule 