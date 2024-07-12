module pwm_module
    #(parameter R = 8, TIMER_BITS = 24)(
    input clk,
    input reset_n,
    input [R:0] duty, 
    input [TIMER_BITS - 1:0] FINAL_VALUE, // Final value of the counter
    output pwm_out
    );
    
    
    
    reg [R - 1:0] Q_reg, Q_next;
    reg d_reg, d_next;
    wire tick;
    
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
        begin
            Q_reg <= 'b0;
            d_reg <= 1'b0;
        end
        else if (tick)
        begin
            Q_reg <= Q_next;
            d_reg <= d_next;
        end
        else
        begin
            Q_reg <= Q_reg;
            d_reg <= d_reg;
        end                  
    end
    
    always @(Q_reg, duty)
    begin
        Q_next = Q_reg + 1;
        d_next = (Q_reg < duty);
    end
    
    assign pwm_out = d_reg;
    

    
    timer_input #(.BITS(TIMER_BITS)) timer0 (
        .clk(clk),
        .reset_n(reset_n),
        .enable(1'b1),
        .FINAL_VALUE(FINAL_VALUE),
        .done(tick)
    );
    
        
endmodule

module timer_input
    #(parameter BITS = 4)(
    input clk,
    input reset_n,
    input enable,
    input [BITS - 1:0] FINAL_VALUE,
    output done
    );
    
    reg [BITS - 1:0] Q_reg, Q_next;
    
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            Q_reg <= 'b0;
        else if(enable)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    
    assign done = Q_reg == FINAL_VALUE;

    always @(*)
        Q_next = done? 'b0: Q_reg + 1;
    
    
endmodule


module BlinkingLEDv3 (output led, input clk, input reset_n);
	integer cnt = 0;
	wire pwm_out;
	reg[7:0] duty = 8'd179; //This is 70% duty cycle. 0.7 * 255 = 179
	wire clk_new;

	pwm_module #(.R(8), .TIMER_BITS(24))(.clk(clk), .reset_n(reset_n), .duty(duty), .FINAL_VALUE(3 * 39062),.pwm_out(pwm_out));
																												//The final value calculation is for 3 sec
	assign led = pwm_out;
endmodule

