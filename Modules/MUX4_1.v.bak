module MUX4_1(
    input wire [31:0] a,
    input wire [31:0] b,
	 input wire [31:0] c,
    input wire [1:0] select,
    output wire [31:0] out
);
     assign out = (select == 2'b00) ? a :
                 (select == 2'b01) ? b :
                 (select == 2'b10) ? c :
                 5'b0;
endmodule