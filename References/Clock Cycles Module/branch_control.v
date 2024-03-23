module branch_control(
    input wire [31:0] extended_address,
    input wire [31:0] next_pc,
    output wire [31:0] branch
);
    assign branch = (extended_address << 2) + next_pc;
endmodule
