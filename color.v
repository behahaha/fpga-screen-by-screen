module color(
input SW15, 
input SW16,
input SW17,
output reg RO, 
output reg GO,
output reg BO,
output reg RO1, 
output reg GO1, 
output reg BO1
);
//c
always 
	begin 
	if(SW15 == 1)
		begin 
			if (SW17 == 1) RO <= 10'd1000 && BO <= 10'd0000 && GO <= 10'd0000;
			else if (SW17 ==0) RO <= 10'd1000 && GO <= 10'd1000 && BO <= 10'd1000; 
			else if (SW16 ==1) RO1 <= 10'd0000 && GO1 <= 10'd0000 && BO1 <= 10'd1000;
			else RO1 <= 10'd0000 && GO1 <= 10'd0000 && BO1 <= 10'd0000;
		end
	else RO <= 10'd1000 && GO <= 10'd0000 && BO <= 10'd0750 && RO1 <= 10'd1000 && GO1 <= 10'd0750 && BO1 <= 10'd0000;
	end 
	
endmodule 
