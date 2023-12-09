module JUMP(
input JUMP_FLAG,
input [25:0] jump_offset,
input [31:0] next_pc,
output reg [31:0] JUMP_address
);

always @(*) 
begin

	if(JUMP_FLAG)
		begin
			JUMP_address = {next_pc[31:28], jump_offset, 2'b00};
		end
		
	else 
		begin
			JUMP_address =32'bx;
		end

end

endmodule 