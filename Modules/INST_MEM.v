module INST_MEM #(
  parameter size = 32,          
  parameter data_width = 32    
)(
 // input clk,
  input reset,                   
  input [31:0] address,
  output reg [31:0] inst_out,
  output reg [5:0] opcode,
  output reg [4:0] rs,
  output reg [4:0] rt,
  output reg [4:0] rd,
  output reg [4:0] shamt,
  output reg [5:0] funct,
  output reg [15:0] addr
);
   reg [31:0] inst_mem [0:size - 1];

<<<<<<< HEAD
   initial begin// inst_mem[3] = 32'b10101100001010100000000000010001;		 //SW	$10, $17(1) -> store the content of reg 10 in address 40 (entity 10) in RAM = 11 *****
				
  inst_mem[0] = 32'b10001100000000010000000000000100;		 //LW $1 , 4($0)  -> load the content of address (content of reg 0 + 4=4) in ram to reg1 =3
  inst_mem[1] = 32'b10001100001000100000000000000101;		 //LW $2 , 5($1)	-> load the content of address (content of reg 3 + 5=8) in ram to reg2 =8
  inst_mem[2] = 32'b00000000001000100101000000100000;		 //add $10,$1,$2  -> add  the content of reg 1 and 2 then store it in reg 10 = 11
  inst_mem[3] = 32'b10001100001000110000000000010001;     //LW $3 , 17($1) -> load the content of address (content of reg 1(3) + 17=20) in ram to reg3 =20
  inst_mem[4] = 32'b00100000010001010000000000000110;		 //addi $5,$2,6	-> add  the content of reg 2 to 6 (8+6 =14) then store it in reg5 =14
  inst_mem[5] = 32'b10001100010001000000000000000100;		 //LW $4 , 4($2)  -> load the content of address (content of reg2 (8) + 4=12) in ram to reg4 =12
  inst_mem[6] = 32'b00000000101000010011000000100010;		 //sub  $6,$5,$1	-> sub  the content of reg1 from reg5 (14-3=11) then store it in reg6=11
  inst_mem[7] = 32'b00000000001000100011100000100010;		 //sub  $7,$1,$2 -> sub  the content of reg2 from reg1 (3-8=-5) then store it in reg7=-5
  inst_mem[8] = 32'b00000000001010100100000000100100;		 //and  $8,$1,$10 -> and  the content of reg10 with reg1 (ans:3) then store it in reg8=3
  inst_mem[9] = 32'b00000000001010100100100000100101;		 //or	  $9,$1,$10 -> or   the content of reg10 with reg1 (ans:11) then store it in reg9=11
  inst_mem[10] = 32'b00000000110001000101100000100110;	 //xor  $11,$6,$4->xor   the content of reg6 with reg4 (ans:7) then store it in reg11=7
  inst_mem[11] = 32'b00000000010001100110000000100111;	 //nor  $12,$2,$6->nor   the content of reg2 with reg6 (ans:-12) then store it in reg12=-12
  inst_mem[12] = 32'b00000000001001110110100000011000;	 //mul  $13,$1,$7->mul   the content of reg1 with reg7 (ans:-5*3=-15) then store it in reg13=-15
  inst_mem[13] = 32'b00000000100010000111000000011010;	 //div  $14,$4,$8->div   the content of reg4 by reg8 (ans:12/3=4) then store it in reg14 = 4
  inst_mem[14] = 32'b00000001000000000100000010000000;	 //sll  $8 ,$0,$8->reg8=3*4=12
  inst_mem[15] = 32'b00000001000000000100000010000010;	 //slr  $8 ,$0,$8->reg8=12/4=3
  
  inst_mem[16] = 32'b10101100000001010000000000101000;	 //sw   $5,40($0)->sw {m[40]=14} 						
  inst_mem[17] = 32'b10001100000011110000000000101000; 	 //lw $15,40($0) -> reg15 = m[40] = 14		
=======
   initial begin
	
  inst_mem[0] = 32'b10001100000000010000000000000100;		 //LW		$1 , $4(0)  -> load the content of address (content of reg 0 + 4=4) in ram to reg1 =3
  inst_mem[1] = 32'b10001100001000100000000000000101;		 //LW 	$2 , $5(1)	-> load the content of address (content of reg 3 + 5=8) in ram to reg2 =8
  inst_mem[2] = 32'b00000000001000100101000000100000;		 //add 	$10,$1,$2   -> add  the content of reg 1 and 2 then store it in reg 10 = 11
  inst_mem[3] = 32'b10001100001000110000000000010001;     //LW 	$3 , $17(1) -> load the content of address (content of reg 1(3) + 17=20) in ram to reg3 =20
  inst_mem[4] = 32'b00100000010001010000000000000110;		 //addi 	$5,$2,6		-> add  the content of reg2 to 6 (8+6 =14) then store it in reg5 =14
  inst_mem[5] = 32'b10001100010001000000000000000100;		 //LW 	$4 , $4(3)  -> load the content of address (content of reg2 (8) + 4=12) in ram to reg4 =12
  inst_mem[6] = 32'b00000000101000010011000000100010;		 //sub 	$6,$5,$1		-> sub  the content of reg1 from reg5 (14-3=11) then store it in reg6=11
  inst_mem[7] = 32'b00000000001000100011100000100010;		 //sub   $7,$1,$2		-> sub  the content of reg10 from reg1 (3-8=-5) then store it in reg7=-5
  inst_mem[8] = 32'b00000000001010100100000000100100;		 //and   $8,$1,$10   -> and  the content of reg10 with reg2 (ans:3) then store it in reg8=3
  inst_mem[9] = 32'b00000000001010100100100000100101;		 //or	   $9,$1,$10   -> or   the content of reg10 with reg2 (ans:11) then store it in reg9=11
  inst_mem[10] = 32'b00000000110001000101100000100110;	 //xor   $11,$4,$6	-> xor   the content of reg15 with reg10 (ans:3) then store it in reg11=7
  inst_mem[11] = 32'b00000000010001100110000000100111;	 //nor   $12,$2,$6	-> nor   the content of reg15 with reg10 (ans:8) then store it in reg12=-12
  inst_mem[12] = 32'b00000000001001110110100000011000;	 //mul   $13,$1,$7	-> mul   the content of reg1 with reg7 (ans:-5*3=-15) then store it in reg13=-15
  inst_mem[13] = 32'b00000000100010000111000000011010;	 //div   $14,$4,$8	-> div   the content of reg4 by reg8 (ans:12/3=4) then store it in reg14 = 4
  inst_mem[14] = 32'b00000001000000000100000010000000;	 //sll   $8 ,$0,$8	-> reg8=3*4=12
  inst_mem[15] = 32'b00000001000000000100000010000010;	 //slr   $8 ,$0,$8	-> reg8=12/4=3
  inst_mem[16] = 32'b10101100000001010000000000101000;	 //sw    $5,$40($0)	-> sw {m[40]=14} 					
  inst_mem[17] = 32'b10001100000011110000000000101000; 	 //lw 	$15,$40($0) -> reg15 = m[40] = 14	
>>>>>>> 2a685215e33f8a4c2027321c599507411775f7ee
  inst_mem[18] = 32'b00110100100100000000000000000101;	 //ori	$16,$4,5 	-> or the content of reg4 (1100) with 5(0101) and sw in reg16=13
  inst_mem[19] = 32'b00110000100100010000000000000101;	 //andi  $17,$4,5		-> and the content of reg4 (1100) with 5(0101) and sw in reg17=4
  inst_mem[20] = 32'b10001100000100100000000000101100;	 //LW		$18,$44($0) -> reg18=big num
  inst_mem[21] = 32'b10001100000100110000000000101100; 	 //LW		$19,$44($0) -> reg19=big num
  inst_mem[22] = 32'b00000010010100111010000000100000;	 //add	$20,$18,$19 -> reg20= 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
<<<<<<< HEAD
  	
=======
>>>>>>> 2a685215e33f8a4c2027321c599507411775f7ee
  
  end
  
 
  integer i;
  
  always @(*) begin
    if (reset) begin
     
      for (i = 0; i < size; i = i + 1) begin
        inst_mem[i] <= 32'b0;
      end
    end 
	 else begin
    inst_out <= inst_mem[address >> 2];
    opcode <= inst_out[31:26];
    rs <= inst_out[25:21];
    rt <= inst_out[20:16];
    rd <= inst_out[15:11];
    shamt <= inst_out[10:6];
    funct <= inst_out[5:0];
    addr <= inst_out[15:0];
  end
  end
  
  
  /*
  after doing this code the registers values are :
  reg1		3
  reg2		8
  reg3		20 
  reg4		12
  reg5		14
  reg6		11
  reg7		-5
  reg8		3
  reg9		11
  reg10		11
  reg11		7
  reg12		-12
  reg13		-15
  reg14		4
  reg15		14
  reg16		13
  reg17		4
  reg18		(2^31)-1
  reg19		(2^31)-1
  reg20		don't care
  
  
  */


  
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
  //				40			14
  //				44			(2^31-1)
  
  
  //$readmemh("./memfile_text.hex",mem,0,63);
  
  endmodule 