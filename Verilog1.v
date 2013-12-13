/*module FSM(clk, rst, out);
input clk, rst;
output out;

parameter A=0;
parameter B=1;
parameter C=2;
parameter D=3;

reg [1:0]s;
reg [1:0]ns;

always@ (*)
begin
case(s)
A:if(in1==1)
ns<=B;
else
ns<=A;

B:
C:
D:


end

always@(posedge clk or negedge rst)
begin

end



assign out (s==A) ? 1'b1:1'b0;
endmodule
*/