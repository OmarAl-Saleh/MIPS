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

    // Forwarding for rs1
    if (JS_JUMP[1]==1'b1 && EX_MEM_MemtoReg==2'b10 ) 
	 begin
        forwardA = 1'b1 ; // Forward from EX/MEM
    end 
	 
end

endmodule 