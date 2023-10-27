module Main (
input clk,
input reset,
output wire [31:0] ReadData1,
output wire [31:0] ReadData2,
output wire [31:0] Writedata,
output wire Done
);

//PC
 wire [31:0] pc_out;
 
 PC #(.first_address(0),  .pc_inc(4) )
 pc_inst (
    .clk(clk),
    .reset(reset),
    .pc(pc_out)
  );
//end of PC
//------------------------------------
//inst_mem
wire[31:0] inst_out;
wire [5:0] opcode;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] shamt;
wire [5:0] funct;
wire [15:0] addrs;

INST_MEM #(.size(32),.data_width(32) )
inst_mem (
	// .clk(clk),
    .reset(reset),
    .address(pc_out),
    .inst_out(inst_out),
    .opcode(opcode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shamt(shamt),
    .funct(funct),
    .addr(addrs)
  );
//end of inst_mem
//------------------------------------

//ControlUnit
  wire RegDst, ALUSrc, MemtoReg, MemWrite, MemRead, RegWrite;
  wire [1:0] ALUOp;

ControlUnit control_inst (
    .Clock(clk),
    .Reset(reset),
    .opcode(opcode),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
  );
//end of ControlUnit
//------------------------------------
// Reg_File

    wire [4:0] write_reg_input; 
   
    MUX5bit mux_inst (
        .a(rt),        
        .b(rd),         
        .select(RegDst), 
        .out(write_reg_input)   
    );

	 //reg [31:0] ReadData0;
	/* output wire [31:0] ReadData1;
	 output wire [31:0] ReadData2;
	 output wire [31:0] Writedata;*/
	 
	


	  RegisterFile reg_file_inst (
		  .Done(Done),
        .Clock(clk),
        .Reset(reset),
        .ReadReg1(rs),
        .ReadReg2(rt),
        .WriteReg(write_reg_input),
        .Reg_write_Control(RegWrite),
        .WriteData(Writedata), //still error // Writedata
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
        //.Reg_Enable(Reg_Enable), // Connect Reg_Enable signal
        //.Registers_Read(Registers_Read) // Connect Registers_Read signals
    );
	/* always @(posedge clk) begin
	 assign ReadData0 = ReadData1 ;
	 end*/
	 
//end of Reg_File*/
//------------------------------------

//alu_cntrl

wire [3:0] Operation;

alu_control alu_ctrl (
	 .clk(clk),
    .FuncField(funct),
    .ALUOp(ALUOp),
    .Operation(Operation)
);

//end of alu_cntrl
//------------------------------------
//sign extend

wire [31:0] immediate_value;

sign_extend extender (
    .extend(addrs),
    .extended(immediate_value)
);

//end of sign extend
//------------------------------------
// MUX2_1 alu_sec_input

wire [31:0] alu_second_input;
 MUX2_1 alu_sec_input (
        .a(ReadData2),        
        .b(immediate_value),         
        .select(ALUSrc), 
        .out(alu_second_input)   
    );

//end of MUX2_1 alu_sec_input
//------------------------------------
//ALU
wire [31:0] alu_output;
wire zero ;

ALU alu (
	 .clk(clk),
    .A(ReadData1),
    .B(alu_second_input),
    .ALUControl(Operation),
    .ShiftAmount(shamt),
    .ALUOut(alu_output),
    .Zero(zero)
);



//end of ALU
//------------------------------------
// DATA MAM
wire [31:0] Read_data;

RAM #(
    .size(32),             
    .data_width(32)

) ram (
    .clk(clk),
    .reset(reset),
    .address(alu_output),
    .data_write(ReadData2),
    .write_en(MemWrite),
    .read_en(MemRead),
    .data_out(Read_data)

    
);
//end of DATA_MEM
//------------------------------------
//Write back
MUX2_1 Write_back (
        .a(alu_output),        
        .b(Read_data),         
        .select(MemtoReg), 
        .out(Writedata)   
    );
	 
endmodule 


//****************************************************PC*******************************************************************
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
//*******************************************INstruction Memory************************************************************
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


   initial begin
	
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
  inst_mem[18] = 32'b00110100100100000000000000000101;	 //ori	$16,$4,5 	-> or the content of reg4 (1100) with 5(0101) and sw in reg16=13
  inst_mem[19] = 32'b00110000100100010000000000000101;	 //andi  $17,$4,5		-> and the content of reg4 (1100) with 5(0101) and sw in reg17=4
  inst_mem[20] = 32'b10001100000100100000000000101100;	 //LW		$18,44($0) -> reg18=big num
  inst_mem[21] = 32'b10001100000100110000000000101100; 	 //LW		$19,44($0) -> reg19=big num
  inst_mem[22] = 32'b00000010010100111010000000100000;	 //add	$20,$18,$19 -> reg20= 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  
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
  
 // ********************************************************Control Unit************************************************************************
  module ControlUnit(Clock,Reset,opcode,RegDst,ALUSrc,MemtoReg,MemWrite,MemRead,ALUOp,RegWrite);
input wire [5:0] opcode; 
input Clock , Reset ;  // Reset : 1 --> on | 0--> off
// wires
output wire RegDst,ALUSrc,MemtoReg,MemWrite,MemRead,RegWrite;
output wire [1:0] ALUOp;
// reg type
 reg reg_RegDst,reg_ALUSrc,reg_MemtoReg,reg_MemWrite,reg_MemRead,reg_RegWrite;
 reg [1:0] reg_ALUOp;
	reg [5:0] reset_opcode ;
//	    opcode,  // 6-bit opcode from the instruction
//     RegDst,      // Control signal for selecting the destination register
//     ALUSrc,      // Control signal for ALU source selection (0 for register, 1 for immediate)
//     MemtoReg,    // Control signal for selecting the source for register write data
//     MemWrite,    // Control signal for memory write
//     MemRead,     // Control signal for memory read
//     Branch,      // Control signal for branching
//     ALUOp,       // Control signal for ALU operation
//     RegWrite     // Control signal for register write
//     reset_reg    // will handle the default value if the reset is on 


always @(*)
begin
	if(Reset==1'b1)
	reset_opcode <=6'b111000; // this bits will call the default value and make the control unit reset
	else
	reset_opcode <=opcode;
	
end 




always @(*) 

	if(Reset==1'b1)begin 
	 // defualt value we can use it if we will implement reset or unsupported instructions
		 reg_ALUSrc = 1'b0;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 1'b0;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;
end
	
	
	else begin
	case(opcode)
	
	6'b000000:begin 
		// R-type instruction 
       reg_ALUSrc = 1'b0;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 1'b0;
      reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b10;
       reg_RegDst = 1'b1;
	
	end
	
		6'b100011:begin 
		// load instruction 
       reg_ALUSrc = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 1'b1;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b1;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;
	
	end
	
	   6'b101011:begin
		// store instruction 
       reg_ALUSrc = 1'b1;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 1'b0; //error (should be 0 ) i am an idiot ...*****
       reg_MemWrite = 1'b1;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;  //don't care
	
	end
	
		6'b001000:begin
		//immediate instruction (addi)
		 reg_ALUSrc = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 1'b0;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;
	end
	
		6'b001100:begin
		//immediate instruction (andi)
		reg_ALUSrc = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 1'b0;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b01;
       reg_RegDst = 1'b0;
	end
			6'b001101:begin
		//immediate instruction (ori)
		reg_ALUSrc = 1'b1;
		 reg_RegWrite = 1'b1;
       reg_MemtoReg = 1'b0;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b11;
       reg_RegDst = 1'b0;
	end
		
	
	// we can here add two cases for branch and jump control signals 
	
	default : begin 
	 // defualt value we can use it if we will implement reset or unsupported instructions
		 reg_ALUSrc = 1'b0;
		 reg_RegWrite = 1'b0;
       reg_MemtoReg = 1'b0;
       reg_MemWrite = 1'b0;
       reg_MemRead = 1'b0;
       reg_ALUOp = 2'b00;
       reg_RegDst = 1'b0;
	
	

end

endcase
end

// assign the output wires 
assign RegDst = reg_RegDst;
assign ALUSrc = reg_ALUSrc;
assign MemtoReg = reg_MemtoReg;
assign MemWrite = reg_MemWrite;
assign MemRead = reg_MemRead;
assign RegWrite = reg_RegWrite;
assign ALUOp = reg_ALUOp;

endmodule 
//****************************************************Register File *****************************************
module RegisterFile(Done,Clock,Reset,ReadReg1,ReadReg2,WriteReg,WriteData,Reg_write_Control,ReadData1,ReadData2);


//********cycle time ********
output Done;
//********************
input Clock , Reset;
input [4:0] ReadReg1 , ReadReg2 , WriteReg;
input Reg_write_Control;
input [31:0] WriteData;
output [31:0] ReadData1;
output [31:0] ReadData2;
// define bus (wires)
wire [31:0] Reg_Enable;
wire [31:0] Registers_Read [31:0];

// to get the register enable we want to write on 
RegFile_decoder dex(WriteReg,Reg_write_Control,Reg_Enable);

// we first write then we read from register file 

//*************Cycle time ******************//

assign Done = (WriteData==32'b00000000000000000000000000001000)?1:0;

//////***************************************//

//write on Register file
RegFile_regn Reg_0(WriteData, 1'b1, Reg_Enable[0], Clock,Registers_Read[0]);
RegFile_regn Reg_1(WriteData, Reset, Reg_Enable[1], Clock,Registers_Read[1]);
RegFile_regn Reg_2(WriteData, Reset, Reg_Enable[2], Clock,Registers_Read[2]);
RegFile_regn Reg_3(WriteData, Reset, Reg_Enable[3], Clock,Registers_Read[3]);
RegFile_regn Reg_4(WriteData, Reset, Reg_Enable[4], Clock,Registers_Read[4]);
RegFile_regn Reg_5(WriteData, Reset, Reg_Enable[5], Clock,Registers_Read[5]);
RegFile_regn Reg_6(WriteData, Reset, Reg_Enable[6], Clock,Registers_Read[6]);
RegFile_regn Reg_7(WriteData, Reset, Reg_Enable[7], Clock,Registers_Read[7]);
RegFile_regn Reg_8(WriteData, Reset, Reg_Enable[8], Clock,Registers_Read[8]);
RegFile_regn Reg_9(WriteData, Reset, Reg_Enable[9], Clock,Registers_Read[9]);

RegFile_regn Reg_10(WriteData, Reset, Reg_Enable[10], Clock,Registers_Read[10]);
RegFile_regn Reg_11(WriteData, Reset, Reg_Enable[11], Clock,Registers_Read[11]);
RegFile_regn Reg_12(WriteData, Reset, Reg_Enable[12], Clock,Registers_Read[12]);
RegFile_regn Reg_13(WriteData, Reset, Reg_Enable[13], Clock,Registers_Read[13]);
RegFile_regn Reg_14(WriteData, Reset, Reg_Enable[14], Clock,Registers_Read[14]);
RegFile_regn Reg_15(WriteData, Reset, Reg_Enable[15], Clock,Registers_Read[15]);
RegFile_regn Reg_16(WriteData, Reset, Reg_Enable[16], Clock,Registers_Read[16]);
RegFile_regn Reg_17(WriteData, Reset, Reg_Enable[17], Clock,Registers_Read[17]);
RegFile_regn Reg_18(WriteData, Reset, Reg_Enable[18], Clock,Registers_Read[18]);
RegFile_regn Reg_19(WriteData, Reset, Reg_Enable[19], Clock,Registers_Read[19]);

RegFile_regn Reg_20(WriteData, Reset, Reg_Enable[20], Clock,Registers_Read[20]);
RegFile_regn Reg_21(WriteData, Reset, Reg_Enable[21], Clock,Registers_Read[21]);
RegFile_regn Reg_22(WriteData, Reset, Reg_Enable[22], Clock,Registers_Read[22]);
RegFile_regn Reg_23(WriteData, Reset, Reg_Enable[23], Clock,Registers_Read[23]);
RegFile_regn Reg_24(WriteData, Reset, Reg_Enable[24], Clock,Registers_Read[24]);
RegFile_regn Reg_25(WriteData, Reset, Reg_Enable[25], Clock,Registers_Read[25]);
RegFile_regn Reg_26(WriteData, Reset, Reg_Enable[26], Clock,Registers_Read[26]);
RegFile_regn Reg_27(WriteData, Reset, Reg_Enable[27], Clock,Registers_Read[27]);
RegFile_regn Reg_28(WriteData, Reset, Reg_Enable[28], Clock,Registers_Read[28]);
RegFile_regn Reg_29(WriteData, Reset, Reg_Enable[29], Clock,Registers_Read[29]);
RegFile_regn Reg_30(WriteData, Reset, Reg_Enable[30], Clock,Registers_Read[30]);
RegFile_regn Reg_31(WriteData, Reset, Reg_Enable[31], Clock,Registers_Read[31]);



        	   
// Read from Register file 

// MUX1: Read first operand
//always @(posedge Clock) begin

assign ReadData1= Registers_Read[ReadReg1];

//end
// MUX2: Read second operand

assign ReadData2= Registers_Read[ReadReg2];



endmodule










///////////////*******************Register File Modules *******************************************////////////

//******************************** 1 - decoder 5 --> 32 bit*****************************************/////////// 

module RegFile_decoder(inputs,enable,outputs);
   input [4:0] inputs;
	input enable;
   output [31:0] outputs;

   reg [31:0] decoder_output;

always @ (*) begin
		
       if (enable == 1'b1) begin
        case (inputs)
            5'b00000: decoder_output = 32'b00000000000000000000000000000001;
            5'b00001: decoder_output = 32'b00000000000000000000000000000010;
            5'b00010: decoder_output = 32'b00000000000000000000000000000100;
            5'b00011: decoder_output = 32'b00000000000000000000000000001000;
            5'b00100: decoder_output = 32'b00000000000000000000000000010000;
            5'b00101: decoder_output = 32'b00000000000000000000000000100000;
            5'b00110: decoder_output = 32'b00000000000000000000000001000000;
            5'b00111: decoder_output = 32'b00000000000000000000000010000000;
            5'b01000: decoder_output = 32'b00000000000000000000000100000000;
            5'b01001: decoder_output = 32'b00000000000000000000001000000000;
            5'b01010: decoder_output = 32'b00000000000000000000010000000000;
            5'b01011: decoder_output = 32'b00000000000000000000100000000000;
            5'b01100: decoder_output = 32'b00000000000000000001000000000000;
            5'b01101: decoder_output = 32'b00000000000000000010000000000000;
            5'b01110: decoder_output = 32'b00000000000000000100000000000000;
            5'b01111: decoder_output = 32'b00000000000000001000000000000000;
            5'b10000: decoder_output = 32'b00000000000000010000000000000000;
            5'b10001: decoder_output = 32'b00000000000000100000000000000000;
            5'b10010: decoder_output = 32'b00000000000001000000000000000000;
            5'b10011: decoder_output = 32'b00000000000010000000000000000000;
            5'b10100: decoder_output = 32'b00000000000100000000000000000000;
            5'b10101: decoder_output = 32'b00000000001000000000000000000000;
            5'b10110: decoder_output = 32'b00000000010000000000000000000000;
            5'b10111: decoder_output = 32'b00000000100000000000000000000000;
            5'b11000: decoder_output = 32'b00000001000000000000000000000000;
            5'b11001: decoder_output = 32'b00000010000000000000000000000000;
            5'b11010: decoder_output = 32'b00000100000000000000000000000000;
            5'b11011: decoder_output = 32'b00001000000000000000000000000000;
            5'b11100: decoder_output = 32'b00010000000000000000000000000000;
            5'b11101: decoder_output = 32'b00100000000000000000000000000000;
            5'b11110: decoder_output = 32'b01000000000000000000000000000000;
            5'b11111: decoder_output = 32'b10000000000000000000000000000000;
            default: decoder_output = 32'b00000000000000000000000000000000;
        endcase
    end
    else begin
        decoder_output = 32'b00000000000000000000000000000000;
    end
end

assign outputs = decoder_output;

endmodule



/////***************************************** 3 - register 32-bit *************************************//////

// don't forget to change the parameter when you do not 32 bit  register 
module RegFile_regn(R, Resetn, Rin, Clock, Q);
    parameter n = 32;
    input [n-1:0] R;
    input Resetn, Rin, Clock;
    output [n-1:0] Q;
    reg [n-1:0] Q;

    always @(posedge Clock)
        if (Resetn)
            Q <= 0;
        else if (Rin)
            Q <= R;
endmodule


//******************************************** ALU Control *******************************************************************
module alu_control(
input clk,
input [5:0] FuncField,
input [1:0] ALUOp,
output reg [3:0] Operation);



    always @(ALUOp , FuncField) begin
	   if (ALUOp == 2'b00) begin
		Operation = 4'b0000;
		end
		else if(ALUOp == 2'b10) begin
        case (FuncField)
            6'b100000: Operation = 4'b0000;  // add 
            6'b100010: Operation = 4'b0001;  // sub
				6'b011000: Operation = 4'b0010;  //mul
				6'b011010: Operation = 4'b0011;  //div
				6'b000000: Operation = 4'b0100;  //sll
				6'b000010: Operation = 4'b0101;  //srl
				6'b100100: Operation = 4'b1000;  // and
            6'b100101: Operation = 4'b1001;  // or
				6'b100110: Operation = 4'b1010;  //xor
				6'b100111: Operation = 4'b1011;  //nor
            6'b101010: Operation = 4'b1110;  // SLT
            default: Operation <= 4'b0000;   // Default add operation
        endcase
		  
    end
	 
	 else if(ALUOp == 2'b01)begin
		Operation = 4'b1000;  // andi
	 end

	  else if(ALUOp == 2'b11)begin
		Operation = 4'b1001;  // ori
	 end

	 
	 else begin Operation = 4'b1111;
	 end
	 end
endmodule

//********************************************** ALU ******************************************************
module ALU(
	 input	clk,
    input [31:0] A, // 32-bit input A
    input [31:0] B, // 32-bit input B
    input [3:0] ALUControl, // 4-bit ALU control
    input [4:0] ShiftAmount, // 5-bit input for shift amount
    output reg [31:0] ALUOut, // 32-bit output
    output reg Zero // Zero flag
   // output reg Overflow, // Overflow flag
   // output reg CarryOut // Carry-out flag
);
reg Overflow;
reg CarryOut;
//reg [31:0] ALUOut;
/*
addu 
subu

*/
always @(*) begin
    case(ALUControl)
        4'b0000: ALUOut <= A + B; // Addition (signed)
        4'b0001: ALUOut <= A - B; // Subtraction (signed)
        4'b0010: ALUOut <= A * B; // Multiplication (signed)
        4'b0011: ALUOut <= A / B; // Division (signed/unsigned)
        4'b0100: ALUOut <= A << ShiftAmount; // Logical shift left
        4'b0101: ALUOut <= A >> ShiftAmount; // Logical shift right
    //  4'b0110: ALUOut <= {A[30:0], A[31]}; // Rotate left ERROR
    //  4'b0111: ALUOut <= {A[0], A[31:1]}; // Rotate right ERROR
        4'b1000: ALUOut <= A & B; // Logical AND
        4'b1001: ALUOut <= A | B; // Logical OR
        4'b1010: ALUOut <= A ^ B; // Logical XOR
        4'b1011: ALUOut <= ~(A | B); // Logical NOR
   //   4'b1100: ALUOut <= ~(A & B); // Logical NAND ERROR
   //   4'b1101: ALUOut <= ~(A ^ B); // Logical XNOR ERROR
        4'b1110: if(A<B) begin ALUOut <=32'b1 ; end else begin ALUOut <=32'b0; end //ALUOut <= (A > B) ? 32'b1 : 32'b0; => Greater comparison ERROR so convert to slt

   //   4'b1111: ALUOut <= (A == B) ? 32'b1 : 32'b0; // Equal comparison ERROR 


        default: ALUOut <= 32'b0; // Default operation
    endcase
end

always @(*) begin
    if (ALUControl == 4'b0000) begin // Addition (signed)
        Overflow <= (A[31] == B[31] && A[31] != ALUOut[31]);
        CarryOut <= (A[31] & B[31]) | (A[31] & ALUOut[31]) | (B[31] & ALUOut[31]);
    end else if (ALUControl == 4'b0001) begin // Subtraction (signed)
        Overflow <= (A[31] != B[31] && A[31] != ALUOut[31]);
        CarryOut <= (A[31] & B[31]) | (A[31] & ALUOut[31]) | (B[31] & ALUOut[31]);
    end else if (ALUControl == 4'b0010) begin // Multiplication (signed)
        Overflow <= (A[31] == B[31] && A[31] != ALUOut[31]);
        CarryOut <= 1'b0; // No carry-out for multiplication
    end else if (ALUControl == 4'b0011) begin // Division (signed/unsigned)
        Overflow <= (B == 32'b0); // Detect division by zero
        CarryOut <= 1'b0;
    end else begin
        Overflow <= 1'b0;
        CarryOut <= 1'b0;
    end
end


always @* begin
    if (Overflow) begin

        ALUOut = 32'bx; 
end
end


endmodule
/////////////////////////////////////////// Data Memory RAM ///////////////////////////////////////////////////////////////
module RAM #(
  parameter size = 32,
  parameter data_width = 32
 // parameter once=1
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
  reg [31:0] mem [0:31];
  reg error;
 // reg first=once;
  
  
  // Declare a memory array with parameterized size and data width.
 // reg [data_width-1:0] mem [0:size - 1];
  
initial begin
  mem[0] = 32'b00000000000000000000000000000010; // 2
  mem[1] = 32'b00000000000000000000000000000011; // 3
  mem[2] = 32'b00000000000000000000000000001000; // 8
  mem[3] = 32'b00000000000000000000000000001100; // 12
  mem[4] = 32'b00000000000000000000000000000110; // 6
  mem[5] = 32'b00000000000000000000000000010100; // 20
  mem[6] = 32'b00000000000000000000000000011000; // 24
  mem[7] = 32'b00000000000000000000000000011100; // 28
  mem[8] = 32'b00000000000000000000000000100000; // 32
  mem[9] = 32'b00000000000000000000000000100100; // 36
  mem[11] =32'b01111111111111111111111111111111; // big number


end
  
     //    assign data_out = mem[address >> 2];
	  
		//	assign data_out = (reset)?8'h00000000:mem[address >> 2];
			 assign data_out=(read_en)? ((reset)?8'h00000000:mem[address >> 2]):32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  
	integer i;
	
  always @(posedge clk) begin
  
    if (reset) begin

      for (i = 0; i < size; i = i + 1) begin
        mem[i] <= 32'b0;
      end
      error <= 0;
			
		end 
	 
	 else if (write_en) begin
          // Write data 
          mem[address >> 2] <= data_write;
        end

  end

  

  
endmodule


//****************************************************** MUX 2-1************************************************************************
module MUX2_1 (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire select,
    output wire [31:0] out
);
    assign out = (select) ? b : a;
endmodule
///****************************************************** MUX 5 bit **********************************************************************
module MUX5bit (
    input wire [4:0] a,
    input wire [4:0] b,
    input wire select,
    output wire [4:0] out
);
    assign out = (select) ? b : a;
endmodule
///******************************************************* sign extender **********************************************************************
module sign_extend (
    input wire  [15:0] extend,
    output wire [31:0] extended
);

assign    extended[15:0] = extend[15:0];
assign    extended[31:16] = {16{extend[15]}};

endmodule
