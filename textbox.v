module textbox(
	input iCLK1,iCLK2,
	input [9:0] px,
	input [9:0] py,
	output reg valid,
	output pixel,
	input key1,
	input key2, 
	input key3,
	input key4,
	input key5,
	input sw6,
	input sw7,
	input sw8,
	input sw9,
	input sw10,
	input sw11,
	input sw12,
	input sw13,
	input rst,
	input clk,
	input [7:0]last_data_received,
	output[9:0] sendxpos,
	output[9:0] sendypos,
	input [9:0] inX,
	input [9:0] inY
);
//

reg [6:0] enemieshit;
reg [6:0] lifecount; 
reg [6:0] pvpkills;
reg [6:0] pvplives;
parameter Xleftboarder = 15, Xrightboarder = 625, Ytopboarder = 15, Ybottomboarder = 465, TIMER = 32'd50000000;
reg [31:0]count;
reg [31:0] count2; 
reg [31:0] count3;
reg [31:0] count5;
reg [31:0] mazecounter;
reg [9:0] coopxpos;
reg [9:0] coopypos; 
reg [9:0] enemyxpos;
reg [9:0] enemyypos;
reg [9:0] enemyxpos1;
reg [9:0] enemyypos1;
reg [9:0] enemyxpos2;
reg [9:0] enemyypos2;
reg [9:0] enemyxpos3;
reg [9:0] enemyypos3;
reg [9:0] xpos;
reg [9:0] ypos; 
reg [9:0] importxport;
reg [9:0] importyport; 
wire [10:0] address = {	qchr[6:0], py[3:0] };
wire [7:0] q;
reg rom_mux_output;
wire [9:0] character_address = {py[7:4],px[8:3]};
wire [7:0] qchr;

reg [6:0] towerscore;
reg [6:0] towerlife; 
reg [9:0] aix;
reg [9:0] aiy;
reg [9:0] aix1;
reg [9:0] aiy1;
reg [9:0] aix2;
reg [9:0] aiy2;

//sets up memory and characters for the welcome screen
chars mem1(
	.address(character_address),
	.clock(~iCLK1),
	.wren(1'b0),
	.q(qchr)
	);

sysfont mem2(
	.address(address),
	.clock(iCLK2),
	.q(q)
	);
//



//imports the x vaules to determine the location of the PvP partner 
//Curently only used in the PvP portion 
always 
begin
if(inX[0:0]==1'b1)
 	begin 
 	coopxpos[0:0]<=1'b1;
 	end
else
 	coopxpos[0:0]<=1'b0;
if(inX[1:1]==1'b1)
 	begin 
 	coopxpos[1:1]<=1'b1;
 	end
else
 	coopxpos[1:1]<=1'b0;
if(inX[2:2]==1'b1)
 	begin 
 	coopxpos[2:2]<=1'b1;
 	end
else
 	coopxpos[2:2]<=1'b0;
if(inX[3:3]==1'b1)
 	begin 
 	coopxpos[3:3]<=1'b1;
 	end
else
 	coopxpos[3:3]<=1'b0;
if(inX[4:4]==1'b1)
 	begin 
 	coopxpos[4:4]<=1'b1;
 	end
else
 	coopxpos[4:4]<=1'b0;
if(inX[5:5]==1'b1)
 	begin 
 	coopxpos[5:5]<=1'b1;
 	end
else
 	coopxpos[5:5]<=1'b0;
if(inX[6:6]==1'b1)
 	begin 
 	coopxpos[6:6]<=1'b1;
 	end
else
 	coopxpos[6:6]<=1'b0;
if(inX[7:7]==1'b1)
 	begin 
 	coopxpos[7:7]<=1'b1;
 	end
else
 	coopxpos[7:7]<=1'b0;
if(inX[8:8]==1'b1)
 	begin 
 	coopxpos[8:8]<=1'b1;
 	end
else
 	coopxpos[8:8]<=1'b0;
if(inX[9:9]==1'b1)
 	begin 
 	coopxpos[9:9]<=1'b1;
 	end
else
 	coopxpos[9:9]<=1'b0;

end 
//



//imports the y vaules to determine the location of the PvP partner
//currently only used in the PvP portion 
always 
begin 
if(inY[0:0]==1'b1)
 	begin 
 	coopypos[0:0]<=1'b1;
 	end
else
 	coopypos[0:0]<=1'b0;
if(inY[1:1]==1'b1)
 	begin 
 	coopypos[1:1]<=1'b1;
 	end
else
 	coopypos[1:1]<=1'b0;
if(inY[2:2]==1'b1)
 	begin 
 	coopypos[2:2]<=1'b1;
 	end
else
 	coopypos[2:2]<=1'b0;
if(inY[3:3]==1'b1)
 	begin 
 	coopypos[3:3]<=1'b1;
 	end
else
 	coopypos[3:3]<=1'b0;
if(inY[4:4]==1'b1)
 	begin 
 	coopypos[4:4]<=1'b1;
 	end
else
 	coopypos[4:4]<=1'b0;
if(inY[5:5]==1'b1)
 	begin 
 	coopypos[5:5]<=1'b1;
 	end
else
 	coopypos[5:5]<=1'b0;
if(inY[6:6]==1'b1)
 	begin 
 	coopypos[6:6]<=1'b1;
 	end
else
 	coopypos[6:6]<=1'b0;
if(inY[7:7]==1'b1)
 	begin 
 	coopypos[7:7]<=1'b1;
 	end
else
 	coopypos[7:7]<=1'b0;
if(inY[8:8]==1'b1)
 	begin 
 	coopypos[8:8]<=1'b1;
 	end
else
 	coopypos[8:8]<=1'b0;
if(inY[9:9]==1'b1)
 	begin 
 	coopypos[9:9]<=1'b1;
 	end
else
 	coopypos[9:9]<=1'b0;

end 
//


//player start location and wall detection for both boarders and for the walls in the horde mode and the PvP mode 
//also governs player movement with the keyboard (last_data_received) 
always@(posedge clk or negedge rst)
begin
		if(rst==1'b0)
			begin
				if(key2>1'b0) 
					begin
					xpos<=30;
					ypos<=450;
					end 
				else 
					begin
					xpos<=50; 
					ypos<=50;
					end
					
			end
		else if ((lifecount==7'd0 && key3==1'b1 ) ||(pvplives==7'd0 && key4 == 1'b1))
			begin
				xpos<=50;
				ypos<=50;
				pvplives <= 7'd2;

			end
		else if(count<TIMER)
			begin
				count<=count+7'd100;
				if(xpos<=Xleftboarder || xpos+5>= Xrightboarder)
					if(xpos<=Xleftboarder)
						begin
							xpos<=20;
						end
					else xpos<=610;
				else if(ypos<=Ytopboarder || ypos+5>= Ybottomboarder)
					if(ypos<=Ytopboarder) 
						begin
							ypos<=20;
						end
					else ypos<=455;
// key4 == PvP
//key3 == PvE
//key2 == Maze
//Barrier Construction-Making the walls of the maze

else if(key2==1'b1)
	begin
					//Left Wall
						if(xpos ==15)
							xpos <=xpos+1;
					//Top Wall
						else if(ypos ==15)
							ypos <=ypos+1;
					//Right Wall
						else if(xpos ==620)
							xpos <=xpos-1;
					//Bottom Wall
						else if(ypos ==460)
							ypos <=ypos-1;
					//Row9 Top
						else if((ypos ==25)&&(((xpos >=55)&&(xpos <=330))||((xpos >=355)&&(xpos <=585))))
							ypos <=ypos-1;
					//Row9Bottom
						else if((ypos ==45)&&(((xpos >=55)&&(xpos <=330))||((xpos >=355)&&(xpos <=585))))
							ypos <=ypos+1;
					//Row15Top
						else if((ypos ==55)&&((xpos >=40)&&(xpos <=600)))
							ypos <=ypos-1;
					//Row15Bottom
						else if((ypos ==75)&&((xpos >=40)&&(xpos <=600)))
							ypos <=ypos+1;
					//Row21Top
						else if((ypos ==85)&&(((xpos >=190)&&(xpos <=375))||(xpos <=165)||(xpos >=400)))
							ypos <=ypos-1;
					//Row21Bottom
						else if((ypos ==105)&&(((xpos <=190)&&(375))||(xpos <=165)||(xpos >=400)))
							ypos <=ypos+1;
					//Row27Top
						else if((ypos ==115)&&((xpos <=255)||(xpos >=280)))
							ypos <=ypos-1;
					//Row27Bottom
						else if((ypos ==135)&&((xpos <=255)||(xpos >=280)))	
							ypos <=ypos+1;
					//Row36Top
						else if((ypos ==160)&&((xpos <=60)||((xpos >=85)&&(xpos <=615))))
							ypos <=ypos-1;
					//Row36Bottom
						else if((ypos ==180)&&((xpos <=60)||((xpos >=85)&&(xpos <=615))))
							ypos <=ypos+1;
					//Row42Top
						else if((ypos ==190)&&((xpos <=570)||(xpos >=600)))
							ypos <=ypos-1;
					//Row42Bottom
						else if((ypos ==210)&&((xpos <=570)||(xpos >=600)))	
							ypos <=ypos+1;
					//Row48Top
						else if((ypos ==220)&&((xpos <=285)||(xpos >=345)))
							ypos <=ypos-1;
					//Row48Bottom
						else if((ypos ==240)&&((xpos <=285)||(xpos >=345)))
							ypos <=ypos+1;
					//Row54Top
						else if((ypos ==250)&&((xpos <=225)||(xpos >=255)))
							ypos <=ypos-1;
					//Row54Bottom
						else if((ypos ==270)&&((xpos <=225)||(xpos >=255)))
							ypos <=ypos+1;
					//Row60Top
						else if((ypos ==280)&&((xpos <=47)||(xpos >=70)))
							ypos <=ypos-1;
					//Row60Bottom
						else if((ypos ==300)&&((xpos <=47)||(xpos >=70)))
							ypos <=ypos+1;
					//Row66Top
						else if((ypos ==310)&&((xpos <=195)||(xpos >=225)))
							ypos <=ypos-1;
					//Row66Bottom
						else if((ypos ==330)&&((xpos <=195)||(xpos >=225)))
							ypos <=ypos+1;
					//Row72Top
						else if((ypos ==340)&&((xpos <=60)||(xpos >=90)))
							ypos <=ypos-1;
					//Row72Bottom
						else if((ypos ==360)&&((xpos <=60)||(xpos >=90)))
							ypos <=ypos+1;
					//Row78Top
						else if((ypos ==370)&&((xpos <=435)||(xpos >=460)))
							ypos <=ypos-1;
					//Row78Bottom
						else if((ypos ==390)&&((xpos <=435)||(xpos >=460)))
							ypos <=ypos+1;
					//Row84Top
						else if((ypos ==400)&&((xpos <=330)||(xpos >=355)))
							ypos <=ypos-1;
					//Row84Bottom
						else if((ypos ==420)&&((xpos <=330)||(xpos >=355)))
							ypos <=ypos+1;	
					//Row90Top
						else if((ypos ==430)&&(((xpos >=55)&&(xpos <=390))||((xpos >=415)&&(xpos <=585))))
							ypos <=ypos-1;
					//Row90Bottom
						else if((ypos ==450)&&(((xpos >=55)&&(xpos <=390))||((xpos >=415)&&(xpos <=585))))
							ypos <=ypos+1;	
					//Column9Right
						else if((xpos ==45)&&((ypos >=60)&&(ypos <=75)))
							xpos <=xpos-1;
					//Column9Left
						else if((xpos ==45)&&((ypos >=285)&&(ypos <=300)))
							xpos <=xpos+1;
					//Column12Right
						else if((xpos ==60)&&(((ypos >=30)&&(ypos <=45))||((ypos >=435)&&(ypos <=450))))
							xpos <=xpos-1;
					//Column12Left
						else if((xpos ==60)&&(((ypos >=165)&&(ypos <=180))||((ypos >=345)&&(ypos <=360))))
							xpos <=xpos+1;
					//Column15Right
						else if((xpos ==75)&&((ypos >=285)&&(ypos <=300)))
							xpos <=xpos-1;
					//Column18Right
						else if((xpos ==90)&&(((ypos >=165)&&(ypos <=180))||((ypos >=345)&&(ypos <=360))))
							xpos <=xpos-1;
					//Column33Left
						else if((xpos ==165)&&((ypos >=90)&&(ypos <=105)))
							xpos <=xpos+1;
					//Column39Right
						else if((xpos ==195)&&((ypos >=90)&&(ypos <=105)))
							xpos <=xpos-1;
					//Column39Left
						else if((xpos ==195)&&((ypos >=315)&&(ypos <=330)))
							xpos <=xpos+1;
					//Column45Right
						else if((xpos ==225)&&((ypos >=255)&&(ypos <=270)))
							xpos <=xpos-1;
					//Column45Left
						else if((xpos ==225)&&((ypos >=315)&&(ypos <=330)))
							xpos <=xpos+1;
					//Column51Right
						else if((xpos ==255)&&((ypos >=255)&&(ypos <=270)))
							xpos <=xpos-1;
					//Column51Left
						else if((xpos ==255)&&((ypos >=120)&&(ypos <=135)))
							xpos <=xpos+1;
					//Column57Right
						else if((xpos ==285)&&((ypos >=120)&&(ypos <=135)))
							xpos <=xpos-1;
					//Column57Left
						else if((xpos ==285)&&((ypos >=225)&&(ypos <=240)))
							xpos <=xpos+1;
					//Column66Left
						else if((xpos ==330)&&(((ypos >=30)&&(ypos <=45))||((ypos >=405)&&(ypos <=420))))
							xpos <=xpos+1;
					//Column69Right
						else if((xpos ==345)&&((ypos >=225)&&(ypos <=240)))
							xpos <=xpos-1;
					//Column72Right
						else if((xpos ==360)&&(((ypos >=30)&&(ypos <=45))||((ypos >=405)&&(ypos <=420))))
							xpos <=xpos-1;
					//Column75Left
						else if((xpos ==375)&&((ypos >=90)&&(ypos <=105)))
							xpos <=xpos+1;
					//Column78Left
						else if((xpos ==390)&&((ypos >=435)&&(ypos <=480)))
							xpos <=xpos+1;
					//Column81Right
						else if((xpos ==405)&&((ypos >=90)&&(ypos <=105)))
							xpos <=xpos-1;
					//Column84Right
						else if((xpos ==420)&&((ypos >=435)&&(ypos <=450)))
							xpos <=xpos-1;
					//Column87Left
						else if((xpos ==435)&&((ypos >=375)&&(ypos <=390)))
							xpos <=xpos+1;
					//Column93Right
						else if((xpos ==465)&&((ypos >=375)&&(ypos <=390)))
							xpos <=xpos-1;
					//Column114Left
						else if((xpos ==570)&&((ypos >=195)&&(ypos <=210)))
							xpos <=xpos+1;
					//Column117Left
						else if((xpos ==585)&&(((ypos >=435)&&(ypos <=450))||((ypos >=30)&&(ypos <=45))))
							xpos <=xpos+1;
					//Column120Left
						else if((xpos ==600)&&((ypos >=60)&&(ypos <=75)))
							xpos <=xpos+1;
					//Column120Right
						else if((xpos ==600)&&((ypos >=195)&&(ypos <=210)))
							xpos <=xpos-1;
					//Column123Left
						else if((xpos ==615)&&((ypos >=165)&&(ypos <=180)))
							xpos <=xpos+1;
		end
else if (key3==1'b1)
	begin 	
	//first row first column 						
				if((xpos >=125 && xpos +5<= 275) && (ypos +5>=100 && ypos +5<= 110))
					begin
					ypos = ypos-1'b1;
					end
				else if((xpos >=125 && xpos +5<= 275) && (ypos >=100 && ypos <= 110))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==125) && (ypos +5>=100 && ypos +5<= 110))
					begin
					xpos = xpos-1'b1;
					end
				else if((xpos == 275) && (ypos >=100 && ypos <= 110))
					begin
					xpos = xpos+1'b1;
					end
//					
//second row first column 					
//					
				else if((xpos >=125 && xpos +5<= 275) && (ypos +5>=200 && ypos +5<= 210))
					begin
					ypos = ypos-1'b1;
					end
			else	if((xpos >=125 && xpos +5<= 275) && (ypos >=200 && ypos <= 210))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==125) && (ypos +5>=200 && ypos +5<= 210))
					begin
					xpos = xpos-1'b1;
					end
			else	if((xpos == 275) && (ypos >=200 && ypos <= 210))
					begin
					xpos = xpos+1'b1;
					end
					
//					
//third row first column 					
//					
				else if((xpos >=125 && xpos +5<= 275) && (ypos +5>=300 && ypos +5<= 310))
					begin
					ypos = ypos-1'b1;
					end
else				if((xpos >=125 && xpos +5<= 275) && (ypos >=300 && ypos <= 310))
					begin
					ypos = ypos+1'b1;
					end
	else			if((xpos +5==125) && (ypos +5>=300 && ypos +5<= 310))
					begin
					xpos = xpos-1'b1;
					end
		else		if((xpos == 275) && (ypos >=300 && ypos <= 310))
					begin
					xpos = xpos+1'b1;
					end			
					
//first row second column 			
			else	if((xpos >=350 && xpos +5<= 500) && (ypos +5>=100 && ypos +5<= 110))
					begin
					ypos = ypos-1'b1;
					end
				else if((xpos >=350 && xpos +5<= 500) && (ypos >=100 && ypos <= 110))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==350) && (ypos +5>=100 && ypos +5<= 110))
					begin
					xpos = xpos-1'b1;
					end
				else if((xpos == 500) && (ypos >=100 && ypos <= 110))
					begin
					xpos = xpos+1'b1;
					end
//					
//second row second column 					
//					
				else if((xpos >=350 && xpos +5<= 500) && (ypos +5>=200 && ypos +5<= 210))
					begin
					ypos = ypos-1'b1;
					end
				else if((xpos >=350 && xpos +5<= 500) && (ypos >=200 && ypos <= 210))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==350) && (ypos +5>=200 && ypos +5<= 210))
					begin
					xpos = xpos-1'b1;
					end
				else if((xpos == 500) && (ypos >=200 && ypos <= 210))
					begin
					xpos = xpos+1'b1;
					end
					
//					
//third row second column 					
//					
				else if((xpos >=350 && xpos +5<= 500) && (ypos +5>=300 && ypos +5<= 310))
					begin
					ypos = ypos-1'b1;
					end
				else if((xpos >=350 && xpos +5<= 500) && (ypos >=300 && ypos <= 310))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==350) && (ypos +5>=300 && ypos +5<= 310))
					begin
					xpos = xpos-1'b1;
					end
				else if((xpos == 500) && (ypos >=300 && ypos <= 310))
					begin
					xpos = xpos+1'b1;
					end	
			
	
	
	end
else if(key4==1'b1)
	begin
			//first row first column 			
				if((xpos >=125 && xpos +5<= 275) && (ypos +5>=100 && ypos +5<= 110))
					begin
					ypos = ypos-1'b1;
					end
				else if((xpos >=125 && xpos +5<= 275) && (ypos >=100 && ypos <= 110))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==125) && (ypos +5>=100 && ypos +5<= 110))
					begin
					xpos = xpos-1'b1;
					end
				else if((xpos == 275) && (ypos >=100 && ypos <= 110))
					begin
					xpos = xpos+1'b1;
					end
//					
//second row first column 					
//					
				else if((xpos >=125 && xpos +5<= 275) && (ypos +5>=200 && ypos +5<= 210))
					begin
					ypos = ypos-1'b1;
					end
			else	if((xpos >=125 && xpos +5<= 275) && (ypos >=200 && ypos <= 210))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==125) && (ypos +5>=200 && ypos +5<= 210))
					begin
					xpos = xpos-1'b1;
					end
			else	if((xpos == 275) && (ypos >=200 && ypos <= 210))
					begin
					xpos = xpos+1'b1;
					end
					
//					
//third row first column 					
//					
				else if((xpos >=125 && xpos +5<= 275) && (ypos +5>=300 && ypos +5<= 310))
					begin
					ypos = ypos-1'b1;
					end
else				if((xpos >=125 && xpos +5<= 275) && (ypos >=300 && ypos <= 310))
					begin
					ypos = ypos+1'b1;
					end
	else			if((xpos +5==125) && (ypos +5>=300 && ypos +5<= 310))
					begin
					xpos = xpos-1'b1;
					end
		else		if((xpos == 275) && (ypos >=300 && ypos <= 310))
					begin
					xpos = xpos+1'b1;
					end			
					
//first row second column 			
			else	if((xpos >=350 && xpos +5<= 500) && (ypos +5>=100 && ypos +5<= 110))
					begin
					ypos = ypos-1'b1;
					end
				else if((xpos >=350 && xpos +5<= 500) && (ypos >=100 && ypos <= 110))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==350) && (ypos +5>=100 && ypos +5<= 110))
					begin
					xpos = xpos-1'b1;
					end
				else if((xpos == 500) && (ypos >=100 && ypos <= 110))
					begin
					xpos = xpos+1'b1;
					end
//					
//second row second column 					
//					
				else if((xpos >=350 && xpos +5<= 500) && (ypos +5>=200 && ypos +5<= 210))
					begin
					ypos = ypos-1'b1;
					end
				else if((xpos >=350 && xpos +5<= 500) && (ypos >=200 && ypos <= 210))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==350) && (ypos +5>=200 && ypos +5<= 210))
					begin
					xpos = xpos-1'b1;
					end
				else if((xpos == 500) && (ypos >=200 && ypos <= 210))
					begin
					xpos = xpos+1'b1;
					end
					
//					
//third row second column 					
//					
				else if((xpos >=350 && xpos +5<= 500) && (ypos +5>=300 && ypos +5<= 310))
					begin
					ypos = ypos-1'b1;
					end
				else if((xpos >=350 && xpos +5<= 500) && (ypos >=300 && ypos <= 310))
					begin
					ypos = ypos+1'b1;
					end
				else if((xpos +5==350) && (ypos +5>=300 && ypos +5<= 310))
					begin
					xpos = xpos-1'b1;
					end
				else if((xpos == 500) && (ypos >=300 && ypos <= 310))
					begin
					xpos = xpos+1'b1;
					end	
	end
 
					
//
			end
		else  
			begin
			if((last_data_received[7:4]==4'h7 && last_data_received[3:0]==7'h4)|| last_data_received[3:0]==7'h3 ) 
					xpos = xpos+1'b1; 
				if((last_data_received[7:4]==7'h6 && last_data_received[3:0]==7'hb) || last_data_received[3:0]==7'hc)
					xpos = xpos-1'b1;
				if((last_data_received[7:4]==4'h7 && last_data_received[3:0]==7'h2) || (last_data_received[7:4]==7'h1 && last_data_received[3:0]==7'hb))
					ypos<=ypos+1'b1;
				if ((last_data_received[7:4]==4'h7 && last_data_received[3:0]==7'h5) || last_data_received[3:0]==7'hd )
					ypos<=ypos-1'b1;
				count<=0; 
				if(coopxpos >= xpos + 5 && coopxpos <= xpos+18 && coopypos>= ypos && coopypos <= ypos+3)
					begin
						xpos <= 50; 
						ypos <= 50; 
						pvpkills <= pvpkills + 1'd1;
					end
				else if((xpos >= coopxpos+5 && xpos <= coopxpos + 18 && ypos >= coopypos+2 && ypos <= coopypos+3)|| 
				(xpos+5 >= coopxpos+5 && xpos+5 <= coopxpos + 18 && ypos+5 >= coopypos+2 && ypos+5 <= coopypos+3))
					begin 
					ypos <=50;
					xpos <=50;
					pvplives <= pvplives -1'd1;
					end 
				else if(pvpkills == 7'd3 && pvplives <= 7'd2) 
					begin
						pvplives <= pvplives + 7'd1; 
					end 
				else if(pvpkills == 7'd7 && pvplives <= 7'd3) 
					begin
						pvplives <= pvplives + 7'd1; 
					end 
				else if(pvpkills == 7'd12 && pvplives <= 7'd4) 
					begin
						pvplives <= pvplives + 7'd5; 
					end 
				else if(pvpkills == 7'd18 && pvplives <= 7'd5) 
					begin
						pvplives <= pvplives + 7'd2; 
					end 
				else if(pvpkills == 7'd22 && pvplives <= 7'd7) 
					begin
						pvplives <= pvplives + 7'd3; 
					end 
				//player being hit by enemy 
			end
end
//



//module for wall detection for the player in maze, PvP, and PvE	
//enemy start location and wall detection for all enemies 	
//also detects if the enemy have hit the sword of the player
//also governs enemy movement which is based on the x position and y position of the player 
always@(posedge clk or negedge rst)
begin
		if(rst==1'b0)
			begin
				lifecount <= 7'd2;
				enemyxpos <=650; 
				enemyypos <=350;
				enemyxpos1 <=350; 
				enemyypos1 <=250;
				enemyxpos2 <=150; 
				enemyypos2 <=150;
				enemyxpos3 <=350; 
				enemyypos3 <=150;
				enemieshit <= 7'b0;


			end
		else if (lifecount == 7'd0)
			begin
				lifecount <= 7'd2;
				enemyxpos <=650; 
				enemyypos <=350;
				enemyxpos1 <=350; 
				enemyypos1 <=250;
				enemyxpos2 <=150; 
				enemyypos2 <=150;
				enemyxpos3 <=350; 
				enemyypos3 <=150;
				enemieshit <= 7'b0;
			end
		else if(count2<TIMER)
			begin
				if(enemieshit > 7'd3 && enemieshit <= 7'd7)
					count2<=count2+32'd50;
				else if(enemieshit > 7'd7 && enemieshit <= 7'd12)
					count2<=count2+32'd60;
				else if(enemieshit > 7'd12 && enemieshit <= 7'd18)
					count2<=count2+32'd70;
				else if(enemieshit > 7'd18 && enemieshit <= 7'd23)
					count2<=count2+32'd80;
				else if(enemieshit >= 7'd24)
					count2<=count2+32'd90;
				else 
					count2 <= count2 + 32'd40;
//first row first column 			
				if((enemyxpos>=125 && enemyxpos+5<= 275) && (enemyypos+5>=100 && enemyypos+5<= 110))
					begin
					enemyypos = enemyypos-1'b1;
					end
				if((enemyxpos>=125 && enemyxpos+5<= 275) && (enemyypos>=100 && enemyypos<= 110))
					begin
					enemyypos = enemyypos+1'b1;
					end
				if((enemyxpos+5==125) && (enemyypos+5>=100 && enemyypos+5<= 110))
					begin
					enemyxpos = enemyxpos-1'b1;
					end
				if((enemyxpos== 275) && (enemyypos>=100 && enemyypos<= 110))
					begin
					enemyxpos = enemyxpos+1'b1;
					end
//					
//second row first column 					
//					
				if((enemyxpos>=125 && enemyxpos+5<= 275) && (enemyypos+5>=200 && enemyypos+5<= 210))
					begin
					enemyypos = enemyypos-1'b1;
					end
				if((enemyxpos>=125 && enemyxpos+5<= 275) && (enemyypos>=200 && enemyypos<= 210))
					begin
					enemyypos = enemyypos+1'b1;
					end
				if((enemyxpos+5==125) && (enemyypos+5>=200 && enemyypos+5<= 210))
					begin
					enemyxpos = enemyxpos-1'b1;
					end
				if((enemyxpos== 275) && (enemyypos>=200 && enemyypos<= 210))
					begin
					enemyxpos = enemyxpos+1'b1;
					end
					
//					
//third row first column 					
//					
				if((enemyxpos>=125 && enemyxpos+5<= 275) && (enemyypos+5>=300 && enemyypos+5<= 310))
					begin
					enemyypos = enemyypos-1'b1;
					end
				if((enemyxpos>=125 && enemyxpos+5<= 275) && (enemyypos>=300 && enemyypos<= 310))
					begin
					enemyypos = enemyypos+1'b1;
					end
				if((enemyxpos+5==125) && (enemyypos+5>=300 && enemyypos+5<= 310))
					begin
					enemyxpos = enemyxpos-1'b1;
					end
				if((enemyxpos== 275) && (enemyypos>=300 && enemyypos<= 310))
					begin
					enemyxpos = enemyxpos+1'b1;
					end			
					
//first row second column 			
				if((enemyxpos>=350 && enemyxpos+5<= 500) && (enemyypos+5>=100 && enemyypos+5<= 110))
					begin
					enemyypos = enemyypos-1'b1;
					end
				if((enemyxpos>=350 && enemyxpos+5<= 500) && (enemyypos>=100 && enemyypos<= 110))
					begin
					enemyypos = enemyypos+1'b1;
					end
				if((enemyxpos+5==350) && (enemyypos+5>=100 && enemyypos+5<= 110))
					begin
					enemyxpos = enemyxpos-1'b1;
					end
				if((enemyxpos== 500) && (enemyypos>=100 && enemyypos<= 110))
					begin
					enemyxpos = enemyxpos+1'b1;
					end
//					
//second row second column 					
//					
				if((enemyxpos>=350 && enemyxpos+5<= 500) && (enemyypos+5>=200 && enemyypos+5<= 210))
					begin
					enemyypos = enemyypos-1'b1;
					end
				if((enemyxpos>=350 && enemyxpos+5<= 500) && (enemyypos>=200 && enemyypos<= 210))
					begin
					enemyypos = enemyypos+1'b1;
					end
				if((enemyxpos+5==350) && (enemyypos+5>=200 && enemyypos+5<= 210))
					begin
					enemyxpos = enemyxpos-1'b1;
					end
				if((enemyxpos== 500) && (enemyypos>=200 && enemyypos<= 210))
					begin
					enemyxpos = enemyxpos+1'b1;
					end
					
//					
//third row second column 					
//					
				if((enemyxpos>=350 && enemyxpos+5<= 500) && (enemyypos+5>=300 && enemyypos+5<= 310))
					begin
					enemyypos = enemyypos-1'b1;
					end
				if((enemyxpos>=350 && enemyxpos+5<= 500) && (enemyypos>=300 && enemyypos<= 310))
					begin
					enemyypos = enemyypos+1'b1;
					end
				if((enemyxpos+5==350) && (enemyypos+5>=300 && enemyypos+5<= 310))
					begin
					enemyxpos = enemyxpos-1'b1;
					end
				if((enemyxpos== 500) && (enemyypos>=300 && enemyypos<= 310))
					begin
					enemyxpos = enemyxpos+1'b1;
					end			
//
//
//
//for enemyypos1
//
//
//
//first row first column 			
				if((enemyxpos1>=125 && enemyxpos1+5<= 275) && (enemyypos1+5>=100 && enemyypos1+5<= 110))
					begin
					enemyypos1 = enemyypos1-1'b1;
					end
				if((enemyxpos1>=125 && enemyxpos1+5<= 275) && (enemyypos1>=100 && enemyypos1<= 110))
					begin
					enemyypos1 = enemyypos1+1'b1;
					end
				if((enemyxpos1+5==125) && (enemyypos1+5>=100 && enemyypos1+5<= 110))
					begin
					enemyxpos1 = enemyxpos1-1'b1;
					end
				if((enemyxpos1== 275) && (enemyypos1>=100 && enemyypos1<= 110))
					begin
					enemyxpos1 = enemyxpos1+1'b1;
					end
//					
//second row first column 					
//					
				if((enemyxpos1>=125 && enemyxpos1+5<= 275) && (enemyypos1+5>=200 && enemyypos1+5<= 210))
					begin
					enemyypos1 = enemyypos1-1'b1;
					end
				if((enemyxpos1>=125 && enemyxpos1+5<= 275) && (enemyypos1>=200 && enemyypos1<= 210))
					begin
					enemyypos1 = enemyypos1+1'b1;
					end
				if((enemyxpos1+5==125) && (enemyypos1+5>=200 && enemyypos1+5<= 210))
					begin
					enemyxpos1 = enemyxpos1-1'b1;
					end
				if((enemyxpos1== 275) && (enemyypos1>=200 && enemyypos1<= 210))
					begin
					enemyxpos1 = enemyxpos1+1'b1;
					end
					
//					
//third row first column 					
//					
				if((enemyxpos1>=125 && enemyxpos1+5<= 275) && (enemyypos1+5>=300 && enemyypos1+5<= 310))
					begin
					enemyypos1 = enemyypos1-1'b1;
					end
				if((enemyxpos1>=125 && enemyxpos1+5<= 275) && (enemyypos1>=300 && enemyypos1<= 310))
					begin
					enemyypos1 = enemyypos1+1'b1;
					end
				if((enemyxpos1+5==125) && (enemyypos1+5>=300 && enemyypos1+5<= 310))
					begin
					enemyxpos1 = enemyxpos1-1'b1;
					end
				if((enemyxpos1== 275) && (enemyypos1>=300 && enemyypos1<= 310))
					begin
					enemyxpos1 = enemyxpos1+1'b1;
					end			
					
//first row second column 			
				if((enemyxpos1>=350 && enemyxpos1+5<= 500) && (enemyypos1+5>=100 && enemyypos1+5<= 110))
					begin
					enemyypos1 = enemyypos1-1'b1;
					end
				if((enemyxpos1>=350 && enemyxpos1+5<= 500) && (enemyypos1>=100 && enemyypos1<= 110))
					begin
					enemyypos1 = enemyypos1+1'b1;
					end
				if((enemyxpos1+5==350) && (enemyypos1+5>=100 && enemyypos1+5<= 110))
					begin
					enemyxpos1 = enemyxpos1-1'b1;
					end
				if((enemyxpos1== 500) && (enemyypos1>=100 && enemyypos1<= 110))
					begin
					enemyxpos1 = enemyxpos1+1'b1;
					end
//					
//second row second column 					
//					
				if((enemyxpos1>=350 && enemyxpos1+5<= 500) && (enemyypos1+5>=200 && enemyypos1+5<= 210))
					begin
					enemyypos1 = enemyypos1-1'b1;
					end
				if((enemyxpos1>=350 && enemyxpos1+5<= 500) && (enemyypos1>=200 && enemyypos1<= 210))
					begin
					enemyypos1 = enemyypos1+1'b1;
					end
				if((enemyxpos1+5==350) && (enemyypos1+5>=200 && enemyypos1+5<= 210))
					begin
					enemyxpos1 = enemyxpos1-1'b1;
					end
				if((enemyxpos1== 500) && (enemyypos1>=200 && enemyypos1<= 210))
					begin
					enemyxpos1 = enemyxpos1+1'b1;
					end
					
//					
//third row second column 					
//					
				if((enemyxpos1>=350 && enemyxpos1+5<= 500) && (enemyypos1+5>=300 && enemyypos1+5<= 310))
					begin
					enemyypos1 = enemyypos1-1'b1;
					end
				if((enemyxpos1>=350 && enemyxpos1+5<= 500) && (enemyypos1>=300 && enemyypos1<= 310))
					begin
					enemyypos1 = enemyypos1+1'b1;
					end
				if((enemyxpos1+5==350) && (enemyypos1+5>=300 && enemyypos1+5<= 310))
					begin
					enemyxpos1 = enemyxpos1-1'b1;
					end
				if((enemyxpos1== 500) && (enemyypos1>=300 && enemyypos1<= 310))
					begin
					enemyxpos1 = enemyxpos1+1'b1;
					end	
//
//
//
//enemyxpos2
//
//
//
//first row first column 			
				if((enemyxpos2>=125 && enemyxpos2+5<= 275) && (enemyypos2+5>=100 && enemyypos2+5<= 110))
					begin
					enemyypos2 = enemyypos2-1'b1;
					end
				if((enemyxpos2>=125 && enemyxpos2+5<= 275) && (enemyypos2>=100 && enemyypos2<= 110))
					begin
					enemyypos2 = enemyypos2+1'b1;
					end
				if((enemyxpos2+5==125) && (enemyypos2+5>=100 && enemyypos2+5<= 110))
					begin
					enemyxpos2 = enemyxpos2-1'b1;
					end
				if((enemyxpos2== 275) && (enemyypos2>=100 && enemyypos2<= 110))
					begin
					enemyxpos2 = enemyxpos2+1'b1;
					end
//					
//second row first column 					
//					
				if((enemyxpos2>=125 && enemyxpos2+5<= 275) && (enemyypos2+5>=200 && enemyypos2+5<= 210))
					begin
					enemyypos2 = enemyypos2-1'b1;
					end
				if((enemyxpos2>=125 && enemyxpos2+5<= 275) && (enemyypos2>=200 && enemyypos2<= 210))
					begin
					enemyypos2 = enemyypos2+1'b1;
					end
				if((enemyxpos2+5==125) && (enemyypos2+5>=200 && enemyypos2+5<= 210))
					begin
					enemyxpos2 = enemyxpos2-1'b1;
					end
				if((enemyxpos2== 275) && (enemyypos2>=200 && enemyypos2<= 210))
					begin
					enemyxpos2 = enemyxpos2+1'b1;
					end
					
//					
//third row first column 					
//					
				if((enemyxpos2>=125 && enemyxpos2+5<= 275) && (enemyypos2+5>=300 && enemyypos2+5<= 310))
					begin
					enemyypos2 = enemyypos2-1'b1;
					end
				if((enemyxpos2>=125 && enemyxpos2+5<= 275) && (enemyypos2>=300 && enemyypos2<= 310))
					begin
					enemyypos2 = enemyypos2+1'b1;
					end
				if((enemyxpos2+5==125) && (enemyypos2+5>=300 && enemyypos2+5<= 310))
					begin
					enemyxpos2 = enemyxpos2-1'b1;
					end
				if((enemyxpos2== 275) && (enemyypos2>=300 && enemyypos2<= 310))
					begin
					enemyxpos2 = enemyxpos2+1'b1;
					end			
					
//first row second column 			
				if((enemyxpos2>=350 && enemyxpos2+5<= 500) && (enemyypos2+5>=100 && enemyypos2+5<= 110))
					begin
					enemyypos2 = enemyypos2-1'b1;
					end
				if((enemyxpos2>=350 && enemyxpos2+5<= 500) && (enemyypos2>=100 && enemyypos2<= 110))
					begin
					enemyypos2 = enemyypos2+1'b1;
					end
				if((enemyxpos2+5==350) && (enemyypos2+5>=100 && enemyypos2+5<= 110))
					begin
					enemyxpos2 = enemyxpos2-1'b1;
					end
				if((enemyxpos2== 500) && (enemyypos2>=100 && enemyypos2<= 110))
					begin
					enemyxpos2 = enemyxpos2+1'b1;
					end
//					
//second row second column 					
//					
				if((enemyxpos2>=350 && enemyxpos2+5<= 500) && (enemyypos2+5>=200 && enemyypos2+5<= 210))
					begin
					enemyypos2 = enemyypos2-1'b1;
					end
				if((enemyxpos2>=350 && enemyxpos2+5<= 500) && (enemyypos2>=200 && enemyypos2<= 210))
					begin
					enemyypos2 = enemyypos2+1'b1;
					end
				if((enemyxpos2+5==350) && (enemyypos2+5>=200 && enemyypos2+5<= 210))
					begin
					enemyxpos2 = enemyxpos2-1'b1;
					end
				if((enemyxpos2== 500) && (enemyypos2>=200 && enemyypos2<= 210))
					begin
					enemyxpos2 = enemyxpos2+1'b1;
					end
					
//					
//third row second column 					
//					
				if((enemyxpos2>=350 && enemyxpos2+5<= 500) && (enemyypos2+5>=300 && enemyypos2+5<= 310))
					begin
					enemyypos2 = enemyypos2-1'b1;
					end
				if((enemyxpos2>=350 && enemyxpos2+5<= 500) && (enemyypos2>=300 && enemyypos2<= 310))
					begin
					enemyypos2 = enemyypos2+1'b1;
					end
				if((enemyxpos2+5==350) && (enemyypos2+5>=300 && enemyypos2+5<= 310))
					begin
					enemyxpos2 = enemyxpos2-1'b1;
					end
				if((enemyxpos2== 500) && (enemyypos2>=300 && enemyypos2<= 310))
					begin
					enemyxpos2 = enemyxpos2+1'b1;
					end	
//
//
//
//enemyxpos3
//
//
//
//first row first column 			
				if((enemyxpos3>=125 && enemyxpos3+5<= 275) && (enemyypos3+5>=100 && enemyypos3+5<= 110))
					begin
					enemyypos3 = enemyypos3-1'b1;
					end
				if((enemyxpos3>=125 && enemyxpos3+5<= 275) && (enemyypos3>=100 && enemyypos3<= 110))
					begin
					enemyypos3 = enemyypos3+1'b1;
					end
				if((enemyxpos3+5==125) && (enemyypos3+5>=100 && enemyypos3+5<= 110))
					begin
					enemyxpos3 = enemyxpos3-1'b1;
					end
				if((enemyxpos3== 275) && (enemyypos3>=100 && enemyypos3<= 110))
					begin
					enemyxpos3 = enemyxpos3+1'b1;
					end
//					
//second row first column 					
//					
				if((enemyxpos3>=125 && enemyxpos3+5<= 275) && (enemyypos3+5>=200 && enemyypos3+5<= 210))
					begin
					enemyypos3 = enemyypos3-1'b1;
					end
				if((enemyxpos3>=125 && enemyxpos3+5<= 275) && (enemyypos3>=200 && enemyypos3<= 210))
					begin
					enemyypos3 = enemyypos3+1'b1;
					end
				if((enemyxpos3+5==125) && (enemyypos3+5>=200 && enemyypos3+5<= 210))
					begin
					enemyxpos3 = enemyxpos3-1'b1;
					end
				if((enemyxpos3== 275) && (enemyypos3>=200 && enemyypos3<= 210))
					begin
					enemyxpos3 = enemyxpos3+1'b1;
					end
					
//					
//third row first column 					
//					
				if((enemyxpos3>=125 && enemyxpos3+5<= 275) && (enemyypos3+5>=300 && enemyypos3+5<= 310))
					begin
					enemyypos3 = enemyypos3-1'b1;
					end
				if((enemyxpos3>=125 && enemyxpos3+5<= 275) && (enemyypos3>=300 && enemyypos3<= 310))
					begin
					enemyypos3 = enemyypos3+1'b1;
					end
				if((enemyxpos3+5==125) && (enemyypos3+5>=300 && enemyypos3+5<= 310))
					begin
					enemyxpos3 = enemyxpos3-1'b1;
					end
				if((enemyxpos3== 275) && (enemyypos3>=300 && enemyypos3<= 310))
					begin
					enemyxpos3 = enemyxpos3+1'b1;
					end			
					
//first row second column 			
				if((enemyxpos3>=350 && enemyxpos3+5<= 500) && (enemyypos3+5>=100 && enemyypos3+5<= 110))
					begin
					enemyypos3 = enemyypos3-1'b1;
					end
				if((enemyxpos3>=350 && enemyxpos3+5<= 500) && (enemyypos3>=100 && enemyypos3<= 110))
					begin
					enemyypos3 = enemyypos3+1'b1;
					end
				if((enemyxpos3+5==350) && (enemyypos3+5>=100 && enemyypos3+5<= 110))
					begin
					enemyxpos3 = enemyxpos3-1'b1;
					end
				if((enemyxpos3== 500) && (enemyypos3>=100 && enemyypos3<= 110))
					begin
					enemyxpos3 = enemyxpos3+1'b1;
					end
//					
//second row second column 					
//					
				if((enemyxpos3>=350 && enemyxpos3+5<= 500) && (enemyypos3+5>=200 && enemyypos3+5<= 210))
					begin
					enemyypos3 = enemyypos3-1'b1;
					end
				if((enemyxpos3>=350 && enemyxpos3+5<= 500) && (enemyypos3>=200 && enemyypos3<= 210))
					begin
					enemyypos3 = enemyypos3+1'b1;
					end
				if((enemyxpos3+5==350) && (enemyypos3+5>=200 && enemyypos3+5<= 210))
					begin
					enemyxpos3 = enemyxpos3-1'b1;
					end
				if((enemyxpos3== 500) && (enemyypos3>=200 && enemyypos3<= 210))
					begin
					enemyxpos3 = enemyxpos3+1'b1;
					end
					
//					
//third row second column 					
//					
				if((enemyxpos3>=350 && enemyxpos3+5<= 500) && (enemyypos3+5>=300 && enemyypos3+5<= 310))
					begin
					enemyypos3 = enemyypos3-1'b1;
					end
				if((enemyxpos3>=350 && enemyxpos3+5<= 500) && (enemyypos3>=300 && enemyypos3<= 310))
					begin
					enemyypos3 = enemyypos3+1'b1;
					end
				if((enemyxpos3+5==350) && (enemyypos3+5>=300 && enemyypos3+5<= 310))
					begin
					enemyxpos3 = enemyxpos3-1'b1;
					end
				if((enemyxpos3== 500) && (enemyypos3>=300 && enemyypos3<= 310))
					begin
					enemyxpos3 = enemyxpos3+1'b1;
					end	
				
	end
		else  
			begin
				count2<=0;
				//player against enemy hit detection 
				if(sw6 == 1'b1) //if the up sword is on
					begin
				if(enemyypos>= ypos-13 && enemyypos <= ypos-4 && enemyxpos >= xpos && enemyxpos <= xpos + 5)
					begin
						enemyxpos <=635; 
						enemyypos <=5;
						enemieshit <= enemieshit + 1'd1;
			
					end
				if(enemyxpos1 >= xpos && enemyxpos1 <= xpos+5 && enemyypos1+5 >= ypos-13 && enemyypos1+5 <= ypos-4)
					begin
						enemyxpos1 <=5; 
						enemyypos1 <=5;
						enemieshit <= enemieshit + 1'd1;
					end
				if(enemyxpos2 >= xpos && enemyxpos2 <= xpos+5 && enemyypos2 >= ypos-13 && enemyypos2 <= ypos-4)
					begin
						enemyxpos2 <= 5; 
						enemyypos2 <= 475;
						enemieshit <= enemieshit + 1'd1;
					end
				if(enemyxpos3 >= xpos && enemyxpos3 <= xpos+5 && enemyypos3 >= ypos-13 && enemyypos3 <= ypos-4)
					begin
						enemyxpos3 <=635; 
						enemyypos3 <=475;
						enemieshit <= enemieshit + 1'd1;
					end					
					end 
				else if (sw7 == 1'b1) //if the right sword is on (width 3 works, width 1 doesn't work) 
					begin
				if(enemyxpos >= xpos + 9 && enemyxpos <= xpos + 18 && enemyypos >= ypos && enemyypos <= ypos+5)
					begin
						enemyxpos <=635; 
						enemyypos <=5;
						enemieshit <= enemieshit + 1'd1;
			
					end
				else if(enemyxpos1 >= xpos + 9 && enemyxpos1 <= xpos + 18 && enemyypos1 >= ypos && enemyypos1 <= ypos+5)
					begin
						enemyxpos1 <=5; 
						enemyypos1 <=5;
						enemieshit <= enemieshit + 1'd1;
					end
				else if(enemyxpos2 >= xpos + 9 && enemyxpos2 <= xpos + 18 && enemyypos2 >= ypos && enemyypos2 <= ypos+5)
					begin
						enemyxpos2 <= 5; 
						enemyypos2 <= 475;
						enemieshit <= enemieshit + 1'd1;
					end
				else if(enemyxpos3 >= xpos + 9 && enemyxpos3 <= xpos + 18 && enemyypos3 >= ypos && enemyypos3 <= ypos+5)
					begin
						enemyxpos3 <=635; 
						enemyypos3 <=475;
						enemieshit <= enemieshit + 1'd1;
					end
					end 
				else if (sw8 == 1'b1) //if the bottom sword is on
					begin 
				if(enemyxpos >= xpos && enemyxpos <= xpos + 5 && enemyypos >= ypos+9 && enemyypos <= ypos+18)
					begin
						enemyxpos <=635; 
						enemyypos <=5;
						enemieshit <= enemieshit + 1'd1;
			
					end
				else if(enemyxpos1 >= xpos && enemyxpos1 <= xpos + 5 && enemyypos1 >= ypos+9 && enemyypos1 <= ypos+18)
					begin
						enemyxpos1 <=5; 
						enemyypos1 <=5;
						enemieshit <= enemieshit + 1'd1;
					end
				else if(enemyxpos2 >= xpos && enemyxpos2 <= xpos + 5 && enemyypos2 >= ypos+9 && enemyypos2 <= ypos+18)
					begin
						enemyxpos2 <= 5; 
						enemyypos2 <= 475;
						enemieshit <= enemieshit + 1'd1;
					end
				else if(enemyxpos3 >= xpos && enemyxpos3 <= xpos + 5 && enemyypos3 >= ypos+9 && enemyypos3 <= ypos+18)
					begin
						enemyxpos3 <=635; 
						enemyypos3 <=475;
						enemieshit <= enemieshit + 1'd1;
					end

					end 
				else if (sw9 == 1'b1) //if the left sword is on
					begin
				if(enemyxpos >= xpos - 13 && enemyxpos <= xpos -4 && enemyypos >= ypos && enemyypos <= ypos+5)
					begin
						enemyxpos <=635; 
						enemyypos <=5;
						enemieshit <= enemieshit + 1'd1;
			
					end
				else if(enemyxpos1 >= xpos - 13 && enemyxpos1 <= xpos -4 && enemyypos1 >= ypos && enemyypos1 <= ypos+5)
					begin
						enemyxpos1 <=5; 
						enemyypos1 <=5;
						enemieshit <= enemieshit + 1'd1;
					end
				else if(enemyxpos2 >= xpos - 13 && enemyxpos2 <= xpos -4 && enemyypos2 >= ypos && enemyypos2 <= ypos+5)
					begin
						enemyxpos2 <= 5; 
						enemyypos2 <= 475;
						enemieshit <= enemieshit + 1'd1;
					end
				else if(enemyxpos3 >= xpos - 13 && enemyxpos3 <= xpos -4 && enemyypos3 >= ypos && enemyypos3 <= ypos+5)
					begin
						enemyxpos3 <=635; 
						enemyypos3 <=475;
						enemieshit <= enemieshit + 1'd1;
					end 
					end
				//enemy movement 
				if(enemyxpos<xpos) 
				begin
					enemyxpos<=enemyxpos+1'b1;
					end
				if(enemyxpos>xpos) 
				begin
					enemyxpos<=enemyxpos-1'b1;
					end 
				if(enemyypos<ypos) 
				begin
					enemyypos<=enemyypos+1'b1;
					end
				if(enemyypos>ypos) 
				begin
					enemyypos<=enemyypos-1'b1;
				end
				
				//ememy1 movment 
				if(enemyxpos1<xpos) 
				begin
					enemyxpos1<=enemyxpos1+1'b1;
					end
				if(enemyxpos>xpos) 
				begin
					enemyxpos1<=enemyxpos1-1'b1;
					end 
				if(enemyypos1<ypos) 
				begin
					enemyypos1<=enemyypos1+1'b1;
					end
				if(enemyypos1>ypos) 
				begin
					enemyypos1<=enemyypos1-1'b1;
				end
				//enemy2 movement 
				if(enemyxpos2<xpos) 
				begin
					enemyxpos2<=enemyxpos2+1'b1;
					end
				if(enemyxpos2>xpos) 
				begin
					enemyxpos2<=enemyxpos2-1'b1;
					end 
				if(enemyypos2<ypos) 
				begin
					enemyypos2<=enemyypos2+1'b1;
					end
				if(enemyypos2>ypos) 
				begin
					enemyypos2<=enemyypos2-1'b1;
				end
				//enemy3 movment 
				if(enemyxpos3<xpos) 
				begin
					enemyxpos3<=enemyxpos3+1'b1;
					end
				if(enemyxpos3>xpos) 
				begin
					enemyxpos3<=enemyxpos3-1'b1;
					end 
				if(enemyypos3<ypos) 
				begin
					enemyypos3<=enemyypos3+1'b1;
					end
				if(enemyypos3>ypos) 
				begin
					enemyypos3<=enemyypos3-1'b1;
				end
				if(enemyxpos1<xpos) enemyxpos1<=enemyxpos1+1'b1;
				if(enemyxpos1>xpos) enemyxpos1<=enemyxpos1-1'b1;
				if(enemyypos1<ypos) enemyypos1<=enemyypos1+1'b1;
				if(enemyypos1>ypos) enemyypos1<=enemyypos1-1'b1;
				
				if(enemyxpos2<xpos) enemyxpos2<=enemyxpos2+1'b1;
				if(enemyxpos2>xpos) enemyxpos2<=enemyxpos2-1'b1;
				if(enemyypos2<ypos) enemyypos2<=enemyypos2+1'b1;
				if(enemyypos2>ypos) enemyypos2<=enemyypos2-1'b1;
				
				if(enemyxpos3<xpos) enemyxpos3<=enemyxpos3+1'b1;
				if(enemyxpos3>xpos) enemyxpos3<=enemyxpos3-1'b1;
				if(enemyypos3<ypos) enemyypos3<=enemyypos3+1'b1;
				if(enemyypos3>ypos) enemyypos3<=enemyypos3-1'b1;
				if(enemieshit == 7'd3 && lifecount <= 7'd2) 
					begin
						lifecount <= lifecount + 7'd1; 
					end 
				else if(enemieshit == 7'd7 && lifecount <= 7'd3) 
					begin
						lifecount <= lifecount + 7'd1; 
					end 
				else if(enemieshit == 7'd12 && lifecount <= 7'd4) 
					begin
						lifecount <= lifecount + 7'd5; 
					end 
				else if(enemieshit == 7'd18 && lifecount <= 7'd5) 
					begin
						lifecount <= lifecount + 7'd2; 
					end 
				else if(enemieshit == 7'd22 && lifecount <= 7'd7) 
					begin
						lifecount <= lifecount + 7'd3; 
					end 
				//player being hit by enemy 
				else if(xpos == 50 && ypos == 50) 
					lifecount <= 2;
				else if((((enemyxpos >= xpos && enemyxpos <= xpos+5) && (enemyypos >= ypos && enemyypos <= ypos+5))||
				((enemyxpos+5 >= xpos && enemyxpos+5 <= xpos+5) && (enemyypos+5 >= ypos && enemyypos+5 <= ypos+5))))
					begin 
						lifecount <= lifecount - 1'd1;
						enemyxpos <=320; 
						enemyypos <=0;
				
					end
				else if(((enemyxpos1 >= xpos && enemyxpos1 <= xpos+5) && (enemyypos1 >= ypos && enemyypos1 <= ypos+5))||
				((enemyxpos1+5 >= xpos && enemyxpos1+5 <= xpos+5) && (enemyypos1+5 >= ypos && enemyypos1+5 <= ypos+5)))
					begin 
						lifecount = lifecount - 1'b1; 
						enemyxpos1 <=320; 
						enemyypos1 <=480;
					end 

				else if(((enemyxpos2 >= xpos && enemyxpos2 <= xpos+5) && (enemyypos2 >= ypos && enemyypos2 <= ypos+5))||
				((enemyxpos2+5 >= xpos && enemyxpos2+5 <= xpos+5) && (enemyypos2+5 >= ypos && enemyypos2+5 <= ypos+5)))
					begin 
						lifecount = lifecount - 1'b1; 
						enemyxpos2 <=0; 
						enemyypos2 <=240;
					end 

				else if(((enemyxpos3 >= xpos && enemyxpos3 <= xpos+5) && (enemyypos3 >= ypos && enemyypos3 <= ypos+5))||
				((enemyxpos3+5 >= xpos && enemyxpos3+5 <= xpos+5) && (enemyypos3+5 >= ypos && enemyypos3+5 <= ypos+5)))
					begin 
						lifecount = lifecount - 1'b1; 
						enemyxpos3 <=640; 
						enemyypos3 <=240;
					end 
				
				
			end
	end
//


//timer for the maze
//goes up by once the clock has gone positive 50 million times 
always@(posedge clk or negedge rst) 
begin
//
	if(rst == 1'b0)
		begin
		mazecounter <= 0; 
		count3 <= 0;
		end
	else if(count3 < TIMER) 
		count3  <= count3  + 1'd1;
	else 
		begin
		count3  <= 0;
		if(xpos >= 585 && xpos <= 625 && ypos >= 15 && ypos <= 75)
			mazecounter <= mazecounter;
		else 
			mazecounter <= mazecounter + 1'd1;
		end
end 

//


//determines where to place pink pixels 
//this is used for the boaders and player icon as well as enemies
always 
begin
if(key3==1) //key2 PVE 
	begin 
		rom_mux_output = 7'b1;
		//draws tick marks based on kills 
		if(px>= 623 && px <= 625 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 619 && px <= 621 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 615 && px <= 617 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 611 && px <= 613 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 607 && px <= 609 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 603 && px <= 605 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 599 && px <= 601 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 595 && px <= 597 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd8)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 591 && px <= 593 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd9)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 587 && px <= 589 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd10)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 583 && px <= 585 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd11)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 579 && px <= 581 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd12)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 575 && px <= 577 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd13)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 571 && px <= 573 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd14)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 567 && px <= 569 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd15)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 563 && px <= 565 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd16)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 559 && px <= 561 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd17)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 555 && px <= 557 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd18)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 551 && px <= 553 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd19)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 547 && px <= 549 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd20)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 543 && px <= 545 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd21)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 539 && px <= 541 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd22)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 535 && px <= 537 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd23)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 531 && px <= 533 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd24)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 527 && px <= 529 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd25)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 523 && px <= 525 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd26)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 519 && px <= 521 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd27)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 515 && px <= 517 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd28)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 511 && px <= 513 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd29)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 507 && px <= 509 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd30)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 503 && px <= 505 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd31)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 499 && px <= 501 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd32)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 495 && px <= 497 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd33)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 491 && px <= 493 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd34)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 487 && px <= 489 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd35)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 483 && px <= 485 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd36)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 479 && px <= 481 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd37)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 475 && px <= 477 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd38)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 471 && px <= 473 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd39)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 467 && px <= 469 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd40)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 463 && px <= 465 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd41)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 459 && px <= 461 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd42)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 455 && px <= 457 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd43)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 451 && px <= 453 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd44)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 447 && px <= 449 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd45)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 443 && px <= 445 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd46)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 439 && px <= 441 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd47)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 435 && px <= 437 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd48)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 431 && px <= 433 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd49)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 427 && px <= 429 && py>=2 && py<=13)
	 	begin 
 		if(enemieshit >= 7'd50)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end



	 	else if ((px >= 15 && px <=16 && py==7) || (px >= 20 && px<= 21 && py==7))
	 	begin 
 		if(lifecount >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 14 && px <=17 && py==8) || (px >= 19 && px<= 22 && py==8))
 		begin
 		if(lifecount >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 14 && px <=22 && py==9)
 		begin
 		if(lifecount >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 15 && px<= 21 && py==10)
 		begin
 		if(lifecount >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 16 && px<= 20 && py==11)
 		begin
 		if(lifecount >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 17 &&px<= 19 && py==12)
 		begin
 		if(lifecount >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 18 && py==13)
 		begin
 		if(lifecount >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 25 && px <=26 && py==7) || (px >= 30 && px<= 31 && py==7))
	 	begin 
 		if(lifecount >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 24 && px <=27 && py==8) || (px >= 29 && px<= 32 && py==8))
 		begin
 		if(lifecount >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 24 && px <=32 && py==9)
 		begin
 		if(lifecount >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 25 && px<= 31 && py==10)
 		begin
 		if(lifecount >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 26 && px<= 30 && py==11)
 		begin
 		if(lifecount >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 27 &&px<= 29 && py==12)
 		begin
 		if(lifecount >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 28 && py==13)
 		begin
 		if(lifecount >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of second heart
			else if ((px >= 35 && px <=36 && py==7) || (px >= 40 && px<= 41 && py==7))
	 	begin 
 		if(lifecount >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 34 && px <=37 && py==8) || (px >= 39 && px<= 42 && py==8))
 		begin
 		if(lifecount >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 34 && px <=42 && py==9)
 		begin
 		if(lifecount >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 35 && px<= 41 && py==10)
 		begin
 		if(lifecount >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 36 && px<= 40 && py==11)
 		begin
 		if(lifecount >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 37 &&px<= 39 && py==12)
 		begin
 		if(lifecount >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 38 && py==13)
 		begin
 		if(lifecount >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of third heart
	else if ((px >= 45 && px <=46 && py==7) || (px >= 50 && px<= 51 && py==7))
	 	begin 
 		if(lifecount >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 44 && px <=47 && py==8) || (px >= 49 && px<= 52 && py==8))
 		begin
 		if(lifecount >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 44 && px <=52 && py==9)
 		begin
 		if(lifecount >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 45 && px<= 51 && py==10)
 		begin
 		if(lifecount >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 46 && px<= 50 && py==11)
 		begin
 		if(lifecount >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 47 &&px<= 49 && py==12)
 		begin
 		if(lifecount >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 48 && py==13)
 		begin
 		if(lifecount >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of the forth heart
	else if ((px >= 55 && px <=56 && py==7) || (px >= 60 && px<= 61 && py==7))
	 	begin 
 		if(lifecount >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 54 && px <=57 && py==8) || (px >= 59 && px<= 62 && py==8))
 		begin
 		if(lifecount >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 54 && px <=62 && py==9)
 		begin
 		if(lifecount >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 55 && px<= 61 && py==10)
 		begin
 		if(lifecount >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 56 && px<= 60 && py==11)
 		begin
 		if(lifecount >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 57 &&px<= 59 && py==12)
 		begin
 		if(lifecount >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 58 && py==13)
 		begin
 		if(lifecount >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of fifth heart
			else if ((px >= 65 && px <=66 && py==7) || (px >= 70 && px<= 71 && py==7))
	 	begin 
 		if(lifecount >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 64 && px <=67 && py==8) || (px >= 69 && px<= 72 && py==8))
 		begin
 		if(lifecount >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 64 && px <=72 && py==9)
 		begin
 		if(lifecount >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 65 && px<= 71 && py==10)
 		begin
 		if(lifecount >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 66 && px<= 70 && py==11)
 		begin
 		if(lifecount >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 67 &&px<= 69 && py==12)
 		begin
 		if(lifecount >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 68 && py==13)
 		begin
 		if(lifecount >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of 6th heart

	else if ((px >= 75 && px <=76 && py==7) || (px >= 80 && px<= 81 && py==7))
	 	begin 
 		if(lifecount >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 74 && px <=77 && py==8) || (px >= 79 && px<= 82 && py==8))
 		begin
 		if(lifecount >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 74 && px <=82 && py==9)
 		begin
 		if(lifecount >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 75 && px<= 81 && py==10)
 		begin
 		if(lifecount >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 76 && px<= 80 && py==11)
 		begin
 		if(lifecount >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 77 &&px<= 79 && py==12)
 		begin
 		if(lifecount >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 78 && py==13)
 		begin
 		if(lifecount >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end


		 else if (px <= Xleftboarder || py <= Ytopboarder) 
			begin
				valid <=1'b1; 
			end
		
		else if (px >= Xrightboarder || py >= Ybottomboarder) 
			begin
				valid <= 1'b1;
			end
		else if (px >= xpos && px <= xpos+5 && py>= ypos && py <= ypos+5) 
			begin
				valid =  1'b1;
			end
		else if (((px >= 125 && px<= 275) || (px>=350 && px<= 500)) && py>=100 && py<=110) 
			begin 
				valid <= 1'b1;
			end
		else if (((px >= 125 && px<= 275) || (px>=350 && px<= 500)) && py>=200 && py<=210) 
			begin
				valid <= 1'b1;
			end 
		else if (((px >= 125 && px<= 275) || (px>=350 && px<= 500)) && py>=300 && py<=310) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= enemyxpos && px<= enemyxpos+5 && py >= enemyypos && py<= enemyypos+5) 
			begin
				valid <= 1'b1;
			end 
	else if (px >= enemyxpos1 && px<= enemyxpos1+5 && py >= enemyypos1 && py<= enemyypos1+5)
			begin
				valid <= 1'b1;
			end 	
		else if (px >= enemyxpos2 && px<= enemyxpos2+5&& py >= enemyypos2 && py<= enemyypos2+5) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= enemyxpos3 && px<= enemyxpos3+5 && py >= enemyypos3 && py<= enemyypos3+5) 
			begin
				valid <= 1'b1;
			end 
		//sword stuff
		//sword up
		else if (px >= xpos+2 && px <= xpos+3 && py>= ypos-3 && py <= ypos && sw6 == 1'b1) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos-1 && px <= xpos+6 && py>= ypos-4 && py <= ypos-3 && sw6 == 1'b1) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos+2 && px <= xpos+3 && py>= ypos-13 && py <= ypos-4 && sw6 == 1'b1) 
			begin
				valid <= 1'b1;
			end	
		//sword right
		else if (px >= xpos && px <= xpos+8 && py>= ypos+2 && py <= ypos+3 && sw7 == 1'b1) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos+8 && px <= xpos+9 && py>= ypos-1 && py <= ypos+6 && sw7 == 1'b1) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos+9 && px <= xpos+18 && py>= ypos+2 && py <= ypos+3 && sw7 == 1'b1) 
			begin
				valid <= 1'b1;
			end
		//sword down 
		else if (px >= xpos+2 && px <= xpos+3 && py>= ypos && py <= ypos+8 && sw8 == 1'b1) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos-1 && px <= xpos+6 && py>= ypos+8 && py <= ypos+9 && sw8 == 1'b1) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos+2 && px <= xpos+3 && py>= ypos+9 && py <= ypos+18 && sw8 == 1'b1) 
			begin
				valid <= 1'b1;
			end		
		//sword left 
			else if (px >= xpos-3 && px <= xpos && py>= ypos+2 && py <= ypos+3 && sw9 == 1'b1) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos-4 && px <= xpos-3 && py>= ypos-1 && py <= ypos+6 && sw9 == 1'b1) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos-13 && px <= xpos-4 && py>= ypos+2 && py <= ypos+3 && sw9 == 1'b1) 
			begin
				valid <= 1'b1;
			end
		else valid <= 1'b0; 
	end
else if(key2==1) //key1 maze
	begin 
		rom_mux_output = 7'b1;
		if(px>= 15 && px <= 17 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 19 && px <= 21 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 23 && px <= 25 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 27 && px <= 29 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 31 && px <= 33 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 35 && px <= 37 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 39 && px <= 41 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 43 && px <= 45 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd8)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 47 && px <= 49 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd9)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 51 && px <= 53 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd10)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 55 && px <= 57 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd11)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 59 && px <= 61 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd12)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 63 && px <= 65 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd13)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 67 && px <= 69 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd14)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 71 && px <= 73 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd15)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 75 && px <= 77 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd16)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 79 && px <= 81 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd17)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 83 && px <= 85 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd18)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 87 && px <= 89 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd19)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 91 && px <= 93 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd20)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 95 && px <= 97 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd21)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 99 && px <= 101 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd22)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 103 && px <= 105 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd23)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 107 && px <= 109 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd24)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 111 && px <= 113 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd25)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 115 && px <= 117 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd26)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 119 && px <= 121 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd27)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 123 && px <= 125 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd28)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 127 && px <= 129 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd29)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 131 && px <= 133 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd30)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 135 && px <= 137 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd31)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 139 && px <= 141 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd32)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 143 && px <= 145 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd33)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 147 && px <= 149 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd34)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 151 && px <= 153 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd35)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 155 && px <= 157 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd36)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 159 && px <= 161 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd37)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 163 && px <= 165 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd38)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 167 && px <= 169 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd39)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 171 && px <= 173 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd40)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 175 && px <= 177 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd41)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 179 && px <= 181 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd42)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 183 && px <= 185 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd43)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 187 && px <= 189 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd44)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 191 && px <= 193 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd45)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 195 && px <= 197 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd46)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 199 && px <= 201 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd47)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 203 && px <= 205 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd48)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 207 && px <= 209 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd49)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 211 && px <= 213 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd50)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 215 && px <= 217 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd51)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 219 && px <= 221 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd52)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 223 && px <= 225 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd53)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 227 && px <= 229 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd54)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 231 && px <= 233 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd55)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 235 && px <= 237 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd56)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 239 && px <= 241 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd57)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 243 && px <= 245 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd58)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 247 && px <= 249 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd59)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 251 && px <= 253 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd60)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 255 && px <= 257 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd61)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 259 && px <= 261 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd62)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 263 && px <= 265 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd63)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 267 && px <= 269 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd64)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 271 && px <= 273 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd65)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 275 && px <= 277 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd66)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 279 && px <= 281 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd67)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 283 && px <= 285 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd68)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 287 && px <= 289 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd69)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 291 && px <= 293 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd70)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 295 && px <= 297 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd71)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 299 && px <= 301 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd72)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 303 && px <= 305 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd73)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 307 && px <= 309 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd74)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 311 && px <= 313 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd75)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 315 && px <= 317 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd76)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 319 && px <= 321 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd77)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 323 && px <= 325 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd78)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 327 && px <= 329 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd79)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 331 && px <= 333 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd80)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 335 && px <= 337 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd81)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 339 && px <= 341 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd82)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 343 && px <= 345 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd83)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 347 && px <= 349 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd84)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 351 && px <= 353 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd85)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 355 && px <= 357 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd86)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 359 && px <= 361 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd87)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 363 && px <= 365 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd88)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 367 && px <= 369 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd89)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 371 && px <= 373 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd90)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 375 && px <= 377 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd91)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 379 && px <= 381 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd92)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 383 && px <= 385 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd93)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 387 && px <= 389 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd94)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 391 && px <= 393 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd95)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 395 && px <= 397 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd96)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 399 && px <= 401 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd97)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 403 && px <= 405 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd98)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 407 && px <= 409 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd99)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 411 && px <= 413 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd100)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 415 && px <= 417 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd101)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 419 && px <= 421 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd102)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 423 && px <= 425 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd103)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 427 && px <= 429 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd104)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 431 && px <= 433 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd105)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 435 && px <= 437 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd106)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 439 && px <= 441 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd107)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 443 && px <= 445 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd108)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 447 && px <= 449 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd109)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 451 && px <= 453 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd110)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 455 && px <= 457 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd111)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 459 && px <= 461 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd112)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 463 && px <= 465 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd113)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 467 && px <= 469 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd114)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 471 && px <= 473 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd115)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 475 && px <= 477 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd116)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 479 && px <= 481 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd117)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 483 && px <= 485 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd118)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 487 && px <= 489 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd119)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 491 && px <= 493 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd120)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 495 && px <= 497 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd121)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 499 && px <= 501 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd122)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 503 && px <= 505 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd123)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 507 && px <= 509 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd124)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 511 && px <= 513 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd125)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 515 && px <= 517 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd126)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 519 && px <= 521 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd127)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 523 && px <= 525 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd128)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 527 && px <= 529 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd129)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 531 && px <= 533 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd130)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 535 && px <= 537 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd131)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 539 && px <= 541 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd132)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 543 && px <= 545 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd133)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 547 && px <= 549 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd134)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 551 && px <= 553 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd135)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 555 && px <= 557 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd136)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 559 && px <= 561 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd137)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 563 && px <= 565 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd138)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 567 && px <= 569 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd139)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 571 && px <= 573 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd140)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 575 && px <= 577 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd141)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 579 && px <= 581 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd142)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 583 && px <= 585 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd143)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 587 && px <= 589 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd144)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 591 && px <= 593 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd145)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 595 && px <= 597 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd146)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 599 && px <= 601 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd147)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 603 && px <= 605 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd148)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 607 && px <= 609 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd149)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 611 && px <= 613 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd150)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 615 && px <= 617 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd151)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 619 && px <= 621 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd152)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 623 && px <= 625 && py>=2 && py<=13)
	 	begin 
 		if(mazecounter >= 32'd153)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 15 && px <= 17 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd154)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 19 && px <= 21 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd155)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 23 && px <= 25 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd156)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 27 && px <= 29 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd157)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 31 && px <= 33 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd158)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 35 && px <= 37 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd159)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 39 && px <= 41 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd160)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 43 && px <= 45 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd161)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 47 && px <= 49 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd162)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 51 && px <= 53 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd163)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 55 && px <= 57 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd164)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 59 && px <= 61 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd165)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 63 && px <= 65 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd166)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 67 && px <= 69 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd167)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 71 && px <= 73 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd168)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 75 && px <= 77 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd169)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 79 && px <= 81 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd170)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 83 && px <= 85 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd171)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 87 && px <= 89 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd172)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 91 && px <= 93 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd173)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 95 && px <= 97 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd174)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 99 && px <= 101 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd175)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 103 && px <= 105 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd176)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 107 && px <= 109 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd177)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 111 && px <= 113 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd178)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 115 && px <= 117 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd179)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 119 && px <= 121 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd180)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 123 && px <= 125 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd181)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 127 && px <= 129 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd182)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 131 && px <= 133 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd183)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 135 && px <= 137 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd184)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 139 && px <= 141 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd185)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 143 && px <= 145 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd186)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 147 && px <= 149 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd187)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 151 && px <= 153 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd188)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 155 && px <= 157 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd189)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 159 && px <= 161 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd190)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 163 && px <= 165 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd191)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 167 && px <= 169 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd192)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 171 && px <= 173 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd193)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 175 && px <= 177 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd194)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 179 && px <= 181 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd195)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 183 && px <= 185 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd196)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 187 && px <= 189 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd197)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 191 && px <= 193 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd198)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 195 && px <= 197 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd199)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 199 && px <= 201 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd200)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 203 && px <= 205 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd201)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 207 && px <= 209 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd202)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 211 && px <= 213 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd203)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 215 && px <= 217 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd204)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 219 && px <= 221 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd205)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 223 && px <= 225 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd206)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 227 && px <= 229 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd207)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 231 && px <= 233 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd208)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 235 && px <= 237 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd209)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 239 && px <= 241 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd210)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 243 && px <= 245 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd211)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 247 && px <= 249 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd212)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 251 && px <= 253 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd213)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 255 && px <= 257 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd214)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 259 && px <= 261 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd215)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 263 && px <= 265 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd216)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 267 && px <= 269 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd217)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 271 && px <= 273 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd218)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 275 && px <= 277 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd219)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 279 && px <= 281 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd220)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 283 && px <= 285 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd221)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 287 && px <= 289 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd222)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 291 && px <= 293 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd223)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 295 && px <= 297 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd224)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 299 && px <= 301 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd225)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 303 && px <= 305 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd226)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 307 && px <= 309 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd227)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 311 && px <= 313 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd228)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 315 && px <= 317 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd229)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 319 && px <= 321 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd230)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 323 && px <= 325 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd231)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 327 && px <= 329 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd232)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 331 && px <= 333 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd233)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 335 && px <= 337 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd234)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 339 && px <= 341 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd235)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 343 && px <= 345 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd236)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 347 && px <= 349 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd237)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 351 && px <= 353 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd238)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 355 && px <= 357 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd239)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 359 && px <= 361 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd240)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 363 && px <= 365 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd241)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 367 && px <= 369 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd242)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 371 && px <= 373 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd243)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 375 && px <= 377 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd244)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 379 && px <= 381 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd245)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 383 && px <= 385 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd246)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 387 && px <= 389 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd247)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 391 && px <= 393 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd248)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 395 && px <= 397 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd249)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 399 && px <= 401 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd250)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 403 && px <= 405 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd251)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 407 && px <= 409 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd252)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 411 && px <= 413 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd253)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 415 && px <= 417 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd254)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 419 && px <= 421 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd255)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 423 && px <= 425 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd256)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 427 && px <= 429 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd257)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 431 && px <= 433 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd258)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 435 && px <= 437 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd259)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 439 && px <= 441 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd260)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 443 && px <= 445 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd261)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 447 && px <= 449 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd262)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 451 && px <= 453 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd263)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 455 && px <= 457 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd264)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 459 && px <= 461 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd265)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 463 && px <= 465 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd266)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 467 && px <= 469 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd267)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 471 && px <= 473 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd268)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 475 && px <= 477 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd269)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 479 && px <= 481 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd270)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 483 && px <= 485 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd271)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 487 && px <= 489 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd272)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 491 && px <= 493 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd273)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 495 && px <= 497 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd274)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 499 && px <= 501 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd275)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 503 && px <= 505 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd276)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 507 && px <= 509 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd277)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 511 && px <= 513 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd278)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 515 && px <= 517 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd279)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 519 && px <= 521 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd280)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 523 && px <= 525 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd281)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 527 && px <= 529 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd282)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 531 && px <= 533 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd283)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 535 && px <= 537 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd284)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 539 && px <= 541 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd285)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 543 && px <= 545 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd286)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 547 && px <= 549 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd287)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 551 && px <= 553 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd288)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 555 && px <= 557 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd289)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 559 && px <= 561 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd290)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 563 && px <= 565 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd291)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 567 && px <= 569 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd292)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 571 && px <= 573 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd293)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 575 && px <= 577 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd294)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 579 && px <= 581 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd295)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 583 && px <= 585 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd296)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 587 && px <= 589 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd297)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 591 && px <= 593 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd298)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 595 && px <= 597 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd299)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 599 && px <= 601 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd300)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 603 && px <= 605 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd301)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 607 && px <= 609 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd302)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 611 && px <= 613 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd303)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 615 && px <= 617 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd304)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 619 && px <= 621 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd305)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 623 && px <= 625 && py>=467 && py<=478)
	 	begin 
 		if(mazecounter >= 32'd306)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end


	 	
						else if((px>=0)&&(px<=15))
							valid <=1'b1;		
						else if((px>=625)&&(px<=640))
							valid <=1'b1;
						else if((py>=0)&&(py<=15))
							valid <=1'b1;
						else if((py>=465)&&(py<=480))
							valid <=1'b1;
						else if(((py>=30)&&(py<=45))&&(((px>=60)&&(px<=330))||((px>=360)&&(px<=585))))
							valid <=1'b1;
						else if(((py>=60)&&(py<=75))&&((px>=45)&&(px<=600)))
							valid <=1'b1;
						else if(((py>=90)&&(py<=105))&&((px<=165)||((px>=195)&&(px<=375))||(px>=405)))
							valid <=1'b1;
						else if(((py>=120)&&(py<=135))&&((px<=255)||(px>=285)))
							valid <=1'b1;
						else if(((py>=165)&&(py<=180))&&((px<=60)||((px>=90)&&(px<=615))))
							valid <=1'b1;
						else if(((py>=195)&&(py<=210))&&((px<=570)||(px>=600)))
							valid <=1'b1;
						else if(((py>=225)&&(py<=240))&&((px<=285)||(px>=345)))
							valid <=1'b1;
						else if(((py>=255)&&(py<=270))&&((px<=225)||(px>=255)))
							valid <=1'b1;
						else if(((py>=285)&&(py<=300))&&((px<=45)||(px>=75)))
							valid <=1'b1;
						else if(((py>=315)&&(py<=330))&&((px<=195)||(px>=225)))
							valid <=1'b1;
						else if(((py>=345)&&(py<=360))&&((px<=60)||(px>=90)))
							valid <=1'b1;
						else if(((py>=375)&&(py<=390))&&((px<=435)||(px>=465)))
							valid <=1'b1;
						else if(((py>=405)&&(py<=420))&&((px<=330)||(px>=360)))
							valid <=1'b1;
						else if(((py>=435)&&(py<=450))&&(((px>=60)&&(px<=390))||((px>=420)&&(px<=585))))
							valid <=1'b1;
						//Block
						else if (px>= xpos && px<=xpos+5&& py>=ypos && py<=ypos+5) 
							valid <=1'b1;
						//END
						else if ((py==35)&&(((px>=595)&&(px<=599))||(px==601)||(px==605)|((px>=607)&&(px<=608))))
							valid <=1'b1;
						else if ((py==36)&&(((px==595))||(px==601)||(px==602)||(px==605)||(px==607)||(px==609)))
							valid <=1'b1;
						else if ((py==37)&&(((px>=595)&&(px<=597))||(px==601)||(px==603)||(px==605)||(px==607)||(px==610)))
							valid <=1'b1;
						else if ((py==38)&&(((px==595)||(px==601)||(px==604)||(px==605)||(px==607)||(px==609))))
							valid <=1'b1;
						else if ((py==39)&&(((px>=595)&&(px<=599))||(px==601)||(px==605)||(px==607)||(px==608)))
							valid <=1'b1;
						else
							valid <=1'b0;
	end 
else if (key1==1) //key0 welcome screen
	begin 
		if (px>=64*8) valid <= 1'b0;
	else if (py>=16*16) valid <= 1'b0;
	else valid <= 1'b1;
	
	case (px[2:0])
	0: rom_mux_output = q[0];
	1: rom_mux_output = q[7];
	2: rom_mux_output = q[6];
	3: rom_mux_output = q[5];
	4: rom_mux_output = q[4];
	5: rom_mux_output = q[3];
	6: rom_mux_output = q[2];
	7: rom_mux_output = q[1];
	endcase
	end
else if (key4 == 1) //key3 PVP
	begin 
		rom_mux_output = 7'b1;
		if(px>= 623 && px <= 625 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 619 && px <= 621 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 615 && px <= 617 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 611 && px <= 613 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 607 && px <= 609 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 603 && px <= 605 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 599 && px <= 601 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 595 && px <= 597 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd8)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 591 && px <= 593 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd9)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 587 && px <= 589 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd10)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 583 && px <= 585 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd11)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 579 && px <= 581 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd12)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 575 && px <= 577 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd13)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 571 && px <= 573 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd14)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 567 && px <= 569 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd15)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 563 && px <= 565 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd16)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 559 && px <= 561 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd17)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 555 && px <= 557 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd18)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 551 && px <= 553 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd19)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 547 && px <= 549 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd20)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 543 && px <= 545 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd21)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 539 && px <= 541 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd22)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 535 && px <= 537 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd23)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 531 && px <= 533 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd24)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 527 && px <= 529 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd25)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 523 && px <= 525 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd26)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 519 && px <= 521 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd27)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 515 && px <= 517 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd28)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 511 && px <= 513 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd29)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 507 && px <= 509 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd30)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 503 && px <= 505 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd31)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 499 && px <= 501 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd32)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 495 && px <= 497 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd33)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 491 && px <= 493 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd34)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 487 && px <= 489 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd35)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 483 && px <= 485 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd36)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 479 && px <= 481 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd37)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 475 && px <= 477 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd38)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 471 && px <= 473 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd39)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 467 && px <= 469 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd40)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 463 && px <= 465 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd41)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 459 && px <= 461 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd42)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 455 && px <= 457 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd43)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 451 && px <= 453 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd44)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 447 && px <= 449 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd45)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 443 && px <= 445 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd46)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 439 && px <= 441 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd47)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 435 && px <= 437 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd48)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 431 && px <= 433 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd49)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if(px>= 427 && px <= 429 && py>=2 && py<=13)
	 	begin 
 		if(pvpkills >= 7'd50)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end

		else if ((px >= 15 && px <=16 && py==7) || (px >= 20 && px<= 21 && py==7))
	 	begin 
 		if(pvplives >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 14 && px <=17 && py==8) || (px >= 19 && px<= 22 && py==8))
 		begin
 		if(pvplives >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 14 && px <=22 && py==9)
 		begin
 		if(pvplives >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 15 && px<= 21 && py==10)
 		begin
 		if(pvplives >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 16 && px<= 20 && py==11)
 		begin
 		if(pvplives >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 17 &&px<= 19 && py==12)
 		begin
 		if(pvplives >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 18 && py==13)
 		begin
 		if(pvplives >= 7'd1)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 25 && px <=26 && py==7) || (px >= 30 && px<= 31 && py==7))
	 	begin 
 		if(pvplives >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 24 && px <=27 && py==8) || (px >= 29 && px<= 32 && py==8))
 		begin
 		if(pvplives >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 24 && px <=32 && py==9)
 		begin
 		if(pvplives >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 25 && px<= 31 && py==10)
 		begin
 		if(pvplives >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 26 && px<= 30 && py==11)
 		begin
 		if(pvplives >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 27 &&px<= 29 && py==12)
 		begin
 		if(pvplives >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 28 && py==13)
 		begin
 		if(pvplives >= 7'd2)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of second heart
			else if ((px >= 35 && px <=36 && py==7) || (px >= 40 && px<= 41 && py==7))
	 	begin 
 		if(pvplives >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 34 && px <=37 && py==8) || (px >= 39 && px<= 42 && py==8))
 		begin
 		if(pvplives >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 34 && px <=42 && py==9)
 		begin
 		if(pvplives >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 35 && px<= 41 && py==10)
 		begin
 		if(pvplives >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 36 && px<= 40 && py==11)
 		begin
 		if(pvplives >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 37 &&px<= 39 && py==12)
 		begin
 		if(pvplives >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 38 && py==13)
 		begin
 		if(pvplives >= 7'd3)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of third heart
	else if ((px >= 45 && px <=46 && py==7) || (px >= 50 && px<= 51 && py==7))
	 	begin 
 		if(pvplives >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 44 && px <=47 && py==8) || (px >= 49 && px<= 52 && py==8))
 		begin
 		if(pvplives >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 44 && px <=52 && py==9)
 		begin
 		if(pvplives >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 45 && px<= 51 && py==10)
 		begin
 		if(pvplives >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 46 && px<= 50 && py==11)
 		begin
 		if(pvplives >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 47 &&px<= 49 && py==12)
 		begin
 		if(pvplives >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 48 && py==13)
 		begin
 		if(pvplives >= 7'd4)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of the forth heart
	else if ((px >= 55 && px <=56 && py==7) || (px >= 60 && px<= 61 && py==7))
	 	begin 
 		if(pvplives >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 54 && px <=57 && py==8) || (px >= 59 && px<= 62 && py==8))
 		begin
 		if(pvplives >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 54 && px <=62 && py==9)
 		begin
 		if(pvplives >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 55 && px<= 61 && py==10)
 		begin
 		if(pvplives >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 56 && px<= 60 && py==11)
 		begin
 		if(pvplives >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 57 &&px<= 59 && py==12)
 		begin
 		if(pvplives >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 58 && py==13)
 		begin
 		if(pvplives >= 7'd5)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of fifth heart
			else if ((px >= 65 && px <=66 && py==7) || (px >= 70 && px<= 71 && py==7))
	 	begin 
 		if(pvplives >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 64 && px <=67 && py==8) || (px >= 69 && px<= 72 && py==8))
 		begin
 		if(pvplives >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 64 && px <=72 && py==9)
 		begin
 		if(pvplives >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 65 && px<= 71 && py==10)
 		begin
 		if(pvplives >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 66 && px<= 70 && py==11)
 		begin
 		if(pvplives >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 67 &&px<= 69 && py==12)
 		begin
 		if(pvplives >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 68 && py==13)
 		begin
 		if(pvplives >= 7'd6)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end //end of 6th heart

	else if ((px >= 75 && px <=76 && py==7) || (px >= 80 && px<= 81 && py==7))
	 	begin 
 		if(pvplives >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if ((px >= 74 && px <=77 && py==8) || (px >= 79 && px<= 82 && py==8))
 		begin
 		if(pvplives >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 74 && px <=82 && py==9)
 		begin
 		if(pvplives >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 75 && px<= 81 && py==10)
 		begin
 		if(pvplives >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 76 && px<= 80 && py==11)
 		begin
 		if(pvplives >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px >= 77 &&px<= 79 && py==12)
 		begin
 		if(pvplives >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
	else if (px == 78 && py==13)
 		begin
 		if(pvplives >= 7'd7)
		 valid <= 1'b0;
		else
		 valid <=1'b1;
 		end
			else if (px <= Xleftboarder || py <= Ytopboarder) 
				begin
					valid <= 1'b1;
				end 
			else if ((px >=15 && px<= 20 && py >= 10 && py <=15)  )
				begin 
					valid <= 1'b0;
				end
			else if (px>=coopxpos && px <=coopxpos+5 && py>= coopypos && py <= coopypos+5) 
				begin
					valid <= 1'b1;
				end 
			else if (px >= xpos && px <= xpos+5 && py>= ypos && py <= ypos+5)
				begin
					valid <= 1'b1;
				end 
			else if (px >= Xrightboarder || py >= Ybottomboarder) 
				begin
					valid <= 1'b1;
				end 
			else if (px >= xpos && px <= xpos+5 && py>= ypos && py <= ypos+5) 
			begin
				valid =  1'b1;
			end
		else if (((px >= 125 && px<= 275) || (px>=350 && px<= 500)) && py>=100 && py<=110) 
			begin 
				valid <= 1'b1;
			end
		else if (((px >= 125 && px<= 275) || (px>=350 && px<= 500)) && py>=200 && py<=210) 
			begin
				valid <= 1'b1;
			end 
		else if (((px >= 125 && px<= 275) || (px>=350 && px<= 500)) && py>=300 && py<=310) 
			begin
				valid <= 1'b1;
			end
		else if (px >= xpos && px <= xpos+8 && py>= ypos+2 && py <= ypos+3) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos+8 && px <= xpos+9 && py>= ypos-1 && py <= ypos+6) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= xpos+9 && px <= xpos+18 && py>= ypos+2 && py <= ypos+3) 
			begin
				valid <= 1'b1;
			end
		else if (px>=coopxpos && px <=coopxpos+8 && py>= coopypos+2 && py <= coopypos+3) 
				begin
					valid <= 1'b1;
				end 
		else if (px>=coopxpos+8 && px <=coopxpos+9 && py>= coopypos-1 && py <= coopypos+6) 
				begin
					valid <= 1'b1;
				end 
		else if (px>=coopxpos+9 && px <=coopxpos+18 && py>= coopypos+2 && py <= coopypos+3) 
				begin
					valid <= 1'b1;
				end 
		else 
				begin
					valid <= 1'b0;
				end
		end
else if (key5==1) //key 6 tower defense 
	begin 
	rom_mux_output <= 1'b1;
			if (px >= aix && px <= aix+5 && py >= aiy && py <= aiy+5)
			begin 
				valid <= 1'b0; 
			end 
		else if ((px >= aix1 && px <= aix1+5 && py >= aiy1 && py <= aiy1+5))
			begin 
				valid <= 1'b0;
			end 
		else if (px >= aix2 && px <= aix2+5 && py >= aiy2 && py <= aiy2+5) 
			begin 
			valid <= 1'b0;
			end 
		else if(px>= 623 && px <= 625 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd1)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 619 && px <= 621 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd2)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 615 && px <= 617 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd3)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 611 && px <= 613 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd4)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 607 && px <= 609 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd5)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 603 && px <= 605 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd6)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 599 && px <= 601 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd7)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 595 && px <= 597 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd8)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 591 && px <= 593 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd9)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if(px>= 587 && px <= 589 && py>=2 && py<=13)
	 	begin 
 		if(towerscore >= 7'd10)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
		else if (px >= 0 && px <=  175 && py>= 360 && py <= 380) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= 180 && px<= 185 && py >= 370 && py <= 375)
			begin 
			valid =1'b0;
			end
		else if (px >= 155 && px <= 175 && py>= 120 && py <= 380) 
			begin
				valid <= 1'b1;
			end 
		else if (px >= 155 && px <= 485 && py>= 120 && py <= 140)
			begin 
				valid <=1'b1;
			end 
		else if (px >= 465 && px <= 485 && py>= 0 && py <= 140)
			begin 
				valid <=1'b1;
			end
		else if (px>=  185 && px <= 195 && py>= 362 && py <= 372 && sw10 == 1'b1 && towerscore >= 2)
			begin 
			towerscore <= towerscore - 1'd2;
			valid <= 1'b1;
			end 
		else if (px>=  490 && px <= 500 && py>= 128 && py <= 138 && sw11 == 1'b1 && towerscore >= 7'd2)
			begin 
			towerscore <= towerscore - 1'd2;
			valid <= 1'b1;
			end 
		else if (px>=  135 && px <= 145 && py>= 128 && py <= 138 && sw12 == 1'b1 && towerscore >= 7'd2)
			begin 
			towerscore <= towerscore - 1'd2;
			valid <= 1'b1;
			end 
		else if (px>=  485 && px <= 465 && py>= 132 && py <= 142 && sw13 == 1'b1 && towerscore >= 7'd2)
			begin 
			towerscore <= towerscore - 1'd2;
			valid <= 1'b1;
			end 
		else if ((px >= 15 && px <=16 && py==7) || (px >= 20 && px<= 21 && py==7))
	 	begin 
 		if(towerlife >= 7'd1)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if ((px >= 14 && px <=17 && py==8) || (px >= 19 && px<= 22 && py==8))
 		begin
 		if(towerlife >= 7'd1)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if (px >= 14 && px <=22 && py==9)
 		begin
 		if(towerlife >= 7'd1)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if (px >= 15 && px<= 21 && py==10)
 		begin
 		if(towerlife >= 7'd1)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if (px >= 16 && px<= 20 && py==11)
 		begin
 		if(towerlife >= 7'd1)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if (px >= 17 &&px<= 19 && py==12)
 		begin
 		if(towerlife >= 7'd1)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
	else if (px == 18 && py==13)
 		begin
 		if(towerlife >= 7'd1)
		 valid <= 1'b1;
		else
		 valid <=1'b0;
 		end
		else
			valid <=1'b0;
	end 
		end 
//
reg [2:0] pos; 
//enemy movment for tower defense 
always@(posedge clk or negedge rst)
	begin
		if(rst == 1'b0)
			begin
			towerlife <= 7'd1;
			towerscore <= 7'd2;
			aix <= 0;
			aiy <= 367;
			aix1 <= 5;
			aiy1 <= 367;
			aix2 <= 10;
			aiy2 <= 367;
			pos <= 2'd0;
			end
		else if (towerlife <= 0) 
			begin 
			towerlife <= 7'd1;
			towerscore <= 7'd2;
			aix <= 0;
			aiy <= 367;
			aix1 <= 7;
			aiy1 <= 367;
			aix2 <= 13;
			aiy2 <= 367;
			pos <= 2'd0; 
			end 
		else if (pos == 1)
			begin 
			towerlife <= towerlife;
			towerscore <= towerscore;
			pos <= 2'd0;
			aix <= 0;
			aiy <= 367;
			aix1 <= 10;
			aiy1 <= 367;
			aix2 <= 15;
			aiy2 <= 367;
			end 
		else if (count5<TIMER)
			begin
			count5<=count5+7'd30;

			end 
		else 
			begin 
			count5 <= 0;
			if(rst==1'b1) 
			+6++6
			451
			begin 
				if(aix < 163 )
					begin 
					aix <= aix + 1'b1;
					aiy <= aiy;
					end 
				else if (aiy > 124)
					begin 
					aiy <= aiy - 1'b1; 
					aix <= aix; 
					end
				else if (aix < 472) 
					begin 
					aix <= aix + 1'b1; 
					aiy <= aiy; 
					end 
				else if (aiy >= 0)
					begin 
					aix <= aix; 
					aiy <= aiy - 1'b1; 	
					end 
				if(aix1 < 163 )
					begin 
					aix1 <= aix1 + 1'b1;
					aiy1 <= aiy1;
					end 
				else if (aiy1 > 124)
					begin 
					aiy1 <= aiy1 - 1'b1; 
					aix1 <= aix1; 
					end
				else if (aix1 < 472) 
					begin 
					aix1 <= aix1 + 1'b1; 
					aiy1 <= aiy1; 
					end 
				else if (aiy >= 0)
					begin 
					aix1 <= aix1; 
					aiy1 <= aiy1 - 1'b1; 
					end
				if(aix2 < 163 )
					begin 
					aix2 <= aix2 + 1'b1;
					aiy2 <= aiy2;
					end 
				else if (aiy2 > 124)
					begin 
					aiy2 <= aiy2 - 1'b1; 
					aix2 <= aix2; 
					end
				else if (aix2 < 472) 
					begin 
					aix2 <= aix2 + 1'b1; 
					aiy2 <= aiy2; 
					end 
				else if (aiy2 >= 0)
					begin 
					aix2 <= aix2; 
					aiy2 <= aiy2 - 1'b1; 
					end 
				end 
				if(aiy == 0 || aiy1 == 0 || aiy2 == 0)
				begin 
				towerlife <= 0; 
				end 
				if(aiy == 0 && aiy1 == 0 && aiy2 == 0)
				begin 
				towerlife <= 0; 
				pos <= 2'd0;
				end 
			end 
end  


//assigns pixel vaild location and sends xpos and ypos for the PvP function 
//sends out the number of kills the player has (against AI) to the hex 
assign pixel = rom_mux_output;
assign sendxpos = xpos; 
assign sendypos = ypos;
assign enemyhitcount = enemieshit; 

endmodule
