module PC #( parameter first_address=0 ,pc_inc = 4)( //can add jump target
    input wire clk,
    input wire reset,
 // input wire [31:0] branch_target, // The target address for branch instructions
 // input wire [31:0] jump_target,   // The target address for jump instructions
 // input wire [31:0] pc_increment,  // The increment value for normal instruction flow
    output reg [31:0] pc
);


reg [1:0] state = 2'b00; 

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; 
        pc <= 32'h00000000; 
    end 
	 
	 else if (state == 2'b00) begin
        state <= 2'b01; 
        pc <= first_address;
    end 
	 
	 else if (state == 2'b01) begin 
        pc <= pc + pc_inc;
    end 
	 
	 end

endmodule
