`timescale 1us/1ns

module HZ_1_Clock(output reg Clock_1_Hz, output reg hi, input Clock_in); //1 Hz clock for scrolling message every second
	reg [28:0] period_cnt = 0;
	//D is the duty cycle percentage
	reg D = 30;
	
	always @ (posedge Clock_in)
		if(period_cnt != 5_000_000 - 1)
			begin //
				period_cnt <= period_cnt + 1;
				Clock_1_Hz <= 0;
				if(period_cnt < ((D/100) * (5_000_000 - 1)))
					hi <= 1'b1;
				else
					hi <= 1'b0;				
			end
		else
			begin
				period_cnt <= 0;
				Clock_1_Hz <= 1;
				hi <= 1'b0;
			end
endmodule

module ClockBlinkLED (output led, input clk);
	integer cnt = 0;
	integer periodLength = 10_000_000;
	integer pulseLength = 2_000_000;
	
	always @ (posedge clk)
		begin
			if(cnt < periodLength)
				cnt <= cnt + 1;
			else
				cnt <= 0;
		end
	
	assign led = (cnt < pulseLength) ? 1:0;
endmodule
