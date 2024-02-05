module Main (
input clk,
input reset
//output wire [31:0] ReadData1,
//output wire [31:0] ReadData2,
//output wire [31:0] Writedata
);

// **************************************** Fetch Stage **************************************************************************

 wire Branch_Zero_Signal ; // we will use it in pc load
//PC
 wire [31:0] pc_final;//input
 wire [31:0] pc_out;//output
 wire [31:0] next_pc;//pc+4
 wire [31:0] pc_inc;//4
 assign pc_inc = 32'b00000000000000000000000000000100;
 wire PC_write;//control
 
 PC #(.first_address(0),  .pc_inc(4) )
 pc_inst (
    .clk(clk),
    .reset(reset),
	// .target(next_pc),
	.target(pc_final),
	 .pc_load(PC_write), //second edition come from hazard detection unit
	// .pc_load(1),
    .pc(pc_out)
  );
//end of PC
//------------------------------------

adder add(
	.a(pc_inc),
	.b(pc_out),
	.c(next_pc)
	);
	

	
//------------------------------------
//////********************we can update the Instruction memory and delete all output signals except the inst_out;
//inst_mem
wire[31:0] inst_out;
wire [5:0] opcode;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] shamt;
wire [5:0] funct;
wire [15:0] addrs;
wire [25:0] jump_offset;

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
    .addr(addrs),
	 .jump(jump_offset)
  );
	
// IF_ID_Register	

// Inputs
 // reg clk;
  //reg reset;
 // reg enable;
  //reg [31:0] Instruction_in;
  //reg [31:0] PC_in;
  //reg Branch_Control;

  // Outputs
  wire [31:0] IF_ID_Instruction_out;
  wire [31:0] IF_ID_PC_out;
// to split it from Instruction memory signal  
//wire[31:0] IF_ID_inst_out;
wire [5:0] IF_ID_opcode;
wire [4:0] IF_ID_rs;
wire [4:0] IF_ID_rt;
wire [4:0] IF_ID_rd;
wire [4:0] IF_ID_shamt;
wire [5:0] IF_ID_funct;
wire [15:0] IF_ID_addrs;
wire [25:0] IF_ID_jump_offset;
 wire [1:0] Jump_signal;//Jump_signal[0] really jump signal
wire IF_ID_write ,Branch ; // the enable signal that come from hazard unit and branch signal from control Unit

IF_ID_Register IF_ID_R (
    .clk(clk),
    .reset(reset),
    .enable(~(IF_ID_write)),// I make it negative because the case of first instruction when no instruction is in ID stage 
    .Instruction_in(inst_out), // the output instruction from Instruction Memory
    .PC_in(next_pc),
//    .Branch_Control(Branch_Control), second edition
    .Branch_Control((Branch & Branch_Zero_Signal)|(Jump_signal[0] | Jump_signal[1]) ), // if we catch branch depandancy
      //or we find jump or jump and link instructions or JS --> Jump Register
    .Instruction_out(IF_ID_Instruction_out),
    .PC_out(IF_ID_PC_out),// Maybe I must implement the pc in every register but know I will not do it 
	 .opcode(IF_ID_opcode),
    .rs(IF_ID_rs),
    .rt(IF_ID_rt),
    .rd(IF_ID_rd),
    .shamt(IF_ID_shamt),
    .funct(IF_ID_funct),
    .addr(IF_ID_addrs),// use for calculate the branch target address
	 .jump(IF_ID_jump_offset)
  );
	


//************************************************** Decode Stage **********************************************************************

	
//sign extend
wire [31:0] immediate_value;
wire [31:0] ID_EX_immediate_value;

sign_extend extender (
    .extend(IF_ID_addrs),
    .extended(immediate_value)
);

//end of sign extend	



//------------------------------------
//ControlUnit
  wire ALUSrc, MemWrite, MemRead, RegWrite;
  wire [3:0] ALUOp;
  wire [1:0] RegDst;
  wire [1:0] MemtoReg;

  wire PC_Store;

  // we don't need pc_load and pc_store signal anymore (useless) (clear phase)

ControlUnit control_inst (
    .Clock(clk),
    .Reset(reset),
    .opcode(IF_ID_opcode),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp),
	 .Branch(Branch),
	 .Jump(Jump_signal),
	 .funct(IF_ID_funct),
	 .pc_load(pc_load), // in second edition we must delete it from control unit and put it in hazard unit
	 .PC_Store(PC_Store)// must be cleaned
  );
//end of ControlUnit
//------------------------------------

// Reg_File

    wire [4:0] write_reg_input;
   
    wire [31:0] WB_Writedata; // we use it to hold the data from wb to register file to write it in addition we use it in forwarding Unit
	 wire [4:0] MEM_WB_rd;
    wire MEM_WB_RegWrite; 
	 
	 wire [31:0] ReadData1;
    wire [31:0] ReadData2;
	 
	 wire [1:0] MEM_WB_MemtoReg;// we use it in implementation of JAL Instruction as enable to register 31
	
	
	

	    RegisterFile reg_file_inst (
        .Clock(clk),// we make the the register file write on the negative edge so we can write on a register and read his data in same clock
        .Reset(reset),
        .ReadReg1(IF_ID_rs),
        .ReadReg2(IF_ID_rt),
        .WriteReg(MEM_WB_rd),
        .Reg_write_Control(MEM_WB_RegWrite),// we must take it from WB Stage
        .WriteData(WB_Writedata), 
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
		  //.PC_Store(PC_Store)// we dont use it in this edition(must clean)
		  .PC_Store(MEM_WB_MemtoReg[1]),// to indicate JAL OR JS Instruction in WB Stage to store the Return address that come from RAM 
		  // must update in pull operation
		  .PUSH_Stack(MemtoReg[1] && ~MemtoReg[0]),// to indicate JAL Instruction with Stack
        .PULL_Stack(Jump_signal[1]) // to indicate JS Instruction with Stack
    );
	 
	 
	 wire [31:0] Branch_address;
	 /////////////////////////////////////////second edition/////////////////////////////////////////////////////////////
	 
	 // implement the branch forwarding Unit
	 
	 wire [4:0] EX_MEM_rd,ID_EX_rd; // we need to use the rd in branch forwarding;
	 wire ID_EX_RegWrite , EX_MEM_RegWrite;
	 wire [1:0] Branch_Select_Forward_A ,Branch_Select_Forward_B;
	 wire [31:0] EX_MEM_ALU_Result ;
	 wire [31:0] MEM_WB_RAM_Data;
	  
	 wire [31:0] Final_Branch_ReadData1;
    wire [31:0] Final_Branch_ReadData2;// the output of forwarding MUXES
	 
	  ForwardingUnit Forwarding_Branch (
        .rs1_ID_EX(IF_ID_rs),
        .rs2_ID_EX(IF_ID_rt),
        .rd_EX_MEM(EX_MEM_rd),
        .rd_MEM_WB(MEM_WB_rd),
        .RegWrite_EX_MEM(EX_MEM_RegWrite),
        .RegWrite_MEM_WB(MEM_WB_RegWrite),
        .forwardA(Branch_Select_Forward_A),
        .forwardB(Branch_Select_Forward_B)
    );
	 
MUX4_1 Branch_Forwarding_A_MUX(
.a(ReadData1),
//.b(MEM_WB_RAM_Data),// MEM_WB wrong to put it
.b(WB_Writedata),
.c(EX_MEM_ALU_Result),// EX_MEM
.select(Branch_Select_Forward_A),
.out(Final_Branch_ReadData1)
);

MUX4_1 Branch_Forwarding_B_MUX(
.a(ReadData2),
//.b(MEM_WB_RAM_Data),// I don't know where is he wrong to put it
.b(WB_Writedata), 
.c(EX_MEM_ALU_Result),
.select(Branch_Select_Forward_B),
.out(Final_Branch_ReadData2)
);
	  
	 
	 // implement branch and jump unit with PC MUXES
	 
	 Branch Branch_Unit (
    .Branch_Flag(Branch),
    .ALUOp(ALUOp),
    .Data1(Final_Branch_ReadData1),// There is a  forwarding on this signal
    .Data2(Final_Branch_ReadData2),// There is a  forwarding on this signal
    .Target(IF_ID_addrs),
    .next_pc(IF_ID_PC_out),
    .Branch_address(Branch_address),
    .zero(Branch_Zero_Signal)
  );
  
  
 // JUMP (JS) Forwarding Unit
 
 
 // implement the branch forwarding Unit
	 
	// wire [4:0] EX_MEM_rd,ID_EX_rd; // we need to use the rd in branch forwarding;
	// wire ID_EX_RegWrite , EX_MEM_RegWrite;
	 wire JUMP_Select_Forward_A;
	 //wire [31:0] EX_MEM_ALU_Result ;
	// wire [31:0] MEM_WB_RAM_Data;
	 wire [1:0] EX_MEM_MemtoReg;
	 wire [31:0] Final_JUMP_ReadData;
	 wire [31:0] EX_MEM_PC_out;
   // wire [31:0] Final_Branch_ReadData2;// the output of forwarding MUXES 

 ForwardingUnit_JUMP JUMP_Forwarding (
    .JS_JUMP(Jump_signal),
    .EX_MEM_MemtoReg(EX_MEM_MemtoReg),
    . forwardA(JUMP_Select_Forward_A)
    
);
	 
MUX2_1 JUMP_Forwarding_MUX(
.a(ReadData1),
.b(EX_MEM_PC_out),
.select(JUMP_Select_Forward_A),
.out(Final_JUMP_ReadData)
);	

  
  
  
  
  // Calculate PC Target Address
  wire [31:0] pc_branch , JUMP_Target_address;
  
  



MUX2_1 pc_target(
//.a(IF_ID_PC_out),
.a(next_pc),
.b(Branch_address),
.select((Branch & Branch_Zero_Signal)),
.out(pc_branch)
);	



// implement jump here

JUMP Jump_Unit (
    .JUMP_FLAG(Jump_signal[0]),
    .jump_offset(IF_ID_jump_offset),
   // .next_pc(IF_ID_PC_out),
	 .next_pc(next_pc),
    .JUMP_address(JUMP_Target_address)
  );

MUX4_1 pc_final_main(
.a(pc_branch),
.b(JUMP_Target_address),// I don't know where is he 
.c(Final_JUMP_ReadData),// must be the output from JS Instruction Forwarding MUX
.select(Jump_signal),
.out(pc_final)
);
// end branch and Jump implementation	 

// Hazard dediction Unit 
wire ID_EX_FLUSH , ID_EX_MemRead, EX_MEM_MemRead;

wire [4:0]  ID_EX_rt;
//wire IF_ID_write; we must put it in before the IF_ID Register
Hazard_Unit Hazard_unit (
    .D_rs(IF_ID_rs),
    .D_rt(IF_ID_rt),
    .EX_rt(ID_EX_rt),
    .EX_MemRead(ID_EX_MemRead),
	 .ID_EX_FLUSH(ID_EX_FLUSH), 
	 .IF_ID_write(IF_ID_write),// we use it as enable to IF_ID REG
    .PC_write(PC_write), 
    .ID_Branch(Branch),
    .MEM_rt(EX_MEM_rd),// we must implement it in EX/MEM REG
    .MEM_MemRead(EX_MEM_MemRead)
    
  );
	 
// End of hazard detection Unit


	 
	 ////////////////////////////////////////second edition////////////////////////////////////////////////////////////////

    // ID_EX_Register
	 // Signals
 // reg clk, reset;
  //reg [31:0] In_Reg_File_Data1, In_Reg_File_Data2, In_offset;
  //reg [4:0] In_Rs, In_Rt, In_Rd;
  //reg In_ALUSrc, In_MemWrite, In_MemRead, In_RegWrite;
 // reg [3:0] In_ALUOp;
  //reg [1:0] In_MemtoReg, In_RegDst;
  wire [31:0] ID_EX_Reg_File_Data1, ID_EX_Reg_File_Data2,ID_EX_PC_out;
  wire [4:0] ID_EX_rs;
  wire ID_EX_ALUSrc, ID_EX_MemWrite;
  wire [3:0] ID_EX_ALUOp;
  wire [1:0]ID_EX_MemtoReg, ID_EX_RegDst;
  wire [5:0] ID_EX_func;
  wire [4:0] ID_EX_shamt;

  // Instantiate the module
  ID_EX_Register ID_EX_R (
    .clk(clk),
    //.reset(ID_EX_FLUSH || Jump_signal[0] || Jump_signal[1]),
	 .reset(ID_EX_FLUSH),
    .In_Reg_File_Data1(ReadData1),
    .In_Reg_File_Data2(ReadData2),
    .In_offset(immediate_value),
	 .In_PC(IF_ID_PC_out),
    .In_Rs(IF_ID_rs),
    .In_Rt(IF_ID_rt),
    .In_Rd(IF_ID_rd),
    .In_ALUSrc(ALUSrc),
    .In_MemWrite(MemWrite),
    .In_MemRead(MemRead),
    .In_RegWrite(RegWrite),
    .In_ALUOp(ALUOp),
    .In_MemtoReg(MemtoReg),
    .In_RegDst(RegDst),
	 .In_func(IF_ID_funct),
	 .In_shamt(IF_ID_shamt),
    .Out_Reg_File_Data1(ID_EX_Reg_File_Data1),// may be the address of top of stack to store or load from Memory in JS or JAL Instructions
    .Out_Reg_File_Data2(ID_EX_Reg_File_Data2),
    .Out_offset(ID_EX_immediate_value),
	 .Out_PC(ID_EX_PC_out),
    .Out_Rs(ID_EX_rs),
    .Out_Rt(ID_EX_rt),
    .Out_Rd(ID_EX_rd),
    .Out_ALUSrc(ID_EX_ALUSrc),
    .Out_MemWrite(ID_EX_MemWrite),
    .Out_MemRead(ID_EX_MemRead),
    .Out_RegWrite(ID_EX_RegWrite),
    .Out_ALUOp(ID_EX_ALUOp),
    .Out_MemtoReg(ID_EX_MemtoReg),
    .Out_RegDst(ID_EX_RegDst),
	 .Out_func(ID_EX_func),
	 .Out_shamt(ID_EX_shamt)
  );
	
// End of ID_EX_Register

//************************************************ Execution Stage ********************************************************************

//alu_cntrl

wire [3:0] Operation;
wire [2:0] branch_type;

alu_control alu_ctrl (
	 .clk(clk),
    .FuncField(ID_EX_func),
    .ALUOp(ID_EX_ALUOp),
    .Operation(Operation),
	 .branch_type(branch_type) // will delete it in second edition
);

//end of alu_cntrl

// Determine RD write register 

MUX5bit mux_inst (
        .a(ID_EX_rt),        
        .b(ID_EX_rd),         
        .select(ID_EX_RegDst), // we must take it from EX Stage
        .out(write_reg_input)   
    );

// END of Determine RD Register

// I but in after the forwarding because it was case error 

////------------------------------------
//// MUX2_1 alu_sec_input
//
//wire [31:0] alu_second_input;
// MUX2_1 alu_sec_input (
//        .a(ID_EX_Reg_File_Data2),        
//        .b(ID_EX_immediate_value),         
//        .select(ID_EX_ALUSrc), 
//        .out(alu_second_input)   
//    );
//
////end of MUX2_1 alu_sec_input


/////////////////////////////////// second edition /////////////////////////////

//ALU Forwarding Unit 

	// wire [4:0] EX_MEM_rd; // we need to use the rd in branch forwarding;
	// wire ID_EX_RegWrite , EX_MEM_RegWrite;
	 wire [1:0] ALU_Select_Forward_A ,ALU_Select_Forward_B;
	// wire [31:0] EX_MEM_ALU_Result ;
	// wire [31:0] MEM_WB_RAM_Data;
	  
	 wire [31:0] Final_ALU_ReadData1;
    wire [31:0] Final_ALU_ReadData2;// the output of forwarding MUXES
	 
	  ForwardingUnit Forwarding_ALU (
        .rs1_ID_EX(ID_EX_rs),
        .rs2_ID_EX(ID_EX_rt),
        .rd_EX_MEM(EX_MEM_rd),
        .rd_MEM_WB(MEM_WB_rd),
        .RegWrite_EX_MEM(EX_MEM_RegWrite),
        .RegWrite_MEM_WB(MEM_WB_RegWrite),
        .forwardA(ALU_Select_Forward_A),
        .forwardB(ALU_Select_Forward_B)
    );
	 ///// we are here 
MUX4_1 ALU_Forwarding_A_MUX(
.a(ID_EX_Reg_File_Data1),
//.b(MEM_WB_RAM_Data),// MEM_WB wrong to put it 
.b(WB_Writedata),
.c(EX_MEM_ALU_Result),// EX_MEM
.select(ALU_Select_Forward_A),
.out(Final_ALU_ReadData1)
);

MUX4_1 ALU_Forwarding_B_MUX(
.a(ID_EX_Reg_File_Data2),
//.b(MEM_WB_RAM_Data), wrong to put it
.b(WB_Writedata),
.c(EX_MEM_ALU_Result),
.select(ALU_Select_Forward_B),
.out(Final_ALU_ReadData2)
);

//------------------------------------
// MUX2_1 alu_sec_input

wire [31:0] alu_second_input;
 MUX2_1 alu_sec_input (
        .a(Final_ALU_ReadData2),        
        .b(ID_EX_immediate_value),         
        .select(ID_EX_ALUSrc), 
        .out(alu_second_input)   
    );

//end of MUX2_1 alu_sec_input



////////////////////////////////// second edition /////////////////////////////
//ALU
wire [31:0] alu_output , Address;
wire zero ;

ALU alu (
	 .clk(clk),
    .A(Final_ALU_ReadData1),
    .B(alu_second_input),
    .ALUControl(Operation),
    .ShiftAmount(ID_EX_shamt),
	 .branch_type(branch_type),
    .ALUOut(alu_output),
    .Zero(zero)
);

// Determin the Final address From ALU or From Register file (Stack)
MUX2_1 Address_MUX (
        .a(alu_output),        
       // .b(Final_ALU_ReadData1),
        .b(ID_EX_Reg_File_Data2),		 
        .select(ID_EX_MemtoReg[1]), // we want the second choice(ReadData1) in stack operations JAL --> Store or JS---->Load
        .out(Address)   
    );


//end of ALU
//------------------------------------
// EX_MEM_Register

// Signals
  //reg clk;
 // reg [31:0] In_Address, In_Write_Data;
 // reg [4:0] In_Rd;
  //reg In_MemWrite, In_MemRead, In_RegWrite;
 // reg [1:0] In_MemtoReg;
  //wire [31:0] EX_MEM_Write_Data,EX_MEM_PC_out;
  wire [31:0] EX_MEM_Write_Data;
  //wire [4:0] EX_MEM_rd;
  wire EX_MEM_MemWrite;
 // wire [1:0] EX_MEM_MemtoReg;
//ID_EX_PC_out
  // Instantiate the module
  EX_MEM_Register EX_MEM_R (
    .clk(clk),
    //.In_Address(alu_output), for stack implementation
	 .In_Address(Address),
    .In_Write_Data(Final_ALU_ReadData2),
	 .In_PC(ID_EX_PC_out),
    .In_Rd(write_reg_input),
	 
    .In_MemWrite(ID_EX_MemWrite),
    .In_MemRead(ID_EX_MemRead),
    .In_RegWrite(ID_EX_RegWrite),
    .In_MemtoReg(ID_EX_MemtoReg),
    .Out_Address(EX_MEM_ALU_Result),
    .Out_Write_Data(EX_MEM_Write_Data),
	 .Out_PC(EX_MEM_PC_out),
    .Out_Rd(EX_MEM_rd),
    .Out_MemWrite(EX_MEM_MemWrite),
    .Out_MemRead(EX_MEM_MemRead),
    .Out_RegWrite(EX_MEM_RegWrite),
    .Out_MemtoReg(EX_MEM_MemtoReg)
  );



// End of EX_MEM_Register
//------------------------------------

//************************************************ Memory Stage ***********************************************************************

wire [31:0] Final_Data;
// Determin the Final Data From Normal operations or From PC (Stack)
MUX2_1 RAM_Data_MUX (
        .a(EX_MEM_Write_Data),        
        .b(EX_MEM_PC_out),         
        .select(EX_MEM_MemtoReg[1]), // we want the second choice(ReadData1) in stack operations JAL --> Store or JS---->Load
        .out(Final_Data)   
    );


// DATA MAM
wire [31:0] Read_data;

RAM #(
    .size(32),             
    .data_width(32)

) ram (
    .clk(clk),// I think we must edit it maybe we do it like register file  
    .reset(reset),
    .address(EX_MEM_ALU_Result),
    .data_write(Final_Data),
    .write_en(EX_MEM_MemWrite),
    .read_en(EX_MEM_MemRead),
    .data_out(Read_data)

    
);
//end of DATA_MEM
//------------------------------------

//MEM_WB_Register

// Signals
 // reg clk;
  //reg [31:0] In_RAM_Data, In_Immediate_Data;
  //reg [4:0] In_Rd;
  //reg In_RegWrite;
  //reg [1:0] In_MemtoReg;
  wire [31:0] MEM_WB_ALU_Data,MEM_WB_PC_out;
 // wire [4:0] MEM_WB_rd; we must declare it before register file 
  //wire MEM_WB_RegWrite; 


  // Instantiate the module
  MEM_WB_Register MEM_WB_R (
    .clk(clk),
    .In_RAM_Data(Read_data),
    .In_Immediate_Data(EX_MEM_ALU_Result),
	 .In_PC(EX_MEM_PC_out),
    .In_Rd(EX_MEM_rd),
    .In_RegWrite(EX_MEM_RegWrite),
    .In_MemtoReg(EX_MEM_MemtoReg),
    .Out_RAM_Data(MEM_WB_RAM_Data),
    .Out_Immediate_Data(MEM_WB_ALU_Data),
	 .Out_PC(MEM_WB_PC_out),
    .Out_Rd(MEM_WB_rd),
    .Out_RegWrite(MEM_WB_RegWrite),
    .Out_MemtoReg(MEM_WB_MemtoReg)
  );


// End of MEM_WB_Register

//**************************************************** Write Back Stage ************************************************************************


//Write back
WB_MUX4_1 Write_back (
        .a(MEM_WB_ALU_Data),        
        .b(MEM_WB_RAM_Data),
		  //.c(next_pc), second edition move to id stage 
		  .c(MEM_WB_PC_out),// we will implement it in ID Stage so we need update the mem to reg control unit and invent a new signal for it 
		  .d(MEM_WB_RAM_Data),// for JS instruction to write the previous subroutine on REG 31
        .select(MEM_WB_MemtoReg), 
        .out(WB_Writedata)   
    );
	 
//------------------------------------











//********************************************** will be Adding in second edition ******************************************************

// ********** IF Stage ***************//


//**********ID stage *****************//
//------------------------------------
//handling jump instruction


//	
//	adder add(
//	.a(pc_inc),
//	.b(pc_out),
//	.c(next_pc)
//	);
//	
//	wire [31:0] jump_target;
//assign jump_target = {next_pc[31:28], jump_offset, 2'b00};
////---------------------------------
//	//branch
//	wire [31:0] branch;
//	
//	branch_control branch_main(
//	.extended_address(immediate_value),
//	.next_pc(next_pc),
//	.branch(branch)
//	);
//	
////--------------------------------
//wire [31:0] pc_branch;
//
//
//MUX2_1 pc_target(
//.a(next_pc),
//.b(branch),
//.select((Branch & zero)),
//.out(pc_branch)
//);	
//
//MUX4_1 pc_final_main(
//.a(pc_branch),
//.b(jump_target),
//.c(ReadData1),
//.select(Jump_signal),
//.out(pc_final)
//);

// Branch Unit

//*************************************** Modules to update ***********************************************
// alu control 
// Control Unit (for JAL we will not store the pc value in write back anymore we will do it in Decode stage )
	 
endmodule 