module FBGA(
  input clk,
  input en,
  input [4:0] mux32,
  input selector,
  input reset,
  output reg [6:0] digit_1,
  output reg [6:0] digit_2,
  output reg [6:0] digit_3,
  output reg [6:0] digit_4,
  output reg [6:0] digit_5,
  output reg [6:0] digit_6

);
reg [31:0] show_reg;
wire [31:0] All_Registers [0:31];


  Main m_dut(
		  .clk(clk),
		  .reset(1'b0),
		  .reg0(All_Registers[0]),
		  .reg1(All_Registers[1]),
		  .reg2(All_Registers[2]),
		  .reg3(All_Registers[3]),
		  .reg4(All_Registers[4]),
		  .reg5(All_Registers[5]),
		  .reg6(All_Registers[6]),
		  .reg7(All_Registers[7]),
		  .reg8(All_Registers[8]),
		  .reg9(All_Registers[9]),
		  .reg10(All_Registers[10]),
		  .reg11(All_Registers[11]),
		  .reg12(All_Registers[12]),
		  .reg13(All_Registers[13]),
		  .reg14(All_Registers[14]),
		  .reg15(All_Registers[15]),
		  .reg16(All_Registers[16]),
		  .reg17(All_Registers[17]),
		  .reg18(All_Registers[18]),
		  .reg19(All_Registers[19]),
		  .reg20(All_Registers[20]),
		  .reg21(All_Registers[21]),
		  .reg22(All_Registers[22]),
		  .reg23(All_Registers[23]),
		  .reg24(All_Registers[24]),
		  .reg25(All_Registers[25]),
		  .reg26(All_Registers[26]),
		  .reg27(All_Registers[27]),
		  .reg28(All_Registers[28]),
		  .reg29(All_Registers[29]),
		  .reg30(All_Registers[30]),
		  .reg31(All_Registers[31])
	);
	
	
//*****************************************************************************
	reg [39:0] counter; // Counter to control the delay
//	reg [39:0] counter2;
initial counter = 0;
//initial counter2= 0;
always @(posedge clk) begin
    if (~en) begin
	     counter <= counter + 1;
        if (counter < 100000000) begin
            // First sentence
            digit_6 <= 7'b1100001;
            digit_5 <= 7'b1000001;
            digit_4 <= 7'b0010010;
            digit_3 <= 7'b0000111;
        end else if (counter >= 100000000 && counter < 200000000) begin
    // Second sentence after 1 second delay
    digit_6 <= 7'b1000110;
    digit_5 <= 7'b0001100;
    digit_4 <= 7'b1000001;
    digit_3 <= 7'b1111111;
end else if (counter >= 200000000 && counter < 300000000) begin
    // Third sentence after another 1 second delay
    digit_6 <= 7'b0000011;
    digit_5 <= 7'b0101111;
    digit_4 <= 7'b0100011;
    digit_3 <= 7'b1111111;
end

		  else begin
		  counter <= 40'h0;
		  end
    end
    else begin
	 
	 
	  case(mux32) 
	 5'b00000:begin show_reg <= All_Registers[0]; digit_5 <= 7'b1000000;digit_6 <= 7'b1000000; end
	 5'b00001:begin show_reg <= All_Registers[1]; digit_5 <= 7'b1111001;digit_6 <= 7'b1000000; end
	 5'b00010:begin show_reg <= All_Registers[2]; digit_5 <= 7'b0100100;digit_6 <= 7'b1000000; end
	 5'b00011:begin show_reg <= All_Registers[3]; digit_5 <= 7'b0110000;digit_6 <= 7'b1000000; end
	 5'b00100:begin show_reg <= All_Registers[4]; digit_5 <= 7'b0011001;digit_6 <= 7'b1000000; end
	 5'b00101:begin show_reg <= All_Registers[5] ;digit_5 <= 7'b0010010;digit_6 <= 7'b1000000; end
	 5'b00110:begin show_reg <= All_Registers[6] ;digit_5 <= 7'b0000010;digit_6 <= 7'b1000000; end
	 5'b00111:begin show_reg <= All_Registers[7] ;digit_5 <= 7'b1111000;digit_6 <= 7'b1000000; end
	 5'b01000:begin show_reg <= All_Registers[8] ;digit_5 <= 7'b0000000;digit_6 <= 7'b1000000; end
	 5'b01001:begin show_reg <= All_Registers[9] ;digit_5 <= 7'b0011000;digit_6 <= 7'b1000000; end
	 5'b01010:begin show_reg <= All_Registers[10] ;digit_5 <= 7'b1000000;digit_6 <= 7'b1111001; end
	 5'b01011:begin show_reg <= All_Registers[11] ;digit_5 <= 7'b1111001;digit_6 <= 7'b1111001; end
	 5'b01100:begin show_reg <= All_Registers[12] ;digit_5 <= 7'b0100100;digit_6 <= 7'b1111001; end
	 5'b01101:begin show_reg <= All_Registers[13] ;digit_5 <= 7'b0110000;digit_6 <= 7'b1111001; end
	 5'b01110:begin show_reg <= All_Registers[14] ;digit_5 <= 7'b0011001;digit_6 <= 7'b1111001; end
	 5'b01111:begin show_reg <= All_Registers[15] ;digit_5 <= 7'b0010010;digit_6 <= 7'b1111001; end
	 5'b10000:begin show_reg <= All_Registers[16] ;digit_5 <= 7'b0000010;digit_6 <= 7'b1111001; end
	 5'b10001:begin show_reg <= All_Registers[17] ;digit_5 <= 7'b1111000;digit_6 <= 7'b1111001; end
	 5'b10010:begin show_reg <= All_Registers[18] ;digit_5 <= 7'b0000000;digit_6 <= 7'b1111001; end
	 5'b10011:begin show_reg <= All_Registers[19] ;digit_5 <= 7'b0011000;digit_6 <= 7'b1111001; end
	 5'b10100:begin show_reg <= All_Registers[20] ;digit_5 <= 7'b1000000;digit_6 <= 7'b0100100; end
	 5'b10101:begin show_reg <= All_Registers[21] ;digit_5 <= 7'b1111001;digit_6 <= 7'b0100100; end
	 5'b10110:begin show_reg <= All_Registers[22] ;digit_5 <= 7'b0100100;digit_6 <= 7'b0100100; end
	 5'b10111:begin show_reg <= All_Registers[23] ;digit_5 <= 7'b0110000;digit_6 <= 7'b0100100; end
	 5'b11000:begin show_reg <= All_Registers[24] ;digit_5 <= 7'b0011001;digit_6 <= 7'b0100100; end
	 5'b11001:begin show_reg <= All_Registers[25] ;digit_5 <= 7'b0010010;digit_6 <= 7'b0100100; end
	 5'b11010:begin show_reg <= All_Registers[26] ;digit_5 <= 7'b0000010;digit_6 <= 7'b0100100; end
	 5'b11011:begin show_reg <= All_Registers[27] ;digit_5 <= 7'b1111000;digit_6 <= 7'b0100100; end
	 5'b11100:begin show_reg <= All_Registers[28] ;digit_5 <= 7'b0000000;digit_6 <= 7'b0100100; end
	 5'b11101:begin show_reg <= All_Registers[29] ;digit_5 <= 7'b0011000;digit_6 <= 7'b0100100; end
	 5'b11110:begin show_reg <= All_Registers[30] ;digit_5 <= 7'b1000000;digit_6 <= 7'b0110000; end
	 5'b11111:begin show_reg <= All_Registers[31] ;digit_5 <= 7'b1111001;digit_6 <= 7'b0110000; end
	 
	 endcase
	 
	 
//	 show_reg<=32'h0000000B;
		if(~selector) begin
    case (show_reg[3:0])
        4'b0000: digit_1 <= 7'b1000000; // 0
        4'b0001: digit_1 <= 7'b1111001; // 1
        4'b0010: digit_1 <= 7'b0100100; // 2
        4'b0011: digit_1 <= 7'b0110000; // 3
		  4'b0100: digit_1 <= 7'b0011001; // 4
        4'b0101: digit_1 <= 7'b0010010; // 5
		  4'b0110: digit_1 <= 7'b0000010; // 6
        4'b0111: digit_1 <= 7'b1111000; // 7
		  4'b1000: digit_1 <= 7'b0000000; // 8
        4'b1001: digit_1 <= 7'b0011000; // 9
		  4'b1010: digit_1 <= 7'b0001000; // A
        4'b1011: digit_1 <= 7'b0000011; // B
		  4'b1100: digit_1 <= 7'b1000110; // C
        4'b1101: digit_1 <= 7'b0100001; // D
		  4'b1110: digit_1 <= 7'b0000110; // E
        4'b1111: digit_1 <= 7'b0001110; // F
		  default: digit_1 <= 7'b0000100; // error: e
    endcase
		 //****************
		case (show_reg[7:4])
        4'b0000: digit_2 <= 7'b1000000; // 0
        4'b0001: digit_2 <= 7'b1111001; // 1
        4'b0010: digit_2 <= 7'b0100100; // 2
        4'b0011: digit_2 <= 7'b0110000; // 3
		  4'b0100: digit_2 <= 7'b0011001; // 4
        4'b0101: digit_2 <= 7'b0010010; // 5
		  4'b0110: digit_2 <= 7'b0000010; // 6
        4'b0111: digit_2 <= 7'b1111000; // 7
		  4'b1000: digit_2 <= 7'b0000000; // 8
        4'b1001: digit_2 <= 7'b0011000; // 9
		  4'b1010: digit_2 <= 7'b0001000; // A
        4'b1011: digit_2 <= 7'b0000011; // B
		  4'b1100: digit_2 <= 7'b1000110; // C
        4'b1101: digit_2 <= 7'b0100001; // D
		  4'b1110: digit_2 <= 7'b0000110; // E
        4'b1111: digit_2 <= 7'b0001110; // F
		  default: digit_2 <= 7'b0000100; // Default: Display e
    endcase 
		 
		 case (show_reg[11:8])
        4'b0000: digit_3 <= 7'b1000000; // 0
        4'b0001: digit_3 <= 7'b1111001; // 1
        4'b0010: digit_3 <= 7'b0100100; // 2
        4'b0011: digit_3 <= 7'b0110000; // 3
		  4'b0100: digit_3 <= 7'b0011001; // 4
        4'b0101: digit_3 <= 7'b0010010; // 5
		  4'b0110: digit_3 <= 7'b0000010; // 6
        4'b0111: digit_3 <= 7'b1111000; // 7
		  4'b1000: digit_3 <= 7'b0000000; // 8
        4'b1001: digit_3 <= 7'b0011000; // 9
		  4'b1010: digit_3 <= 7'b0001000; // A
        4'b1011: digit_3 <= 7'b0000011; // B
		  4'b1100: digit_3 <= 7'b1000110; // C
        4'b1101: digit_3 <= 7'b0100001; // D
		  4'b1110: digit_3 <= 7'b0000110; // E
        4'b1111: digit_3 <= 7'b0001110; // F
		  default: digit_3 <= 7'b0000100; // Default: Display e
    endcase
	 
	 case (show_reg[15:12])
        4'b0000: digit_4 <= 7'b1000000; // 0
        4'b0001: digit_4 <= 7'b1111001; // 1
        4'b0010: digit_4 <= 7'b0100100; // 2
        4'b0011: digit_4 <= 7'b0110000; // 3
		  4'b0100: digit_4 <= 7'b0011001; // 4
        4'b0101: digit_4 <= 7'b0010010; // 5
		  4'b0110: digit_4 <= 7'b0000010; // 6
        4'b0111: digit_4 <= 7'b1111000; // 7
		  4'b1000: digit_4 <= 7'b0000000; // 8
        4'b1001: digit_4 <= 7'b0011000; // 9
		  4'b1010: digit_4 <= 7'b0001000; // A
        4'b1011: digit_4 <= 7'b0000011; // B
		  4'b1100: digit_4 <= 7'b1000110; // C
        4'b1101: digit_4 <= 7'b0100001; // D
		  4'b1110: digit_4 <= 7'b0000110; // E
        4'b1111: digit_4 <= 7'b0001110; // F
		  default: digit_4 <= 7'b0000100; // Default: Display e
    endcase 
	 end
	 
	 else begin
	     case (show_reg[19:16])
		  4'bxxxx: digit_1 <= 7'b0000100;
        4'b0000: digit_1 <= 7'b1000000;  // 0
        4'b0001: digit_1 <= 7'b1111001;  // 1
        4'b0010: digit_1 <= 7'b0100100;  // 2
        4'b0011: digit_1 <= 7'b0110000; // 3
		  4'b0100: digit_1 <= 7'b0011001; // 4
        4'b0101: digit_1 <= 7'b0010010; // 5
		  4'b0110: digit_1 <= 7'b0000010; // 6
        4'b0111: digit_1 <= 7'b1111000; // 7
		  4'b1000: digit_1 <= 7'b0000000; // 8
        4'b1001: digit_1 <= 7'b0011000; // 9
		  4'b1010: digit_1 <= 7'b0001000; // A
        4'b1011: digit_1 <= 7'b0000011; // B
		  4'b1100: digit_1 <= 7'b1000110; // C
        4'b1101: digit_1 <= 7'b0100001; // D
		  4'b1110: digit_1 <= 7'b0000110; // E
        4'b1111: digit_1 <= 7'b0001110; // F
		  
		  default: digit_1 <= 7'b0000100; // Default: Display e
    endcase
	 

		 //****************
		case (show_reg[23:20])
		  4'bxxxx: digit_2 <= 7'b0000100;
        4'b0000: digit_2 <= 7'b1000000; // 0
        4'b0001: digit_2 <= 7'b1111001; // 1
        4'b0010: digit_2 <= 7'b0100100; // 2
        4'b0011: digit_2 <= 7'b0110000; // 3
		  4'b0100: digit_2 <= 7'b0011001; // 4
        4'b0101: digit_2 <= 7'b0010010; // 5
		  4'b0110: digit_2 <= 7'b0000010; // 6
        4'b0111: digit_2 <= 7'b1111000; // 7
		  4'b1000: digit_2 <= 7'b0000000; // 8
        4'b1001: digit_2 <= 7'b0011000; // 9
		  4'b1010: digit_2 <= 7'b0001000; // A
        4'b1011: digit_2 <= 7'b0000011; // B
		  4'b1100: digit_2 <= 7'b1000110; // C
        4'b1101: digit_2 <= 7'b0100001; // D
		  4'b1110: digit_2 <= 7'b0000110; // E
        4'b1111: digit_2 <= 7'b0001110; // F
		  4'bxxxx: digit_2 <= 7'b0000100;
		  default: digit_2 <= 7'b0000100; // Default: Display e
    endcase 
		 
		 case (show_reg[27:24])
	     4'bxxxx: digit_3 <= 7'b0000100;
        4'b0000: digit_3 <= 7'b1000000; // 0
        4'b0001: digit_3 <= 7'b1111001; // 1
        4'b0010: digit_3 <= 7'b0100100; // 2
        4'b0011: digit_3 <= 7'b0110000; // 3
		  4'b0100: digit_3 <= 7'b0011001; // 4
        4'b0101: digit_3 <= 7'b0010010; // 5
		  4'b0110: digit_3 <= 7'b0000010; // 6
        4'b0111: digit_3 <= 7'b1111000; // 7
		  4'b1000: digit_3 <= 7'b0000000; // 8
        4'b1001: digit_3 <= 7'b0011000; // 9
		  4'b1010: digit_3 <= 7'b0001000; // A
        4'b1011: digit_3 <= 7'b0000011; // B
		  4'b1100: digit_3 <= 7'b1000110; // C
        4'b1101: digit_3 <= 7'b0100001; // D
		  4'b1110: digit_3 <= 7'b0000110; // E
        4'b1111: digit_3 <= 7'b0001110; // F
		  4'bxxxx: digit_3 <= 7'b0000100;
		  default: digit_3 <= 7'b0000100; // Default: Display e
    endcase
	 
	 case (show_reg[31:28])
        4'bxxxx: digit_4 <= 7'b0000100;
		  4'b0000: digit_4 <= 7'b1000000; // 0000
        4'b0001: digit_4 <= 7'b1111001; // 1
        4'b0010: digit_4 <= 7'b0100100; // 2
        4'b0011: digit_4 <= 7'b0110000; // 3
		  4'b0100: digit_4 <= 7'b0011001; // 4
        4'b0101: digit_4 <= 7'b0010010; // 5
		  4'b0110: digit_4 <= 7'b0000010; // 6
        4'b0111: digit_4 <= 7'b1111000; // 7
		  4'b1000: digit_4 <= 7'b0000000; // 8
        4'b1001: digit_4 <= 7'b0011000; // 9
		  4'b1010: digit_4 <= 7'b0001000; // A
        4'b1011: digit_4 <= 7'b0000011; // B
		  4'b1100: digit_4 <= 7'b1000110; // C
        4'b1101: digit_4 <= 7'b0100001; // D
		  4'b1110: digit_4 <= 7'b0000110; // E
        4'b1111: digit_4 <= 7'b0001110; // F
		  4'bxxxx: digit_4 <= 7'b0000100;
		  default: digit_4 <= 7'b0000100; // Default: Display e
    endcase 
	 end

	 
	 
	 
	 end
 


end


//***************************************************************

   
endmodule
/*
		  7'b1000000; // 0
        7'b1111001; // 1
        7'b0100100; // 2
        7'b0110000; // 3
        7'b0011001; // 4
        7'b0010010; // 5
        7'b0000010; // 6
        7'b1111000; // 7
        7'b0000000; // 8
		  7;b0011000; // 9
		  7'b0001000; // A
		  7;b0000011; // b
		  7'b1000110; // C
		  7'b0100001; // d
		  7'b0000110; // E
		  7'b0001110; // F
		  
		  
//STILL HAVE THE RAM/ROM IMPLEMENTATION !!
*/
