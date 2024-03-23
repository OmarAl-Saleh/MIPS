module sign_extend (
    input wire  [15:0] extend,
    output wire [31:0] extended
);

assign    extended[15:0] = extend[15:0];
assign    extended[31:16] = {16{extend[15]}};

endmodule
