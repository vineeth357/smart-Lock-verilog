
module smartlock4(in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,in_8,in_9,reset_in,clk,out);
input in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,in_8,in_9,reset_in;
input clk;
output out;

wire reset,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9;
button b_reset(clk,reset_in,reset);
button b_0(clk,in_0,b0);
button b_1(clk,in_1,b1);
button b_2(clk,in_2,b2);
button b_3(clk,in_3,b3);
button b_4(clk,in_4,b4);
button b_5(clk,in_5,b5);
button b_6(clk,in_6,b6);
button b_7(clk,in_7,b7);
button b_8(clk,in_8,b8);
button b_9(clk,in_9,b9);

parameter S_reset=3'd0, S_1=3'd1, S_2=3'd2, S_3=3'd3,S_4=3'd4,S_5=3'd5;
reg [2:0] currentstate,nextstate;

always@(*)
begin
	if(reset) nextstate=S_reset;
	else case(currentstate)
		S_reset:	begin
					if(b2) nextstate=S_1;
					else if(b0||b1||b4||b3||b5||b6||b7||b8||b9)  nextstate=S_5;
					else nextstate=S_reset;
				end
		S_1:	begin
				if(b4) nextstate=S_2;
				else if(b0||b1||b2||b3||b5||b6||b7||b8||b9)  nextstate=S_5;
				else   nextstate=S_1;
			end
		S_2:	begin
				if(b7) nextstate=S_3;
				else if(b0||b1||b2||b3||b5||b6||b4||b8||b9)  nextstate=S_5;
				else  nextstate=S_2;	
			end
		S_3:	begin
				if(b9) nextstate=S_4;
				else if(b0||b1||b2||b3||b5||b6||b7||b8||b4)  nextstate=S_5;
				else  nextstate=S_3;
			end
		S_4:    begin	
				nextstate=S_4;
			end
		S_5:	begin
				nextstate=S_5;
			end
		default: nextstate=S_reset;
	   endcase
end
always@(posedge clk) currentstate<=nextstate;
assign out=(currentstate==S_4);


endmodule

		
		
module button(clk,in,ou);
input clk;
input in;
output ou;

reg r1,r2,r3;
always@(posedge clk)
begin
	r1<=in;
	r2<=r1;
	r3<=r2;
end
assign ou=~r3&r2;
endmodule

module smartlock_test;
reg in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,in_8,in_9,reset_in,clk;
wire out;

smartlock4 maathaji(in_0,in_1,in_2,in_3,in_4,in_5,in_6,in_7,in_8,in_9,reset_in,clk,out);

initial
	begin

	#7  in_0=1'b0;in_1=1'b0;in_2=1'b0;in_3=1'b0;in_4=1'b0;in_5=1'b0;in_6=1'b0;in_7=1'b0;in_8=1'b0;in_9=1'b0;reset_in=1'b1;
	#10  reset_in=1'b0;
	#10  in_2=1'b1;
	#10  in_2=1'b0;
	#10  in_4=1'b1;
	#10  in_4=1'b0;
	#10  in_7=1'b1;
	#10  in_7=1'b0;
	#10  in_9=1'b1;
	#10  in_9=1'b0;
	#10  reset_in=1'b1;
	#10  reset_in=1'b0;
	#10  in_2=1'b1;
	#10  in_2=1'b0;
	#10  in_1=1'b1;
	#10  in_1=1'b0;
	#10  in_4=1'b1;
	#10  in_4=1'b0;
end

initial
begin
	
	clk=1'b0;
	forever #5 clk=~clk;
end
endmodule











