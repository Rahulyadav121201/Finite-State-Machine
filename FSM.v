`timescale 1ns / 1ps

module FSM(
in,reset,out,clk);
input in,reset,clk;
output reg out;
parameter [3:0] sr=4'b0000;
parameter [3:0] s01=4'b0001;
parameter [3:0] s02=4'b0010;
parameter [3:0] s03=4'b0011;
parameter [3:0] s04=4'b0100;
parameter [3:0] s11=4'b0101;
parameter [3:0] s12=4'b0110;
parameter [3:0] s13=4'b0111;
parameter [3:0] s14=4'b1000;
wire clke;
reg [3:0] cur_state,next_state;
clk_divider cc1(.clk_out(clke),.clk(clk));
always @(posedge clke)
begin
if(reset==1)
cur_state<=sr;
else
cur_state<=next_state;
end

always @(cur_state,in)
begin
case(cur_state)
sr:
if(in==0)
next_state<=s01;
else
next_state<=s11;
s01:
if(in==0)
next_state<=s02;
else
next_state<=s11;
s02:
if(in==0)
next_state<=s03;
else
next_state<=s11;
s03:
if(in==0)
next_state<=s04;
else
next_state<=s11;
s04:
if(in==0)
next_state<=s04;
else
next_state<=s11;
s11:
if(in==0)
next_state<=s01;
else
next_state<=s12;
s12:
if(in==0)
next_state<=s01;
else
next_state<=s13;
s13:
if(in==0)
next_state<=s01;
else
next_state<=s14;
s14:
if(in==0)
next_state<=s01;
else
next_state<=s14;
default :
cur_state<=sr;
endcase
end

always@(cur_state)
begin
case(cur_state)
sr:
out<=0;
s01:
out<=0;
s02:
out<=0;
s03:
out<=0;
s04:
out<=1;
s11:
out<=0;
s12:
out<=0;
s13:
out<=0;
s14:
out<=1;
default :
out<=0;
endcase
end
endmodule

//module clockgen(clk ,req_clock);
//input clk;
//output reg req_clock;
//reg [26:0]count;
//always @(posedge clk)
//begin
//count=count+1;
//if (count<=62500000)
//req_clock<=1;
//else
//req_clock<=0;
//if(count==125000000)
//count<=0;
//end
//endmodule

module clk_divider(clk,clk_out);

input wire clk;
reg[27:0] counter;
always@(posedge clk)
begin
if (counter == 125000000 - 1)
counter <= 0;
else
counter <= counter + 1;
end

output reg  clk_out;
always@(posedge clk)
begin
if (counter <= 62500000)
clk_out  <= 1;
else
clk_out <= 0;
end
endmodule