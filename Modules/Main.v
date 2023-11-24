module Main (
input clk,
input reset,
output wire [31:0] ReadData1,
output wire [31:0] ReadData2,
output wire [31:0] Writedata
);

//PC
 wire [31:0] pc_final;//input
 wire [31:0] pc_out;//output
 wire [31:0] next_pc;//pc+4
 wire [31:0] pc_inc;//4
 assign pc_inc = 32'b00000000000000000000000000000100;
 wire pc_load;//control
 
 PC #(.first_address(0),  .pc_inc(4) )
 pc_inst (
    .clk(clk),
    .reset(reset),
	 .target(pc_final),
	 .pc_load(pc_load),
//	 .branch_condition(Branch&zero),
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
//end of inst_mem
//------------------------------------
//sign extend

wire [31:0] immediate_value;

sign_extend extender (
    .extend(addrs),
    .extended(immediate_value)
);

//end of sign extend

	
	
//------------------------------------
//ControlUnit
  wire ALUSrc, MemWrite, MemRead, RegWrite,Branch;
  wire [3:0] ALUOp;
  wire [1:0] RegDst;
  wire [1:0] MemtoReg;
  wire [1:0] Jump_signal;


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
    .ALUOp(ALUOp),
	 .Branch(Branch),
	 .Jump(Jump_signal),
	 .funct(funct),
	 .pc_load(pc_load)
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
wire [2:0] branch_type;
alu_control alu_ctrl (
	 .clk(clk),
    .FuncField(funct),
    .ALUOp(ALUOp),
    .Operation(Operation),
	 .branch_type(branch_type)
);

//end of alu_cntrl

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
	 .branch_type(branch_type),
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
MUX4_1 Write_back (
        .a(alu_output),        
        .b(Read_data), 
		  .c(next_pc),
        .select(MemtoReg), 
        .out(Writedata)   
    );
	 
//------------------------------------
//handling jump instruction


	
	adder add(
	.a(pc_inc),
	.b(pc_out),
	.c(next_pc)
	);
	
	wire [31:0] jump_target;
assign jump_target = {next_pc[31:28], jump_offset, 2'b00};
//---------------------------------
	//branch
	wire [31:0] branch;
	
	branch_control branch_main(
	.extended_address(immediate_value),
	.next_pc(next_pc),
	.branch(branch)
	);
	
//--------------------------------
wire [31:0] pc_branch;


MUX2_1 pc_target(
.a(next_pc),
.b(branch),
.select((Branch & zero)),
.out(pc_branch)
);	

MUX4_1 pc_final_main(
.a(pc_branch),
.b(jump_target),
.c(ReadData1),
.select(Jump_signal),
.out(pc_final)
);
	 
endmodule 