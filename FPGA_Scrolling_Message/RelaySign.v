module scrollClock(output reg Clock_1_Hz, input Clock_in); //1 Hz clock for scrolling message every second
	reg [28:0] period_cnt = 0;
	
	always @ (posedge Clock_in)
		if(period_cnt != 5_000_000 - 1)
			begin
				period_cnt <= period_cnt + 1;
				Clock_1_Hz <= 0;
			end
		else
			begin
				period_cnt <= 0;
				Clock_1_Hz <= 1;
			end
endmodule



module RelaySign(
    input wire a,
	 output reg [6:0] s1, 
	 output reg [6:0] s2,
	 output reg [6:0] s3,
	 output reg [6:0] s4,
	 output reg [6:0] s5,
	 output reg [6:0] s6,
	 input clk	 
);
	reg [3:0] cnt;
	wire Clock1Hz;
	
	integer int_s1 = 7'b1111001; // I
	integer int_s2 = 7'b1111111; // "space"
	integer int_s3 = 7'b1000111; // L
	integer int_s4 = 7'b1000000; // O
	integer int_s5 = 7'b1000001; // V
	integer int_s6 = 7'b0000110; // E
	integer int_s7 = 7'b1000110; // C
	integer int_s8 = 7'b0001000; // A
	integer int_s9 = 7'b0101111; // r
	integer int_s10 = 7'b0010010; // S
	
	scrollClock(Clock1Hz, clk);
	task automatic printMessage;
				//output s1, s2, s3, s4, s5, s6;
				//input cnt;
				begin
					
			
					case(cnt % 12)
						4'b0001 : begin
								s1 = int_s1; // I
								s2 = int_s2;
								s3 = int_s2;
								s4 = int_s2;
								s5 = int_s2;
								s6 = int_s2;
							 end
						4'b0010 : begin
								s1 = int_s2;
								s2 = int_s1; // I
								s3 = int_s2;
								s4 = int_s2;
								s5 = int_s2;
								s6 = int_s2;
							 end
						
						4'b0011 : begin
								s1 = int_s3; // L
								s2 = int_s2;
								s3 = int_s1; // I
								s4 = int_s2;
								s5 = int_s2;
								s6 = int_s2;
							 end
							 
						4'b0100 : begin
								s1 = int_s4; // O
								s2 = int_s3; // L
								s3 = int_s2;
								s4 = int_s1; // I
								s5 = int_s2;
								s6 = int_s2;
							 end
							 
						4'b0101 : begin
								s1 = int_s5; // V
								s2 = int_s4; // O
								s3 = int_s3; // L
								s4 = int_s2;
								s5 = int_s1; // I
								s6 = int_s2;
							 end
							 
						4'b0110 : begin
								s1 = int_s6; // E
								s2 = int_s5; // V
								s3 = int_s4; // O
								s4 = int_s3; // L
								s5 = int_s2;
								s6 = int_s1; // I
							 end
							 
						4'b0111 : begin
								s1 = int_s2;
								s2 = int_s6; // E
								s3 = int_s5; // V
								s4 = int_s4; // O
								s5 = int_s3; // L
								s6 = int_s2;
							 end
						
						4'b1000 : begin
								s1 = int_s7; // C
								s2 = int_s2;
								s3 = int_s6; // E
								s4 = int_s5; // V
								s5 = int_s4; // O
								s6 = int_s3; // L
							 end
							 
						4'b1001 : begin
								s1 = int_s8; // A
								s2 = int_s7; // C
								s3 = int_s2; 
								s4 = int_s6; // E
								s5 = int_s5; // V
								s6 = int_s4; // O
							 end
						
						4'b1010 : begin
								s1 = int_s9; // r
								s2 = int_s8; // A
								s3 = int_s7; // C
								s4 = int_s2; 
								s5 = int_s6; // E
								s6 = int_s5; // V
							 end
						
						4'b1011 : begin
								s1 = int_s10; // S
								s2 = int_s9; // r
								s3 = int_s8; // A
								s4 = int_s7; // C
								s5 = int_s2; 
								s6 = int_s6; // E
							 end
							 
						default : begin
								s1 = int_s2; 
								s2 = int_s2; 
								s3 = int_s2;
								s4 = int_s2; 
								s5 = int_s2; 
								s6 = int_s2; 
							end
					endcase
			   end
		   endtask

    always @ (posedge Clock1Hz)
    begin
			
        if (a == 1'b1) 
				 begin
					if (cnt < 12)
						 cnt <= cnt + 1;
					else
						cnt <= 4'd0000;
					printMessage;
				end
				
			else 
				begin
					s1 = int_s2;
					s2 = int_s2;
					s3 = int_s2;
					s4 = int_s2;
					s5 = int_s2;
					s6 = int_s2;
				end
			
    end
		
endmodule
