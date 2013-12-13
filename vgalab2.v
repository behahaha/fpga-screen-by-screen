module vgalab2(
//	Clock Input
  input CLOCK_50,	//	50 MHz
  input CLOCK_27,     //      27 MHz
//	Push Button
  input [0:0] KEY,      //	Pushbutton[3:0]
//	DPDT Switch
  input [17:0] SW,		//	Toggle Switch[17:0]
//	7-SEG Display
  output [6:0]	HEX0,HEX1,//HEX3, //HEX2, HEX4,HEX5,HEX6,HEX7,  // Seven Segment Digits
//	LED
  //output [8:0]	LEDG,  //	LED Green[8:0]
 // output [17:0] LEDR,  //	LED Red[17:0]
//	GPIO
 inout [35:0] GPIO_0,GPIO_1,	//	GPIO Connections
//	TV Decoder
//TD_DATA,    	//	TV Decoder Data bus 8 bits
//TD_HS,		//	TV Decoder H_SYNC
//TD_VS,		//	TV Decoder V_SYNC
  output TD_RESET,	//	TV Decoder Reset
// VGA
  output VGA_CLK,   						//	VGA Clock
  output VGA_HS,							//	VGA H_SYNC
  output VGA_VS,							//	VGA V_SYNC
  output VGA_BLANK,						//	VGA BLANK
  output VGA_SYNC,						//	VGA SYNC
  output [9:0] VGA_R,   						//	VGA Red[9:0]
  output [9:0] VGA_G,	 						//	VGA Green[9:0]
  output [9:0] VGA_B,   						//	VGA Blue[9:0]

  inout PS2_CLK,
inout PS2_DAT,
	//importing and exporting player locations 
  input [9:0] importX,
  input [9:0] importY,
  output [9:0] sendxpos, 
  output[9:0] sendypos,
	output reg [6:0]ssOut
);

//	All inout port turn to tri-state
assign	GPIO_0		=	36'hzzzzzzzzz;
assign	GPIO_1		=	36'hzzzzzzzzz;

//wire RST;
//assign RST = KEY[0];

// reset delay gives some time for peripherals to initialize
wire DLY_RST;
Reset_Delay r0(	.iCLK(CLOCK_50),.oRESET(DLY_RST) );
/*
// Send switches to red leds 
assign LEDR = SW;

// Turn off green leds
assign LEDG = 8'h00;

wire [6:0] blank = 7'b111_1111;

// blank unused 7-segment digits



//colors 
*/
wire		VGA_CTRL_CLK;
wire		AUD_CTRL_CLK;
wire [9:0]	mVGA_R;
wire [9:0]	mVGA_G;
wire [9:0]	mVGA_B;
wire [9:0]	mCoord_X;
wire [9:0]	mCoord_Y;

assign	TD_RESET = 1'b1; // Enable 27 MHz

//magic, don't touch 
VGA_Audio_PLL 	p1 (	
	.areset(~DLY_RST),
	.inclk0(CLOCK_27),
	.c0(VGA_CTRL_CLK),
	.c1(AUD_CTRL_CLK),
	.c2(VGA_CLK)
);
//
//pixel vaild location 
textbox u3(
	.last_data_received(last_data_received[7:0]),
	.inX(importX),
	.inY(importY),
	.key1(SW[0]),
	.key2 (SW[1]),
	.key3 (SW[2]),
	.key4 (SW[3]),
	.rst(SW[4]),
	.key5 (SW[5]),
	.sw6(SW[6]),
	.sw7(SW[7]),
	.sw8(SW[8]),
	.sw9(SW[9]),
	.sw10(SW[10]),
	.sw11(SW[11]),
	.sw12(SW[12]),
	.sw13(SW[13]),
	.clk(CLOCK_50),
	.iCLK1(VGA_CLK),
	.iCLK2(VGA_CTRL_CLK),
	.px(mCoord_X),
	.py(mCoord_Y),
	.valid(valid),
	.pixel(pixel),
	.sendxpos(sendxpos),
	.sendypos(sendypos)
);
wire [3:0] hitcount ; 

/*always@(livesleft) 
	case(livesleft) 
		4'd0: lifeHex = ~7'b0111111;
		4'd1: lifeHex = ~7'b0000110;
		4'd2: lifeHex = ~7'b1011011;
		4'd3: lifeHex = ~7'b1001111;
		4'd4: lifeHex = ~7'b1100110;
		4'd5: lifeHex = ~7'b1101101;
		4'd6: lifeHex = ~7'b1111101;
		4'd7: lifeHex = ~7'b0000111;
	default: lifeHex = 7'b1111111;
endcase */


integer Red = 10'd0000;
integer Blue = 10'd0000; 
integer Green = 10'd0000;
	

integer Red1 = 10'd0000;
integer Blue1 = 10'd0000; 
integer Green1 = 10'd0000;


always
begin
if((mCoord_X>=sendxpos &&mCoord_X<=sendxpos+5) && (mCoord_Y>=sendypos && mCoord_Y<=sendypos+5) && (SW[2]==1'b1 || SW[3] == 1'b1))
	begin
	 Red1 <= 10'd0000;
	 Blue1 <= 10'd0750; 
	 Green1 <= 10'd0000;
	end
else if ((mCoord_X>=importX &&mCoord_X<=importX+5) && (mCoord_Y>=importY && mCoord_Y<=importY+5) && SW[3] == 1'b1)
	begin
	
	 Red1 <= 10'd0750;
	 Blue1 <= 10'd0000; 
	 Green1 <= 10'd0000;

	end
else if(SW[15] >= 1)
	begin
	Red <= 10'd1000;
	Blue <= 10'd0000; 
	Green <= 10'd1000;
	
	Red1 <= 10'd0000;
	Blue1 <= 10'd0050; 
	Green1 <= 10'd0750;
	end 	
else if (SW[17]>=1)
	begin 
	Red <= 10'd1000;
	Blue <= 10'd0000; 
	Green <= 10'd0650;
	
	Red1 <= 10'd0000;
	Blue1 <= 10'd0000; 
	Green1 <= 10'd0000;
	end 
else if (SW[16]>=1)
	begin 
	Red <= 10'd0600;
	Blue <= 10'd0000; 
	Green <= 10'd0000;
	
	Red1 <= 10'd1000;
	Blue1 <= 10'd1000; 
	Green1 <= 10'd1000;
	end 

else 
	begin 
	Red <= 10'd0000;
	Blue <= 10'd0000; 
	Green <= 10'd0000;
	
	Red1 <= 10'd1000;
	Blue1 <= 10'd1000; 
	Green1 <= 10'd1000;
	end 
end
//
//pixel block and color 
wire valid, pixel;
wire s = valid & pixel;


assign mVGA_R = (s? Red1: Red);
assign mVGA_G = (s? Green1: Green);
assign mVGA_B = (s? Blue1: Blue);


//magic, may explode 
vga_sync u1(
   .iCLK(VGA_CTRL_CLK),
   .iRST_N(DLY_RST&KEY[0]),	
   .iRed(mVGA_R),
   .iGreen(mVGA_G),
   .iBlue(mVGA_B),
   // pixel coordinates
   .px(mCoord_X),
   .py(mCoord_Y),
   // VGA Side
   .VGA_R(VGA_R),
   .VGA_G(VGA_G),
   .VGA_B(VGA_B),
   .VGA_H_SYNC(VGA_HS),
   .VGA_V_SYNC(VGA_VS),
   .VGA_SYNC(VGA_SYNC),
   .VGA_BLANK(VGA_BLANK)
);
//keyboard





// Internal Wires
wire		[7:0]	ps2_key_data;
wire				ps2_key_pressed;

// Internal Registers
reg			[7:0]	last_data_received;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge CLOCK_50)
begin
	if (KEY[0] == 1'b0)
		last_data_received <= 8'h00;
	else if (ps2_key_pressed == 1'b1)
		last_data_received <= ps2_key_data;
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/


/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

PS2_Controller PS2 (
	// Inputs
	.CLOCK_50				(CLOCK_50),
	.reset				(~KEY[0]),

	// Bidirectionals
	.PS2_CLK			(PS2_CLK),
 	.PS2_DAT			(PS2_DAT),

	// Outputs
	.received_data		(ps2_key_data),
	.received_data_en	(ps2_key_pressed)
);

Hexadecimal_To_Seven_Segment Segment0 (
	// Inputs
	.hex_number			(last_data_received[3:0]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX0)
);

Hexadecimal_To_Seven_Segment Segment1 (
	// Inputs
	.hex_number			(last_data_received[7:4]),

	// Bidirectional

	// Outputs
	.seven_seg_display	(HEX1)
);



endmodule