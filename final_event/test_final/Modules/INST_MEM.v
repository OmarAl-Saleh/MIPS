module INST_MEM #(
  parameter size = 64,          
  parameter data_width = 32    
)(
 // input clk,
  input reset,                   
  input [31:0] address,
  output reg [31:0] inst_out

);
   reg [31:0] inst_mem [0:size - 1];

  

 /*	
inst_mem[0]=32'b10001100000000010000000000000000;
inst_mem[1]=32'b10001100000000100000000000000100;
inst_mem[2]=32'b10001100000000110000000000001000;
inst_mem[3]=32'b10001100000001000000000000001100;
inst_mem[4]=32'b10001100000001010000000000010000;
inst_mem[5]=32'b10001100000001100000000000010100;
inst_mem[6]=32'b10001100000001110000000000011000;
inst_mem[7]=32'b10001100000010000000000000011100;
inst_mem[8]=32'b10001100000010010000000000100000;
inst_mem[9]=32'b10001100000010100000000000100100;
inst_mem[10]=32'b10001100000010110000000000101000;
inst_mem[11]=32'b10001100000011000000000000101100;
inst_mem[12]=32'b10001100000011010000000000110000;
inst_mem[13]=32'b10001100000011100000000000110100;
inst_mem[14]=32'b10001100000011110000000000111000;
inst_mem[15]=32'b10001100000100000000000000111100;
inst_mem[16]=32'b10001100000100010000000001000000;
inst_mem[17]=32'b10001100000100100000000001000100;
inst_mem[18]=32'b10001100000100110000000001001000;
inst_mem[19]=32'b10001100000101000000000001001100;
inst_mem[20] = 32'b10110100001000100001100000100000;*///halt
	/*
inst_mem[0]=32'b00001100000000000000000000000010;
inst_mem[1]=32'b00001000000000000000000000011001;
inst_mem[2]=32'b00100000000100000000000000000000;
inst_mem[3]=32'b00100000000010000000000000000000;
inst_mem[4]=32'b00100000000100010000000000010011;
inst_mem[5]=32'b00011001000100010000000000010010;
inst_mem[6]=32'b00100000000010010000000000000000;
inst_mem[7]=32'b00000010001010010101000000100010;
inst_mem[8]=32'b00011001001010100000000000001101;
inst_mem[9]=32'b00000001001000000101100010000000;
inst_mem[10]=32'b00000010000010110110000000100000;
inst_mem[11]=32'b10001101100011010000000000000000;
inst_mem[12]=32'b10001101100011100000000000000100;
inst_mem[13]=32'b00011001101011100000000000000001;
inst_mem[14]=32'b00001000000000000000000000010100;
inst_mem[15]=32'b00000001101000000111100000100000;
inst_mem[16]=32'b00000001110000000110100000100000;
inst_mem[17]=32'b00000001111000000111000000100000;
inst_mem[18]=32'b10101101100011010000000000000000;
inst_mem[19]=32'b10101101100011100000000000000100;
inst_mem[20]=32'b00100001001010010000000000000001;
inst_mem[21]=32'b00001000000000000000000000001000;
inst_mem[22]=32'b00100001000010000000000000000001;
inst_mem[23]=32'b00001000000000000000000000000101;
inst_mem[24]=32'b00000011111001010010000000001000;
inst_mem[25]=32'b00000000000000000000000000100000;

//load inst

inst_mem[26]=32'b10001100000000010000000000000000;
inst_mem[27]=32'b10001100000000100000000000000100;
inst_mem[28]=32'b10001100000000110000000000001000;
inst_mem[29]=32'b10001100000001000000000000001100;
inst_mem[30]=32'b10001100000001010000000000010000;
inst_mem[31]=32'b10001100000001100000000000010100;
inst_mem[32]=32'b10001100000001110000000000011000;
inst_mem[33]=32'b10001100000010000000000000011100;
inst_mem[34]=32'b10001100000010010000000000100000;
inst_mem[35]=32'b10001100000010100000000000100100;
inst_mem[36]=32'b10001100000010110000000000101000;
inst_mem[37]=32'b10001100000011000000000000101100;
inst_mem[38]=32'b10001100000011010000000000110000;
inst_mem[39]=32'b10001100000011100000000000110100;
inst_mem[40]=32'b10001100000011110000000000111000;
inst_mem[41]=32'b10001100000100000000000000111100;
inst_mem[42]=32'b10001100000100010000000001000000;
inst_mem[43]=32'b10001100000100100000000001000100;
inst_mem[44]=32'b10001100000100110000000001001000;
inst_mem[45]=32'b10001100000101000000000001001100;
*/
//inst_mem[26] = 32'b10110100001000100001100000100000; 


 

reg state = 1'b0;
  
  
//  
  always @(*) begin

        case (state)
            1'b0: begin
                state <= 1'b1;
					 // Enter here the Instructions of the program 
					 
					$readmemh("inst_mem_input_BM1.txt", inst_mem); 
	
 /*  inst_mem[0]=32'b10001100000000010000000000110100; //LW R1,13*4(R0) //-1
	inst_mem[1]=32'b10001100000000100000000000110000; //LW R2,12*4(R0) //6
	inst_mem[2]=32'b00011000010000010000000000000001; //bgt R2,R1,halt 
	inst_mem[3]=32'b00100000000000110000000000000001; //addi R3,R0,1
	*/
	/*
	
inst_mem[0]=32'b00001100000000000000000000000010;
inst_mem[1]=32'b00001000000000000000000000011001;
inst_mem[2]=32'b00100000000100000000000000000000;
inst_mem[3]=32'b00100000000010000000000000000000;
inst_mem[4]=32'b00100000000100010000000000010011;
inst_mem[5]=32'b00011001000100010000000000010010;
inst_mem[6]=32'b00100000000010010000000000000000;
inst_mem[7]=32'b00000010001010010101000000100010;
inst_mem[8]=32'b00011001001010100000000000001101;
inst_mem[9]=32'b00000001001000000101100010000000;
inst_mem[10]=32'b00000010000010110110000000100000;
inst_mem[11]=32'b10001101100011010000000000000000;
inst_mem[12]=32'b10001101100011100000000000000100;
inst_mem[13]=32'b00011001101011100000000000000001;
inst_mem[14]=32'b00001000000000000000000000010100;
inst_mem[15]=32'b00000001101000000111100000100000;
inst_mem[16]=32'b00000001110000000110100000100000;
inst_mem[17]=32'b00000001111000000111000000100000;
inst_mem[18]=32'b10101101100011010000000000000000;
inst_mem[19]=32'b10101101100011100000000000000100;
inst_mem[20]=32'b00100001001010010000000000000001;
inst_mem[21]=32'b00001000000000000000000000001000;
inst_mem[22]=32'b00100001000010000000000000000001;
inst_mem[23]=32'b00001000000000000000000000000101;
inst_mem[24]=32'b00000011111001010010000000001000;
inst_mem[25]=32'b00000000000000000000000000100000;

//load inst

inst_mem[26]=32'b10001100000000010000000000000000;
inst_mem[27]=32'b10001100000000100000000000000100;
inst_mem[28]=32'b10001100000000110000000000001000;
inst_mem[29]=32'b10001100000001000000000000001100;
inst_mem[30]=32'b10001100000001010000000000010000;
inst_mem[31]=32'b10001100000001100000000000010100;
inst_mem[32]=32'b10001100000001110000000000011000;
inst_mem[33]=32'b10001100000010000000000000011100;
inst_mem[34]=32'b10001100000010010000000000100000;
inst_mem[35]=32'b10001100000010100000000000100100;
inst_mem[36]=32'b10001100000010110000000000101000;
inst_mem[37]=32'b10001100000011000000000000101100;
inst_mem[38]=32'b10001100000011010000000000110000;
inst_mem[39]=32'b10001100000011100000000000110100;
inst_mem[40]=32'b10001100000011110000000000111000;
inst_mem[41]=32'b10001100000100000000000000111100;
inst_mem[42]=32'b10001100000100010000000001000000;
inst_mem[43]=32'b10001100000100100000000001000100;
inst_mem[44]=32'b10001100000100110000000001001000;
inst_mem[45]=32'b10001100000101000000000001001100;
inst_mem[46]=32'b10001100000101010000000001010000;
*/
	
	//*******************************************************************************************************	
	//BENCHMARK1
/*	
inst_mem[0]=32'b10001100000000010000000000000000;
inst_mem[1]=32'b00110100000000100000000000000100;
inst_mem[2]=32'b00100000000000111111111111111110;
inst_mem[3]=32'b10001100000001000000000000000100;
inst_mem[4]=32'b00000000001000010010100000100000;
inst_mem[5]=32'b00000000001000100011000000100010;
inst_mem[6]=32'b00000000011001000011000000100100;
inst_mem[7]=32'b00000000001000100011100000100101;
inst_mem[8]=32'b00000000001000110010100000100110;
inst_mem[9]=32'b00000000001000100011000000100111;
inst_mem[10]=32'b00000000100000100011100000000000;
inst_mem[11]=32'b00000000001000100010100000000010;
inst_mem[12]=32'b00000000001000010010100000100000;
inst_mem[13]=32'b00000000101001000011000000100010;
inst_mem[14]=32'b00000000101001100011100000100100;
inst_mem[15]=32'b00110100101001010000000000001111;
inst_mem[16]=32'b10101100000000010000000000000000;
inst_mem[17]=32'b10101100000001000000000000000100;
inst_mem[18]=32'b10001100000001010000000000000000;
inst_mem[19]=32'b10001100000001100000000000000100;
inst_mem[20]=32'b00110000110001110000000000001011;
inst_mem[21]=32'b10101100000001110000000000001000;
inst_mem[22]=32'b10001100000001010000000000000000;
inst_mem[23]=32'b10101100000001010000000000001100;
inst_mem[24]=32'b00010000001000010000000000000001;
inst_mem[25]=32'b00000000010000100010100000100000;
inst_mem[26]=32'b00010100000000010000000000000010;
inst_mem[27]=32'b00000000010000100011000000100000;
inst_mem[28]=32'b00000000100001000011100000100000;
inst_mem[29]=32'b00001000000000000000000000100000;
inst_mem[30]=32'b00000000010000100010100000100000;
inst_mem[31]=32'b00000000100001000011000000100000;
inst_mem[32]=32'b00000000000000000000000000100000;
*/

//BENCHMARK 1
					 
//		Lw r1,0(R0)		10001100000000010000000000000000				0
//		ori r2 ,r0,4	00110100000000100000000000000100				1
//		addi r3,r0,-2	00100000000000111111111111111110				2
//		Lw r4,4(R0)		10001100000001000000000000000100				3

//		ADD R5,R1,R1	00000000001000010010100000100000				4
//		SUB R6,R1,R2	00000000001000100011000000100010				5
//		AND R6,R3,R4	00000000011001000011000000100100				6
//		OR  R7,R1,R2	00000000001000100011100000100101				7
//		XOR R5,R1,R3	00000000001000110010100000100110				8
//		NOR R6,R1,R2	00000000001000100011000000100111				9
//		SLL R7,R4,R2	00000000100000100011100000000000				10
//		SRL R5,R1,R2	00000000001000100010100000000010				11

//		add r5,r1,r1	00000000001000010010100000100000				12
//		sub r6,r5,r4	00000000101001000011000000100010				13
//		and r7,r5,r6	00000000101001100011100000100100				14
//		ori r5,r5,0xf	00110100101001010000000000001111				15
				
//		sw r1, 0(r0)	10101100000000010000000000000000				16
//		sw r4, 1(r0)	10101100000001000000000000000100				17
//		lw r5, 0(r0)	10001100000001010000000000000000				18
						
//		lw r6,1(r0)		10001100000001100000000000000100				19
//		andi r7,r6,0xb	00110000110001110000000000001011				20
//		sw r7,2(r0)		10101100000001110000000000001000				21
//		lw r5,0(r0)		10001100000001010000000000000000				22
//		sw r5,3(r0)		10101100000001010000000000001100				23


//24           beq r1, r1, P1			00010000001000010000000000000001// 1*4 + 26*4 = 27*4
//             add r5, r2, r2			00000000010000100010100000100000
//P1: 26       bne r0, r1, P2			00010100000000010000000000000010// 2*4 + 28*4 = 30*4
//    27       add r6, r2, r2			00000000010000100011000000100000
//      28     add r7, r4, r4			00000000100001000011100000100000
//P2: 29       j P3						00001000000000000000000000100000
//             add r5, r2, r2			00000000010000100010100000100000
//             add r6, r4, r4			00000000100001000011000000100000
//P3: 32       add r0, r0, r0 		00000000000000000000000000100000
//******************************************************	
/*BENCHMARK 2 - 20 elements

		0- JAL SORT															00001100000000000000000000000010
		1- J   END															00001000000000000000000000011001
SORT	2- addi R16,R0,0													00100000000100000000000000000000
		3- ADDI R8,R0,R0    //R8=0										00100000000010000000000000000000
		4- ADDI R17,R0,19   //R17=19									00100000000100010000000000010011
SL1	5- BGT  R8,R17,SEL1 //WILL LOOP 19 TIMES					00011001000100010000000000010010 ********************
		6- ADDI R9,R0,0	  //R9=0										00100000000010010000000000000000
		7- SUB  R10,R17,R9   //R10=R17-R9							00000010001010010101000000100010
SL2   8- BGT  R9,R10,SEL2												00011001001010100000000000001101
		9- SLL  R11,R9,2													00000001001000000101100010000000
		10-ADD  R12,R16,R11												00000010000010110110000000100000
		11-LW   R13,0(R12)												10001101100011010000000000000000
		12-LW   R14,4(R12)												10001101100011100000000000000100
		13-BGT  R13,R14,SWAP												00011001101011100000000000000001
		14-J	  ES															00001000000000000000000000010100
SWAP	15-ADD  R15,R13,R0												00000001101000000111100000100000
		16-ADD  R13,R14,R0												00000001110000000110100000100000
		17-ADD  R14,R15,R0												00000001111000000111000000100000
		18-SW   R13,0(R12)												10101101100011010000000000000000
		19-SW   R14,4(R12)												10101101100011100000000000000100
ES		20-ADDI R9,R9,1													00100001001010010000000000000001
		21-J	  SL2															00001000000000000000000000001000
SEL2	22-ADDI R8,R8,1													00100001000010000000000000000001
		23-J	  SL1															00001000000000000000000000000101
SEL1  24-JR	  R31															00000011111001010010000000001000
END	25-ADD R0,R0,R0													00000000000000000000000000100000

LW R1,0(R0)    															10001100000000010000000000000000
LW R2,4(R0)																	10001100000000100000000000000100
LW R3,8(R0)																	10001100000000110000000000001000
LW R4,12(R0)																10001100000001000000000000001100
LW R5,16(R0)																10001100000001010000000000010000
LW R6,20(R0)																10001100000001100000000000010100
LW R7,24(R0)																10001100000001110000000000011000
LW R8,28(R0)																10001100000010000000000000011100
LW R9,32(R0)																10001100000010010000000000100000
LW R10,36(R0)																10001100000010100000000000100100
LW R11,40(R0)																10001100000010110000000000101000
LW R12,44(R0)																10001100000011000000000000101100
LW R13,48(R0)																10001100000011010000000000110000
LW R14,52(R0)																10001100000011100000000000110100
LW R15,56(R0)																10001100000011110000000000111000
LW R16,60(R0)																10001100000100000000000000111100
LW R17,64(R0)																10001100000100010000000001000000
LW R18,68(R0)																10001100000100100000000001000100
LW R19,72(R0)																10001100000100110000000001001000
LW R20,76(R0)																10001100000101000000000001001100
*/

//****************************************************************************

/*BENCHMARK 2 - 2000 elements

		0- JAL SORT															00001100000000000000000000000010
		1- J   END															00001000000000000000000000011001
SORT	2- addi R16,R0,0													00100000000100000000000000000000
		3- ADDI R8,R0,R0    //R8=0										00100000000010000000000000000000
**		4- ADDI R17,R0,1999   //R17=1999								00100000000100010000011111001111
SL1	5- BGT  R8,R17,SEL1 //WILL LOOP 19 TIMES					00011001000100010000000000010010 ********************
		6- ADDI R9,R0,0	  //R9=0										00100000000010010000000000000000
		7- SUB  R10,R17,R9   //R10=R17-R9							00000010001010010101000000100010
SL2   8- BGT  R9,R10,SEL2												00011001001010100000000000001101
		9- SLL  R11,R9,2													00000001001000000101100010000000
		10-ADD  R12,R16,R11												00000010000010110110000000100000
		11-LW   R13,0(R12)												10001101100011010000000000000000
		12-LW   R14,4(R12)												10001101100011100000000000000100
		13-BGT  R13,R14,SWAP												00011001101011100000000000000001
		14-J	  ES															00001000000000000000000000010100
SWAP	15-ADD  R15,R13,R0												00000001101000000111100000100000
		16-ADD  R13,R14,R0												00000001110000000110100000100000
		17-ADD  R14,R15,R0												00000001111000000111000000100000
		18-SW   R13,0(R12)												10101101100011010000000000000000
		19-SW   R14,4(R12)												10101101100011100000000000000100
ES		20-ADDI R9,R9,1													00100001001010010000000000000001
		21-J	  SL2															00001000000000000000000000001000
SEL2	22-ADDI R8,R8,1													00100001000010000000000000000001
		23-J	  SL1															00001000000000000000000000000101
SEL1  24-JR	  R31															00000011111001010010000000001000
END	25-ADD R0,R0,R0													00000000000000000000000000100000

LW R1,0(R0)    															10001100000000010000000000000000
LW R2,4(R0)																	10001100000000100000000000000100
LW R3,8(R0)																	10001100000000110000000000001000
LW R4,12(R0)																10001100000001000000000000001100
LW R5,16(R0)																10001100000001010000000000010000
LW R6,20(R0)																10001100000001100000000000010100
LW R7,24(R0)																10001100000001110000000000011000
LW R8,28(R0)																10001100000010000000000000011100
LW R9,32(R0)																10001100000010010000000000100000
LW R10,36(R0)																10001100000010100000000000100100
LW R11,40(R0)																10001100000010110000000000101000
LW R12,44(R0)																10001100000011000000000000101100
LW R13,48(R0)																10001100000011010000000000110000
LW R14,52(R0)																10001100000011100000000000110100
LW R15,56(R0)																10001100000011110000000000111000
LW R16,60(R0)																10001100000100000000000000111100
LW R17,64(R0)																10001100000100010000000001000000
LW R18,68(R0)																10001100000100100000000001000100
LW R19,72(R0)																10001100000100110000000001001000
LW R20,76(R0)																10001100000101000000000001001100
*/
//***********************************************************
	

//-------------------------------------------------------------

//

/* LAST ADDRESS */ //inst_mem[46] = 32'b10110100001000100001100000100000; //Halt 
// every program should end with halt signal 

	

	 
                
            end
            1'b1: begin

          inst_out <= inst_mem[address >> 2];
             
            end
            
        endcase
    end


endmodule
