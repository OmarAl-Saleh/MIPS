module MUX5bit (
    input wire [4:0] a,
    input wire [4:0] b,
    input wire [1:0] select,
    output wire [4:0] out
);
	  wire [4:0] c;
	  assign c =5'b11111;
     assign out = (select == 2'b00) ? a :
                 (select == 2'b01) ? b :
                 (select == 2'b10) ? c :
                 5'b0;
endmodule