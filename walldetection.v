module walldetection(
input [9:0] xposition1, 
input  [9:0] yposition1, 
input key2,
input key3, 
input key4,
output xpos, 
output ypos
);
reg [9:0] xposition;
reg [9:0] yposition;

// key4 == PvP
//key3 == PvE
//key2 == Maze
//Barrier Construction-Making the walls of the maze
always 
 begin
 yposition <= yposition1;
xposition <= xposition1;
if(key2==1'b1)
	begin
					//Left Wall
						if(xposition ==15)
							xposition <=xposition+1;
					//Top Wall
						else if(yposition ==15)
							yposition <=yposition+1;
					//Right Wall
						else if(xposition ==620)
							xposition <=xposition-1;
					//Bottom Wall
						else if(yposition ==460)
							yposition <=yposition-1;
					//Row9 Top
						else if((yposition ==25)&&(((xposition >=55)&&(xposition <=330))||((xposition >=355)&&(xposition <=585))))
							yposition <=yposition-1;
					//Row9Bottom
						else if((yposition ==45)&&(((xposition >=55)&&(xposition <=330))||((xposition >=355)&&(xposition <=585))))
							yposition <=yposition+1;
					//Row15Top
						else if((yposition ==55)&&((xposition >=40)&&(xposition <=600)))
							yposition <=yposition-1;
					//Row15Bottom
						else if((yposition ==75)&&((xposition >=40)&&(xposition <=600)))
							yposition <=yposition+1;
					//Row21Top
						else if((yposition ==85)&&(((xposition >=190)&&(xposition <=375))||(xposition <=165)||(xposition >=400)))
							yposition <=yposition-1;
					//Row21Bottom
						else if((yposition ==105)&&(((xposition <=190)&&(375))||(xposition <=165)||(xposition >=400)))
							yposition <=yposition+1;
					//Row27Top
						else if((yposition ==115)&&((xposition <=255)||(xposition >=280)))
							yposition <=yposition-1;
					//Row27Bottom
						else if((yposition ==135)&&((xposition <=255)||(xposition >=280)))	
							yposition <=yposition+1;
					//Row36Top
						else if((yposition ==160)&&((xposition <=60)||((xposition >=85)&&(xposition <=615))))
							yposition <=yposition-1;
					//Row36Bottom
						else if((yposition ==180)&&((xposition <=60)||((xposition >=85)&&(xposition <=615))))
							yposition <=yposition+1;
					//Row42Top
						else if((yposition ==190)&&((xposition <=570)||(xposition >=600)))
							yposition <=yposition-1;
					//Row42Bottom
						else if((yposition ==210)&&((xposition <=570)||(xposition >=600)))	
							yposition <=yposition+1;
					//Row48Top
						else if((yposition ==220)&&((xposition <=285)||(xposition >=345)))
							yposition <=yposition-1;
					//Row48Bottom
						else if((yposition ==240)&&((xposition <=285)||(xposition >=345)))
							yposition <=yposition+1;
					//Row54Top
						else if((yposition ==250)&&((xposition <=225)||(xposition >=255)))
							yposition <=yposition-1;
					//Row54Bottom
						else if((yposition ==270)&&((xposition <=225)||(xposition >=255)))
							yposition <=yposition+1;
					//Row60Top
						else if((yposition ==280)&&((xposition <=47)||(xposition >=70)))
							yposition <=yposition-1;
					//Row60Bottom
						else if((yposition ==300)&&((xposition <=47)||(xposition >=70)))
							yposition <=yposition+1;
					//Row66Top
						else if((yposition ==310)&&((xposition <=195)||(xposition >=225)))
							yposition <=yposition-1;
					//Row66Bottom
						else if((yposition ==330)&&((xposition <=195)||(xposition >=225)))
							yposition <=yposition+1;
					//Row72Top
						else if((yposition ==340)&&((xposition <=60)||(xposition >=90)))
							yposition <=yposition-1;
					//Row72Bottom
						else if((yposition ==360)&&((xposition <=60)||(xposition >=90)))
							yposition <=yposition+1;
					//Row78Top
						else if((yposition ==370)&&((xposition <=435)||(xposition >=460)))
							yposition <=yposition-1;
					//Row78Bottom
						else if((yposition ==390)&&((xposition <=435)||(xposition >=460)))
							yposition <=yposition+1;
					//Row84Top
						else if((yposition ==400)&&((xposition <=330)||(xposition >=355)))
							yposition <=yposition-1;
					//Row84Bottom
						else if((yposition ==420)&&((xposition <=330)||(xposition >=355)))
							yposition <=yposition+1;	
					//Row90Top
						else if((yposition ==430)&&(((xposition >=55)&&(xposition <=390))||((xposition >=415)&&(xposition <=585))))
							yposition <=yposition-1;
					//Row90Bottom
						else if((yposition ==450)&&(((xposition >=55)&&(xposition <=390))||((xposition >=415)&&(xposition <=585))))
							yposition <=yposition+1;	
					//Column9Right
						else if((xposition ==45)&&((yposition >=60)&&(yposition <=75)))
							xposition <=xposition-1;
					//Column9Left
						else if((xposition ==45)&&((yposition >=285)&&(yposition <=300)))
							xposition <=xposition+1;
					//Column12Right
						else if((xposition ==60)&&(((yposition >=30)&&(yposition <=45))||((yposition >=435)&&(yposition <=450))))
							xposition <=xposition-1;
					//Column12Left
						else if((xposition ==60)&&(((yposition >=165)&&(yposition <=180))||((yposition >=345)&&(yposition <=360))))
							xposition <=xposition+1;
					//Column15Right
						else if((xposition ==75)&&((yposition >=285)&&(yposition <=300)))
							xposition <=xposition-1;
					//Column18Right
						else if((xposition ==90)&&(((yposition >=165)&&(yposition <=180))||((yposition >=345)&&(yposition <=360))))
							xposition <=xposition-1;
					//Column33Left
						else if((xposition ==165)&&((yposition >=90)&&(yposition <=105)))
							xposition <=xposition+1;
					//Column39Right
						else if((xposition ==195)&&((yposition >=90)&&(yposition <=105)))
							xposition <=xposition-1;
					//Column39Left
						else if((xposition ==195)&&((yposition >=315)&&(yposition <=330)))
							xposition <=xposition+1;
					//Column45Right
						else if((xposition ==225)&&((yposition >=255)&&(yposition <=270)))
							xposition <=xposition-1;
					//Column45Left
						else if((xposition ==225)&&((yposition >=315)&&(yposition <=330)))
							xposition <=xposition+1;
					//Column51Right
						else if((xposition ==255)&&((yposition >=255)&&(yposition <=270)))
							xposition <=xposition-1;
					//Column51Left
						else if((xposition ==255)&&((yposition >=120)&&(yposition <=135)))
							xposition <=xposition+1;
					//Column57Right
						else if((xposition ==285)&&((yposition >=120)&&(yposition <=135)))
							xposition <=xposition-1;
					//Column57Left
						else if((xposition ==285)&&((yposition >=225)&&(yposition <=240)))
							xposition <=xposition+1;
					//Column66Left
						else if((xposition ==330)&&(((yposition >=30)&&(yposition <=45))||((yposition >=405)&&(yposition <=420))))
							xposition <=xposition+1;
					//Column69Right
						else if((xposition ==345)&&((yposition >=225)&&(yposition <=240)))
							xposition <=xposition-1;
					//Column72Right
						else if((xposition ==360)&&(((yposition >=30)&&(yposition <=45))||((yposition >=405)&&(yposition <=420))))
							xposition <=xposition-1;
					//Column75Left
						else if((xposition ==375)&&((yposition >=90)&&(yposition <=105)))
							xposition <=xposition+1;
					//Column78Left
						else if((xposition ==390)&&((yposition >=435)&&(yposition <=480)))
							xposition <=xposition+1;
					//Column81Right
						else if((xposition ==405)&&((yposition >=90)&&(yposition <=105)))
							xposition <=xposition-1;
					//Column84Right
						else if((xposition ==420)&&((yposition >=435)&&(yposition <=450)))
							xposition <=xposition-1;
					//Column87Left
						else if((xposition ==435)&&((yposition >=375)&&(yposition <=390)))
							xposition <=xposition+1;
					//Column93Right
						else if((xposition ==465)&&((yposition >=375)&&(yposition <=390)))
							xposition <=xposition-1;
					//Column114Left
						else if((xposition ==570)&&((yposition >=195)&&(yposition <=210)))
							xposition <=xposition+1;
					//Column117Left
						else if((xposition ==585)&&(((yposition >=435)&&(yposition <=450))||((yposition >=30)&&(yposition <=45))))
							xposition <=xposition+1;
					//Column120Left
						else if((xposition ==600)&&((yposition >=60)&&(yposition <=75)))
							xposition <=xposition+1;
					//Column120Right
						else if((xposition ==600)&&((yposition >=195)&&(yposition <=210)))
							xposition <=xposition-1;
					//Column123Left
						else if((xposition ==615)&&((yposition >=165)&&(yposition <=180)))
							xposition <=xposition+1;
		end
else if (key3==1'b1)
	begin 	
	//first row first column 						
				if((xposition >=125 && xposition +5<= 275) && (yposition +5>=100 && yposition +5<= 110))
					begin
					yposition = yposition-1'b1;
					end
				else if((xposition >=125 && xposition +5<= 275) && (yposition >=100 && yposition <= 110))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==125) && (yposition +5>=100 && yposition +5<= 110))
					begin
					xposition = xposition-1'b1;
					end
				else if((xposition == 275) && (yposition >=100 && yposition <= 110))
					begin
					xposition = xposition+1'b1;
					end
//					
//second row first column 					
//					
				else if((xposition >=125 && xposition +5<= 275) && (yposition +5>=200 && yposition +5<= 210))
					begin
					yposition = yposition-1'b1;
					end
			else	if((xposition >=125 && xposition +5<= 275) && (yposition >=200 && yposition <= 210))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==125) && (yposition +5>=200 && yposition +5<= 210))
					begin
					xposition = xposition-1'b1;
					end
			else	if((xposition == 275) && (yposition >=200 && yposition <= 210))
					begin
					xposition = xposition+1'b1;
					end
					
//					
//third row first column 					
//					
				else if((xposition >=125 && xposition +5<= 275) && (yposition +5>=300 && yposition +5<= 310))
					begin
					yposition = yposition-1'b1;
					end
else				if((xposition >=125 && xposition +5<= 275) && (yposition >=300 && yposition <= 310))
					begin
					yposition = yposition+1'b1;
					end
	else			if((xposition +5==125) && (yposition +5>=300 && yposition +5<= 310))
					begin
					xposition = xposition-1'b1;
					end
		else		if((xposition == 275) && (yposition >=300 && yposition <= 310))
					begin
					xposition = xposition+1'b1;
					end			
					
//first row second column 			
			else	if((xposition >=350 && xposition +5<= 500) && (yposition +5>=100 && yposition +5<= 110))
					begin
					yposition = yposition-1'b1;
					end
				else if((xposition >=350 && xposition +5<= 500) && (yposition >=100 && yposition <= 110))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==350) && (yposition +5>=100 && yposition +5<= 110))
					begin
					xposition = xposition-1'b1;
					end
				else if((xposition == 500) && (yposition >=100 && yposition <= 110))
					begin
					xposition = xposition+1'b1;
					end
//					
//second row second column 					
//					
				else if((xposition >=350 && xposition +5<= 500) && (yposition +5>=200 && yposition +5<= 210))
					begin
					yposition = yposition-1'b1;
					end
				else if((xposition >=350 && xposition +5<= 500) && (yposition >=200 && yposition <= 210))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==350) && (yposition +5>=200 && yposition +5<= 210))
					begin
					xposition = xposition-1'b1;
					end
				else if((xposition == 500) && (yposition >=200 && yposition <= 210))
					begin
					xposition = xposition+1'b1;
					end
					
//					
//third row second column 					
//					
				else if((xposition >=350 && xposition +5<= 500) && (yposition +5>=300 && yposition +5<= 310))
					begin
					yposition = yposition-1'b1;
					end
				else if((xposition >=350 && xposition +5<= 500) && (yposition >=300 && yposition <= 310))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==350) && (yposition +5>=300 && yposition +5<= 310))
					begin
					xposition = xposition-1'b1;
					end
				else if((xposition == 500) && (yposition >=300 && yposition <= 310))
					begin
					xposition = xposition+1'b1;
					end	
			
	
	
	end
else if(key4==1'b1)
	begin
			//first row first column 			
				if((xposition >=125 && xposition +5<= 275) && (yposition +5>=100 && yposition +5<= 110))
					begin
					yposition = yposition-1'b1;
					end
				else if((xposition >=125 && xposition +5<= 275) && (yposition >=100 && yposition <= 110))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==125) && (yposition +5>=100 && yposition +5<= 110))
					begin
					xposition = xposition-1'b1;
					end
				else if((xposition == 275) && (yposition >=100 && yposition <= 110))
					begin
					xposition = xposition+1'b1;
					end
//					
//second row first column 					
//					
				else if((xposition >=125 && xposition +5<= 275) && (yposition +5>=200 && yposition +5<= 210))
					begin
					yposition = yposition-1'b1;
					end
			else	if((xposition >=125 && xposition +5<= 275) && (yposition >=200 && yposition <= 210))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==125) && (yposition +5>=200 && yposition +5<= 210))
					begin
					xposition = xposition-1'b1;
					end
			else	if((xposition == 275) && (yposition >=200 && yposition <= 210))
					begin
					xposition = xposition+1'b1;
					end
					
//					
//third row first column 					
//					
				else if((xposition >=125 && xposition +5<= 275) && (yposition +5>=300 && yposition +5<= 310))
					begin
					yposition = yposition-1'b1;
					end
else				if((xposition >=125 && xposition +5<= 275) && (yposition >=300 && yposition <= 310))
					begin
					yposition = yposition+1'b1;
					end
	else			if((xposition +5==125) && (yposition +5>=300 && yposition +5<= 310))
					begin
					xposition = xposition-1'b1;
					end
		else		if((xposition == 275) && (yposition >=300 && yposition <= 310))
					begin
					xposition = xposition+1'b1;
					end			
					
//first row second column 			
			else	if((xposition >=350 && xposition +5<= 500) && (yposition +5>=100 && yposition +5<= 110))
					begin
					yposition = yposition-1'b1;
					end
				else if((xposition >=350 && xposition +5<= 500) && (yposition >=100 && yposition <= 110))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==350) && (yposition +5>=100 && yposition +5<= 110))
					begin
					xposition = xposition-1'b1;
					end
				else if((xposition == 500) && (yposition >=100 && yposition <= 110))
					begin
					xposition = xposition+1'b1;
					end
//					
//second row second column 					
//					
				else if((xposition >=350 && xposition +5<= 500) && (yposition +5>=200 && yposition +5<= 210))
					begin
					yposition = yposition-1'b1;
					end
				else if((xposition >=350 && xposition +5<= 500) && (yposition >=200 && yposition <= 210))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==350) && (yposition +5>=200 && yposition +5<= 210))
					begin
					xposition = xposition-1'b1;
					end
				else if((xposition == 500) && (yposition >=200 && yposition <= 210))
					begin
					xposition = xposition+1'b1;
					end
					
//					
//third row second column 					
//					
				else if((xposition >=350 && xposition +5<= 500) && (yposition +5>=300 && yposition +5<= 310))
					begin
					yposition = yposition-1'b1;
					end
				else if((xposition >=350 && xposition +5<= 500) && (yposition >=300 && yposition <= 310))
					begin
					yposition = yposition+1'b1;
					end
				else if((xposition +5==350) && (yposition +5>=300 && yposition +5<= 310))
					begin
					xposition = xposition-1'b1;
					end
				else if((xposition == 500) && (yposition >=300 && yposition <= 310))
					begin
					xposition = xposition+1'b1;
					end	
	end 
end
//

assign xpos = xposition;
assign ypos = yposition;

endmodule 