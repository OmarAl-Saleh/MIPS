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
  output reg [15:0] addr,
  output reg [25:0] jump
);
   reg [31:0] inst_mem [0:size - 1];

   initial begin // this should be removed because it is NOT synthesizable
	
	//-------------------------------------------------------------
	
	//testcase 6
//	
//	/*Address 0 */  inst_mem[0] = 32'b00000000000000000000100000100000; //ADD R1, R0, R0   
//	/*Address 4 */  inst_mem[1] = 32'b00000000000000000001000000100000; //ADD R2, R0, R0
//	/*Address 8 */  inst_mem[2] = 32'b00100000000010010000000001100100; //ADDI R9, R0, 100
//	/*Address 12 */ inst_mem[3] = 32'b00010000001010010000000000000010; //BEQ R1, R9, EXIT //START
//	/*Address 16 */ inst_mem[4] = 32'b00100000001000010000000000000001; //ADDI R1, R1, 1
//	/*Address 20 */ inst_mem[5] = 32'b00001000000000000000000000000011; //JUMP START
//	/*Address 24 */ inst_mem[6] = 32'b00000000001000100001100000100000; //ADD R3, R1, R2 //EXIT
	
	
	//testcase 5 
	
//	//a=2
//	/*Address 0 */  inst_mem[0] = 32'b00100000000000010000000000000010; //ADDI R1, R0, 2 (a)
//	/*Address 4 */  inst_mem[1] = 32'b00100000000000100000000000000010; //ADDI R2, R0, 2 (b)
//	/*Address 8 */  inst_mem[2] = 32'b00100000010000110000000000000011; //ADDI R3, R2, 3 (b+3)
//	/*Address 12 */ inst_mem[3] = 32'b00100100001000110000000000000010; //BGE  R1, R3, THEN Hazard Unit
//	/*Address 16 */ inst_mem[4] = 32'b00100000001000010000000000000001; //ADDI R1, R1, 1
//	/*Address 20 */ inst_mem[5] = 32'b00001000000000000000000000000111; //JUMP END
//	/*Address 24 */ inst_mem[6] = 32'b00100000001000010000000000000010; //ADDI R1, R1, 2 //THEN 
//	/*Address 28 */ inst_mem[7] = 32'b00000000010000010001000000100000; //ADD R2, R2, R1 //END
	
	//a=6
	
//	/*Address 0 */  inst_mem[0] = 32'b00100000000000010000000000000110; //ADDI R1, R0, 6 (a)
//	/*Address 4 */  inst_mem[1] = 32'b00100000000000100000000000000010; //ADDI R2, R0, 2 (b)
//	/*Address 8 */  inst_mem[2] = 32'b00100000010000110000000000000011; //ADDI R3, R2, 3 (b+3)
//	/*Address 12 */ inst_mem[3] = 32'b00100100001000110000000000000010; //BGE  R1, R3, THEN
//	/*Address 16 */ inst_mem[4] = 32'b00100000001000010000000000000001; //ADDI R1, R1, 1
//	/*Address 20 */ inst_mem[5] = 32'b00001000000000000000000000000111; //JUMP END
//	/*Address 24 */ inst_mem[6] = 32'b00100000001000010000000000000010; //ADDI R1, R1, 2 //THEN 
//	/*Address 28 */ inst_mem[7] = 32'b00000000010000010001000000100000; //ADD R2, R2, R1 //END
	
	
	//-------------------------------------------------------------
	//testcase 4
	
	
//	
//	/*Address 0 */  inst_mem[0] = 32'b00000000000000000100000000100000; //ADD R8, R0, R0
//	/*Address 4 */  inst_mem[1] = 32'b00100000000010010000000000001010; //ADDI R9, R9, 10
//	/*Address 8 */  inst_mem[2] = 32'b00000001000010010101000000100010; //SUB R10, R8, R9 //Loop Forwarding 
//	/*Address 12 */ inst_mem[3] = 32'b00100000000011000000000000000001; //ADDI R12, R0, 1
//	/*Address 16 */ inst_mem[4] = 32'b00011001000010010000000000000010; //BGT R8, R9, DONE
//	/*Address 20 */ inst_mem[5] = 32'b00100001000010000000000000000001; //ADDI R8, R8, 1
//	/*Address 24 */ inst_mem[6] = 32'b00001000000000000000000000000010; //JUMP LOOP
//	/*Address 28 */ inst_mem[7] = 32'b00000001001000000110100000100000; //ADD R13, R9, R0 //DONE
//	/*Address 32 */ inst_mem[8] = 32'b00100000000011100000000000011011; //ADDI R14, R0, 1B(27)
//	/*Address 36 */ inst_mem[9] = 32'b00110001110011100000000000010111; //ANDI R14, R14, 17(23) Forwarding
	
	// do not forget to put a high cycle such as 50000 cycle
	//-------------------------------------------------------------
	//testcase 3
	
//	inst_mem[0] = 32'b00000000000000001110000000000000; //ADD R28,R0,R0 (R28=0)
//	inst_mem[1] = 32'b10001111100010000000000000000000; //LW R8, 0(R28)
//	inst_mem[2] = 32'b10001111100010010000000000000100; //LW R9, 4(R28)
//	inst_mem[3] = 32'b00000001000010010100000000100000; //ADD R8, R8, R9 Hazard & Forwarding
//	inst_mem[4] = 32'b10001111100010100000000000001000; //LW R10, 8(R28)
//	inst_mem[5] = 32'b00000001010010100101000000100000; //ADD R10, R10, R10 Hazard & Forwarding
//	inst_mem[6] = 32'b00000001000010100100000000100010; //SUB R8, R8, R10
//	inst_mem[7] = 32'b00100001000010000000000000000001; //ADDI R8, R8, 1 Forwarding
//	inst_mem[8] = 32'b00000000000010000100000000100010; //SUB R8, R0, R8 Forwarding
	
	
	
	//-------------------------------------------------------------
	
	
	//testcase 2	

//   inst_mem[0] = 32'b10001100000000010000000000001000; //LW R1, 8(R0)
//	inst_mem[1] = 32'b00000000001000000000100010000000; //SLL R1, R1, 2 
//	inst_mem[2] = 32'b10101100000000010000000000000100; //SW R1, 4(R0) 
//	inst_mem[3] = 32'b10001100000000100000000000010000; //LW R2, 16(R0)
//	inst_mem[4] = 32'b10001100000000110000000000010000; //LW R3, 16(R0)
//	inst_mem[5] = 32'b00000000010000000001100001000000; //SLL R3, R2, 1 (There is a problem wee need Forwarding to solve it and hazard detection )
//	inst_mem[6] = 32'b10101100000000110000000000001100; //SW R3, 12(R0)
//	inst_mem[7] = 32'b10001100000001000000000000001100; //LW R4, 12(R0)
//	
	
	
	//testcase 1
	
//	inst_mem[0] = 32'b10001100000010000000000000000000; //LW R8, 0(R0)
//	inst_mem[1] = 32'b10001100000010010000000000100000; //LW R9, 0x20(R0)
//	inst_mem[2] = 32'b10001100000010100000000001010000; //LW R10, 0x50(R0)
//	inst_mem[3] = 32'b10001100000010110000000000001000; //LW R11, 0x8(R0)
//	
	//-------------------------------------------------------------
	//THIS TEST FOR BLT 
	/*
	inst_mem[0] = 32'b10001100000000010000000000000100;//lw reg1=3 
	inst_mem[1] = 32'b10001100001000100000000000000101;//lw reg2=8 
	inst_mem[2] = 32'b00011100001000100000000000000001;//bLt address=16 -->4*1+12 **should work**
	inst_mem[3] = 32'b10001100001000110000000000010001;//lw reg3=20   **should not work**
	inst_mem[4] = 32'b10001100010001000000000000000100;//lw reg4=12   **should work**
	*/
	
	// THIS TEST FOR JS & JAL INSTRUCTIONS
    // the goal is to make a infinite loop
	/*Address 0 */inst_mem[0] = 32'b00001100000000000000000000000100;//JAL Jump to address 16 and save R31 = 4
	/*Address 4 */inst_mem[1] = 32'b10001100000000010000000000000100;//lw reg1=3 (the jump will skip it) ** should not work**
	/*Address 8 */inst_mem[2] = 32'b00000000000000001110000000000000; //ADD R28,R0,R0 (R28=0)  ** should not work**
	/*Address 12 */inst_mem[3] = 32'b00000000000000001110000000000000; //ADD R28,R0,R0 (R28=0)  ** should not work**
	/*Address 16 */inst_mem[4] = 32'b00000011111001000010000000001000;// JS jump to address store in REG 31 so jump to address 4 (here we want forwarding to let this instruction wrok correclty )
	/*Address 20 */inst_mem[5] = 32'b00000000000000000100000000100000; //ADD R8, R0, R0
	//inst_mem[5] = 32'b00000000000000001110000000000000; //ADD R28,R0,R0 (R28=0)  ** should not work**
	
	
	//THIS TEST FOR BLT not working
	/*
	inst_mem[0] = 32'b10001100000000010000000000000100;//lw reg1=3 
	inst_mem[1] = 32'b10001100001000100000000000000101;//lw reg2=8 
	inst_mem[2] = 32'b00011100010000010000000000000001;//bLt address=16 -->4*1+12 **should not work**
	inst_mem[3] = 32'b10001100001000110000000000010001;//lw reg3=20   **should work**
	inst_mem[4] = 32'b10001100010001000000000000000100;//lw reg4=12   **should work**
	*/
	
	
	//THIS TEST FOR BGT 
	/*
	inst_mem[0] = 32'b10001100000000010000000000000100;//lw reg1=3 
	inst_mem[1] = 32'b10001100001000100000000000000101;//lw reg2=8 
	inst_mem[2] = 32'b00011000010000010000000000000001;//bgt address=16 -->4*1+12 **should work**
	inst_mem[3] = 32'b10001100001000110000000000010001;//lw reg3=20   **should not work**
	inst_mem[4] = 32'b10001100010001000000000000000100;//lw reg4=12   **should work**
   */
	
	
	//THIS TEST FOR BGT not working
	/*
	inst_mem[0] = 32'b10001100000000010000000000000100;//lw reg1=3 
	inst_mem[1] = 32'b10001100001000100000000000000101;//lw reg2=8 
	inst_mem[2] = 32'b00011000001000100000000000000001;//bgt address=16 -->4*1+12 **should not work**
	inst_mem[3] = 32'b10001100001000110000000000010001;//lw reg3=20   **should work**
	inst_mem[4] = 32'b10001100010001000000000000000100;//lw reg4=12   **should work**
	*/
	
	//THIS TEST FOR BNE
	/*
	inst_mem[0] = 32'b10001100000000010000000000000100;//lw reg1=3 
	inst_mem[1] = 32'b10001100001000100000000000000101;//lw reg2=8 
	inst_mem[2] = 32'b00010100001000100000000000000001;//bne address=16 -->4*1+12 **should not work**
	inst_mem[3] = 32'b10001100001000110000000000010001;//lw reg3=20   **should not work**
	inst_mem[4] = 32'b10001100010001000000000000000100;//lw reg4=12   **should work**
	*/
	
	//THIS TEST FOR BNE not working
	/*
	inst_mem[0] = 32'b10001100000000010000000000000100;//lw reg1=3 
	inst_mem[1] = 32'b10001100000000100000000000000100;//lw reg2=3 
	inst_mem[2] = 32'b00010100001000100000000000000001;//bne address=16 -->4*1+12
	inst_mem[3] = 32'b10001100001000110000000000010001;//lw reg3=20 **should work**
	inst_mem[4] = 32'b10001100010001000000000000001001;//lw reg4=12   **should work**
	*/
	
	//THIS TEST FOR BEQ
	/*
	inst_mem[0] = 32'b10001100000000010000000000000100;//lw reg1=3 
	inst_mem[1] = 32'b10001100000000100000000000000100;//lw reg2=3 
	inst_mem[2] = 32'b00010000001000100000000000000001;//beq address=16 -->4*1+12
	inst_mem[3] = 32'b10001100001000110000000000010001;//lw reg3=20 **should not work**
	inst_mem[4] = 32'b10001100010001000000000000001001;//lw reg4=12   **should work**
	*/
	
	
	//THIS TEST FOR BEQ not working
	/*
	inst_mem[0] = 32'b10001100000000010000000000000100;//lw reg1=3 
	inst_mem[1] = 32'b10001100001000100000000000000101;//lw reg2=8 
	inst_mem[2] = 32'b00010000001000100000000000000001;//beq address=16 -->4*1+12 **should not work**
	inst_mem[3] = 32'b10001100001000110000000000010001;//lw reg3=20   **should work**
	inst_mem[4] = 32'b10001100010001000000000000000100;//lw reg4=12   **should work**
	*/
	
	
	/*  THIS TEST FOR JUMP INSTRUCTIONS
	inst_mem[0] = 32'b10001100000000010000000000001100;//load 12 in reg1
	inst_mem[1] = 32'b00001100000000000000000000000011;//jump to inst_mem[3] and save pc+1 in reg31 (jal)
// inst_mem[1] = 32'b00000000001000000000000000001000;//jump to content of reg1 (pc=12) 
//	inst_mem[1] = 32'b00001000000000000000000000000100;//jump to inst_mem[4] and skip inst_mem[3]
	inst_mem[2] = 32'b10001100000000100000000000010100;//load 20 in reg2
   inst_mem[3] = 32'b10001100000000110000000000001000;//load 8 in reg3
	*/

/*	
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
  inst_mem[18] = 32'b00110100100100000000000000000101;	 //ori	$16,$4,5 	-> or the content of reg4 (1100) with 5(0101) and sw in reg16=13
  inst_mem[19] = 32'b00110000100100010000000000000101;	 //andi  $17,$4,5		-> and the content of reg4 (1100) with 5(0101) and sw in reg17=4
  inst_mem[20] = 32'b10001100000100100000000000101100;	 //LW		$18,$44($0) -> reg18=big num
  inst_mem[21] = 32'b10001100000100110000000000101100; 	 //LW		$19,$44($0) -> reg19=big num
  inst_mem[22] = 32'b00000010010100111010000000100000;	 //add	$20,$18,$19 -> reg20= 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  inst_mem[23] = 32'b10001100000101010000000000110100;	 //LW		$21,$0(0)
  inst_mem[24] = 32'b10001100000101100000000000111000;	 //Lw		$22,$40(0)
  inst_mem[25] = 32'b00000010101101101011100000100001;	 //addu	$23,22,21 	-> should do unsigned overflow !
  inst_mem[26] = 32'b00000000111011011100000000100001;	 //addu	$24,$7,$13 -> reg24= should do unsigned overflow !
  inst_mem[27] = 32'b00000000111011011100100000100000;	 //add	$25,$7,$13 -> reg25= -20
  inst_mem[28] = 32'b00000000111011011101000000100011;	 //subu	$26,$7,$13 -> reg26= 10
  inst_mem[29] = 32'b00000000111011011101100000100010;	 //sub	$27,$7,$13 -> reg27= 10*/

  
 /*
checking LW muliable times

 inst_mem[0] = 32'b10001100000000010000000000000100; //reg1=3
  inst_mem[1] = 32'b10001100001000100000000000000101; //reg2=8
  inst_mem[2] = 32'b10001100001000110000000000010001; //reg3=20
  inst_mem[3] = 32'b10001100000011110000000000101000; //reg15=14
  inst_mem[4] = 32'b10001100000100100000000000101100; //reg18=big
  inst_mem[5] = 32'b10001100000100110000000000101100; //reg19=big
  inst_mem[6] = 32'b10001100000101010000000000101100; //reg21=big_num
  inst_mem[7] = 32'b10101100000101010000000000000000;// m[0]=big_num
  inst_mem[8] = 32'b10001100000101100000000000000000;//reg22=big*/
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
	 jump <= inst_out[25:0];
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
  reg21		big num -overflow check-
  reg22		big num -overflow check-
  reg23		don't care
  
  
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
  //				48			8'h2000000
  //				52			8'hF000000
  
  
  //$readmemh("./memfile_text.hex",mem,0,63);
  
  
  /*  'initial begin'  should be removed because it is NOT synthesizable
		status register must be added
		initialize memories after reset
		subu overflow check !!!
		
  */
  endmodule 