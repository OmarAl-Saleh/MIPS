module RAM #(
  parameter size = 64,
  parameter data_width = 32
)(
  input clk,
  input reset,                   // Reset signal
  input [31:0] address,
  input [data_width-1:0] data_write,
  input write_en,
  input read_en,
  output wire [data_width-1:0] data_out

 // output reg error
);
  //reg [31:0] mem [0:31];
   reg [31:0] mem [0:size - 1];
//  reg error;
 
  
  // Declare a memory array with parameterized size and data width.
 // reg [data_width-1:0] mem [0:size - 1];
  
initial begin
	
	
	
	//testcase 1
	/* mem[0] = 32'h00000003;
	 mem[1] = 32'h00000008;
	 mem[2] = 32'h00000005;
	 mem[3] = 32'h00000002;
	 mem[4] = 32'h00000032;
	 mem[5] = 32'h00000032;	
	 mem[6] = 32'h00000032;
	 mem[7] = 32'h00000032;
	 mem[8] = 32'h00000032;
	 mem[9] = 32'h00000032;
	 mem[10] = 32'h00000032;
	 mem[11] = 32'h00000032;
	 mem[12] = 32'h00000032;
	 mem[13] = 32'h00000032;
	 mem[14] = 32'h00000032;
	 mem[15] = 32'h00000032;
	 mem[16] = 32'h00000032;
	 mem[17] = 32'h00000068;
	 mem[18] = 32'h00000065;
	 mem[19] = 32'h0000006C;
	 mem[20] = 32'h0000006C;
	 mem[21] = 32'h0000006F;
	 mem[22] = 32'h00000000;*/
//	
	//testcase 4 & 5 & 6
   //no need for RAM
  
	//testcase 3
	
 //mem[0] = 32'h00000023; // 0x23 (35)
 // mem[1] = 32'h0000002F; // 0x2F (47)
 //mem[2] = 32'h0000001A; // 0x1A (26)
  
  

	//testcaase 2
/*
  mem[0] = 32'b00000000000000000000000000000011; // 3
  mem[1] = 32'b00000000000000000000000000000011; // 3
  mem[2] = 32'b00000000000000000000000000000011; // 3
  mem[3] = 32'b00000000000000000000000000000011; // 3
  mem[4] = 32'b00000000000000000000000000000011; // 3
  */
  
/*


  mem[0] = 32'b00000000000000000000000000000011; // 3
  mem[1] = 32'b00000000000000000000000000000101; // 5
  mem[2] = 32'b00000000000000000000000000001000; // 8
  mem[3] = 32'b00000000000000000000000000001100; // 12
  mem[4] = 32'b00000000000000000000000000000110; // 6
  mem[5] = 32'b00000000000000000000000000010100; // 20
  mem[6] = 32'b00000000000000000000000000011000; // 24
  mem[7] = 32'b00000000000000000000000000011100; // 28
  mem[8] = 32'b00000000000000000000000000100000; // 32
  mem[9] = 32'b00000000000000000000000000100100; // 36
//mem[10]= 32'b00000000000000000000000000001110; // from insrtuction sw =>14  
  mem[11]= 32'b01111111111111111111111111111111; // big number
  mem[12]= 32'b00000000000000000000000000000111; // 7
  mem[13]= 32'b00100000000000000000000000000000; // big number -for overflow check-
  mem[14]= 32'b11110000000000000000000000000000; // big number -for overflow check-
*/
//$readmemh("data_memory_initialization", mem );
end
  
     
			 assign data_out=(read_en)? ((reset)?8'h00000000:mem[address >> 2]):32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
			//assign data_out=(read_en)? mem[address >> 2]:32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  
//	integer i;
	
//  always @(posedge clk) begin
//  
//    if (reset) begin
//
//      for (i = 0; i < size; i = i + 1) begin
//        mem[i] <= 32'b0;
//      end
//      error <= 0;
//			
//		end 
//	 
//	 else if (write_en) begin
//          // Write data 
//          mem[address >> 2] <= data_write;
//        end
//
//  end
//
//  
//
//  
//endmodule


reg state = 1'b0;
  
  
//  
  always @(posedge clk) begin

  
	

	if (write_en || state==1'b0) begin
        case (state)
            1'b0: begin
                state <= 1'b1;
					 
			 $readmemh("RAM_Data.txt", mem);
					 
					 
	       /*  //testcase 1
					mem[0] = 32'h00000003;
					mem[1] = 32'h00000008;
					mem[2] = 32'h00000005;
					mem[3] = 32'h00000002;
					mem[4] = 32'h00000032;
					mem[5] = 32'h00000032;	
					mem[6] = 32'h00000032;
					mem[7] = 32'h00000032;
					mem[8] = 32'h00000032;
					mem[9] = 32'h00000032;
					mem[10] = 32'h00000032;
					mem[11] = 32'h00000032;
					mem[12] = 32'h00000032;
					mem[13] = 32'h00000032;
					mem[14] = 32'h00000032;
					mem[15] = 32'h00000032;
					mem[16] = 32'h00000032;
					mem[17] = 32'h00000068;
					mem[18] = 32'h00000065;
					mem[19] = 32'h0000006C;
					mem[20] = 32'h0000006C;
					mem[21] = 32'h0000006F;
					mem[22] = 32'h00000000;
*/
                
            end
            1'b1: begin
				

             mem[address >> 2] <= data_write;

				 
            end
            
        endcase
    end

end


endmodule

/*
Benchmark 2
00007D00
00003A01
00001683
00000F93
00000400
000003D6
00000191
00000175
000000B7
0000005E
00000044
00000019
00000006
FFFFFFFF
FFFFFFD9
FFFFFEE4
FFFFFD94
FFFFDC72
FFFFB069
FFFF86E8
*/

//RAM Benchmark 1
//
//0000f1e0
//0000001e


