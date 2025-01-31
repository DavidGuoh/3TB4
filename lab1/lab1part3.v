module lab1part3(input [9:0] SW, input [3:0] KEY, input CLOCK_50, output[6:0]  HEX0);
	wire [3:0] counter_out;
	wire [29:0] counter_30bit_out;
	wire [6:0] reg_LEDs;
	assign HEX0=reg_LEDs;
	counter (.reset_n(KEY[0]),.enable(KEY[3]),.result(counter_out));
	counter_30bit (.clk(CLOCK_50),.reset_n(KEY[0]),.result(counter_30bit_out));
	reg [3:0] decoder_input;
	always@(*)
	begin
		case({SW[9],SW[8]})
			2'b00: decoder_input = SW[3:0]; 
			2'b01: decoder_input = counter_out[3:0];
			2'b10: decoder_input = counter_30bit_out[29:26];
			2'b11: decoder_input= 4'b1111;
		endcase
	end
	seven_segment_decoder s1 (.x(decoder_input), .HEX_0(reg_LEDs));
endmodule

module counter( input reset_n, enable, output reg [WIDTH-1:0] result);
parameter WIDTH =4;
always@ ( posedge enable, negedge reset_n)
begin
	if (~reset_n)
	begin
		result <= 4'b0;
	end
	else if (enable)
	begin
		result <= result+1'b1;
	end
end
endmodule

module counter_30bit( input clk, reset_n, output reg [WIDTH-1:0] result);
//2 ’ s power of 26 is 67 ,108 ,864.
// that is 1 second (2^26/50 e 6 = 1.34) , if count is using CLOCK _50
parameter WIDTH =30;
always@ ( posedge clk, negedge reset_n)
begin
	if (~reset_n)
	begin
		result <= 30'b0;
	end 
	else
	begin
		result <= result + 1'b1;
	end
end
endmodule


module seven_segment_decoder(input [3:0] x , output [6:0] HEX_0);
	reg[6:0] reg_LEDs;
	
	assign HEX_0[0] = ( ( (x[3])&(x[2])&(x[0]) ) | ( (x[3])&(x[1])&(~x[0]) ) | ( (~x[3])&(x[2])&(~x[1])&(~x[0]) ) | ( (~x[3])&(~x[2])&(~x[1])&(x[0]) ) );
	assign HEX_0[1] = ( ( (~x[3])&(x[2])&(~x[1])&(x[0]) ) | ( (~x[3])&(x[2])&(x[1])&(~x[0]) ) | ( (x[3])&(x[2])&(x[1])&(x[0]) ) );
	
	assign HEX_0[6:2] = reg_LEDs[6:2];

	always @ (*)
	begin
		case (x)
			4'b0000: reg_LEDs[6:2] =5'b10000; //7'b1000000 decimal 0
			4'b0001: reg_LEDs[6:2] =5'b11110; //7'b1111001 decimal 1
			4'b0010: reg_LEDs[6:2] =5'b01001; //7'b0100100 decimal 2
			4'b0011: reg_LEDs[6:2] =5'b01100; //7'b0110000 decimal 3
			4'b0100: reg_LEDs[6:2] =5'b00110; //7'b0011001 decimal 4
			4'b0101: reg_LEDs[6:2] =5'b00100; //7'b0010010 decimal 5
			4'b0110: reg_LEDs[6:2] =5'b00000; //7'b0000010 decimal 6
			4'b0111: reg_LEDs[6:2] =5'b11110; //7'b1111000 decimal 7
			4'b1000: reg_LEDs[6:2] =5'b00000; //7'b0000000 decimal 8
			4'b1001: reg_LEDs[6:2] =5'b00100; //7'b0010000 decimal 9
			4'b1010: reg_LEDs[6:2] =5'b00010; //7'b0001001 H
			4'b1011: reg_LEDs[6:2] =5'b00010; //7'b0001000 A
			4'b1100: reg_LEDs[6:2] =5'b10000; //7'b1000000 O
			4'b1101: reg_LEDs[6:2] =5'b00110; //7'b0011001 Y
			4'b1110: reg_LEDs[6:2] =5'b10000; //7'b1000001 U
			4'b1111: reg_LEDs[6:2] =5'b11111; //7'b1111111 Ending
			/* finish the case block */
		endcase
	end
endmodule