`timescale 1us/1ns

//Clock is 10 MHz
module pwm_basic#(parameter R = 8)(
    input clk,
    input reset_n,
    input [R - 1:0] duty,
    output pwm_out
    );
	 
	 // Up Counter
    reg [R - 1:0] Q_reg, Q_next;
    
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            Q_reg <= 'b0;
        else
            Q_reg <= Q_next;
    end
    
    // Next state logic
    always @(*)
    begin
        Q_next = Q_reg + 1;
    end
    
    // Output logic
    assign pwm_out = (Q_reg < duty);
endmodule

module BlinkingLEDv2 (output led, input clk, input reset_n);
	integer cnt = 0;
	//integer periodLength = 10_000_000;
	//integer pulseLength = 2_000_000;
	wire pwm_out;
	reg[7:0] duty = 8'd51; //This is 20% duty cycle
	
	pwm_basic #(.R(8))(.clk(clk), .reset_n(reset_n), .duty(duty), .pwm_out(pwm_out));
	
	/*always @ (posedge clk)
		begin
			if(cnt < periodLength)
				cnt <= cnt + 1;
			else
				cnt <= 0;
		end
	*/
	assign led = pwm_out; //(cnt < pulseLength) ? 1:0;
endmodule
