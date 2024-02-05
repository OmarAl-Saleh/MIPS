module PC #(
    parameter first_address = 0,
    parameter pc_inc = 4
)(
    input wire clk,
    input wire reset,
    input wire [31:0] target,
	 input wire pc_load,
    output reg [31:0] pc
);

reg state = 1'b0;


//FSM Style
always @(posedge clk or posedge reset) begin

    if (reset) begin
        pc <= 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		  state=1'b0;
		  
    end else begin
        case (state)
            1'b0: begin
                state <= 1'b1;
                pc <= first_address;
            end
            1'b1: begin
                if (pc_load) begin
                    pc <= target;
            end 
            end
            default: begin
                state <= 1'b0;
                pc <= 32'h00000000;
            end
        endcase
    end
end

endmodule
