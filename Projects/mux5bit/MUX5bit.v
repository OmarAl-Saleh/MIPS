module MUX5bit (
    input wire [4:0] a,
    input wire [4:0] b,
    input wire select,
    output wire [4:0] out
);
    assign out = (select) ? b : a;
endmodule