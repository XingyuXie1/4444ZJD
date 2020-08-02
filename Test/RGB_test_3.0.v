`timescale 1ns / 1ps

module fyx_2385_5_1(
    input clk,
    input rst,
    output reg led_pwm
    );
    
integer count;	 
parameter	T0H = 7'd300;
parameter	T0L = 7'd800; //0码的高低电平时间
parameter	T1H = 7'd800;
parameter	T1L = 7'd300; //1码的高低电平时间
parameter	RST = 14'd15000; //复位时间

reg   shift;
reg   [4:0] bit_cnt;
reg 	[6:0] cycle_cnt; 

parameter	OFF		=24'b0000_0000_0000_0000_0000_0000;
parameter	WHITE	   =24'b1111_1111_1111_1111_1111_1111;

always@(posedge clk or negedge rst)
begin
if(!rst)
  cycle_cnt <= 7'd0;
else 
  if(cycle_cnt >= (T0H + T0L))
    cycle_cnt <= 7'd1;
  else
    cycle_cnt <= cycle_cnt + 1'b1;  
end

always@(posedge clk or negedge rst)
begin
if(!rst)
  bit_cnt <= 5'd0;
else 
  if(bit_cnt >= 5'd23)
    begin
    bit_cnt <= 5'd0;
    #500000;
	 end
  else 
    if(cycle_cnt >= (T0H + T0L))
	   bit_cnt <= bit_cnt + 1'b1;
end


always@(posedge clk or negedge rst)
begin
if(!rst)
  begin
  led_pwm <= 1'b0;
  shift <= 1'b0;
  end
else
  begin
  shift <= WHITE[bit_cnt];
  if(shift == 1'b1)
    begin
	 if(cycle_cnt <= T1H)
	   led_pwm <= 1'b1;
	 else 
		if(cycle_cnt <= (T1H + T1L))
		  led_pwm <= 1'b0;  
	 end
  else
    begin
	 if(cycle_cnt <= T0H)
	   led_pwm <= 1'b0;
	 else 
	   if(cycle_cnt <= (T0H + T0L))
		  led_pwm <= 1'b1;
		else
		  led_pwm <= 1'b0;
	 end
  end
end  
        

endmodule

