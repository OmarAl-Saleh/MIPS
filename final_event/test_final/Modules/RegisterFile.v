module RegisterFile(Clock,Reset,ReadReg1,ReadReg2,WriteReg,WriteData,Reg_write_Control,ReadData1,ReadData2,PC_Store,PUSH_Stack,PULL_Stack);
input Clock , Reset;
input [4:0] ReadReg1 , ReadReg2 , WriteReg;
input Reg_write_Control;
input PUSH_Stack,PULL_Stack,PC_Store;
input [31:0] WriteData;
output [31:0] ReadData1;
output [31:0] ReadData2;

// define bus (wires)
wire [31:0] Reg_Enable , StackData;
wire [31:0] Registers_Read [31:0];


// to get the register enable we want to write on 
RegFile_decoder dex(WriteReg,Reg_write_Control,Reg_Enable);

// we first write then we read from register file 

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

// customize register for hold stack pointer 
Stack_regn Reg_29(StackData, Reset, PUSH_Stack || PULL_Stack , Clock,Registers_Read[29]);



RegFile_regn Reg_30(WriteData, Reset, Reg_Enable[30], Clock,Registers_Read[30]);


// customize register for hold the value of top of stack (Return address Register)
RegFile_regn Reg_31(WriteData, Reset, PC_Store, Clock,Registers_Read[31]);// Return address Register



Stack_Memory MIPS_Stack (PUSH_Stack,PULL_Stack,Registers_Read[29],StackData);
        	   
// Read from Register file 

// MUX1: Read first operand
//always @(posedge Clock) begin

assign ReadData1= Registers_Read[ReadReg1];


//end


// MUX2: Read second operand
// in Stack Instructions we use it to carry the address of SP

assign ReadData2= (PUSH_Stack == 1'b1 || PULL_Stack == 1'b1 )? Registers_Read[29] : Registers_Read[ReadReg2];// the address that will go to RAM in JS or JAL 


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
// we use parameter of  32 bit  register but we can customize it  
module RegFile_regn(R, Resetn, Rin, Clock, Q);
    parameter n = 32;
    input [n-1:0] R;
    input Resetn, Rin, Clock;
    output [n-1:0] Q;
    reg [n-1:0] Q;

    always @(negedge Clock)// we made it negative for pipeline implementation
        if (Resetn)
            Q <= 0;
        else if (Rin)
            Q <= R;
endmodule 


//Customize register for Reg 29
// hold a initial value that is the previous address to first address in stack  

module Stack_regn (R, Resetn, Rin, Clock, Q);
    parameter n = 32;
    input [n-1:0] R;
    input Resetn, Rin, Clock;
    output [n-1:0] Q;
    reg [n-1:0] Q;

   reg state = 1'b0;

always @(negedge Clock) begin

    if (Resetn) begin
        Q <= 0;
		  state=1'b0;
		  
    end else begin
        case (state)
            1'b0: begin
                state <= 1'b1;
                 Q <= 32'h00000054; // first entry -1 
            end
            1'b1: begin
                if (Rin) begin
                    Q <= R;
            end 
            end
            
        endcase
    end
end

endmodule
