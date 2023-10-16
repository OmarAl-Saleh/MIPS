module INST_MEM(
  input clk,
  input [31:0] address,
  output reg [31:0] inst_out,
  output reg [5:0] opcode,
  output reg [4:0] rs,
  output reg [4:0] rt,
  output reg [4:0] rd,
  output reg [4:0] shamt,
  output reg [5:0] funct,
  output reg [14:0] addr
);

  reg [31:0] inst_mem [0:31];

   initial begin
  inst_mem[0] = 32'b10001100000000010000000000000000;		 //LW $1 , $0(0)  -> load the content of address (content of reg 0 + 0=0) in ram to reg1 =2
  inst_mem[1] = 32'b10001100011000100000000000000100;		 //LW $2 , $4(3)	-> load the content of address (content of reg 3 + 4=4) in ram to reg2 =3
  inst_mem[2] = 32'b00000000001000100101000000100000;		 //add $10,$1,$2  -> add  the content of reg 1 and 2 then store it in reg 10 = 5
  inst_mem[3] = 32'b10101100001010100000000000100110;		 //SW	$10, $38(1) -> store the content of reg 10 in address 40 (entity 10) in RAM = 5
  inst_mem[4] = 32'b10001100010000110000000000000101;		 //LW $3 , $5(2)  -> load the content of address (content of reg2 (3) + 5=8) in ram to reg3 =8
  inst_mem[5] = 32'b10001100011001000000000000000100;		 //LW $4 , $4(3)  -> load the content of address (content of reg3 (8) + 4=12) in ram to reg4 =12
  inst_mem[6] = 32'b00000000011001000010100000001000;		 //addi $5,$4,3	-> add  the content of reg 4 to 3 (12+3 =15) then store it in reg5 =15
  inst_mem[7] = 32'b00000000101000010011000000100010;		 //sub  $6,$5,$1	-> sub  the content of reg1 from reg5 (15-2=13) then store it in reg6=13
  inst_mem[8] = 32'b00000000010010100011100000100010;		 //sub  $7,$2,$10 -> sub  the content of reg10 from reg2 (3-5=-2) then store it in reg7=-2
  inst_mem[9] = 32'b00000000010010100100000000100100;		 //and  $8,$2,$10 -> and  the content of reg10 with reg2 (ans:2) then store it in reg8=2
  inst_mem[10] = 32'b00000000010010100100100000100101;		 //or	  $9,$2,$10 -> or   the content of reg10 with reg2 (ans:3) then store it in reg9=3
  inst_mem[11] = 32'b10001100110011110000000000000011;		 //LW	  $15,$3(6) -> load the content of address (content of reg6 (13) + 3=16) in ram to reg15=6
  inst_mem[12] = 32'b00000001111010100101100000100110;		 //xor  $11,$15,$10->xor   the content of reg15 with reg10 (ans:3) then store it in reg11=3
  inst_mem[13] = 32'b00000001111010100110000000100111;		 //nor  $12,$15,$10->nor   the content of reg15 with reg10 (ans:8) then store it in reg12=8
  end
  
  always @(posedge clk) begin
    inst_out <= inst_mem[address >> 2];
    opcode <= inst_out[31:26];
    rs <= inst_out[25:21];
    rt <= inst_out[20:16];
    rd <= inst_out[15:11];
    shamt <= inst_out[10:6];
    funct <= inst_out[5:0];
    addr <= inst_out[15:0];
  end
  
  
  // i have to divide pc by 4 (DONE)
  
  
  //				((I type -> load and store))
  //	Opcode   |  RS   |  RD   |  Offset/Immediate
  //		6			5			5				16
  
  //				(( R type))
  //	Opcode   |  RS   |  RT   |  RD   |  Function Code
  //		6			5			5			5			6
  
  
 
  
  //				RAM :
  //				add     data
  //				0			2
  //				4			3
  //				8			8
  //				12			12
  //				16			6
  //				20			20
  //				24			24
  //				28			28
  //				32			32
  //				36			36
  
  
  endmodule 