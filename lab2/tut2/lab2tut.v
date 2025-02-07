module lab2tut(input CLOCK_50 ,input [2:0] KEY , output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	wire clk_en;
	wire [19:0] ms;
	wire [3:0] digit0 , digit1 , digit2 , digit3 , digit4 , digit5;
	clock_divider #(.factor(50000)) (.Clock(CLOCK_50), .Reset_n(KEY[0]), .clk_ms(clk_en));
	counter(.clk(clk_en), .reset_n(KEY[0]), .start_n(KEY[1]), .stop_n(KEY[2]), .ms_count(ms));
	hex_to_bcd_converter(CLOCK_50, KEY[0], ms, digit0,digit1,digit2,digit3, digit4,digit5);
	seven_segment_decoder decoder0(digit0, HEX0);
	seven_segment_decoder decoder1(digit1, HEX1);
	seven_segment_decoder decoder2(digit2, HEX2);
	seven_segment_decoder decoder3(digit3, HEX3);
	seven_segment_decoder decoder4(digit4, HEX4);
	seven_segment_decoder decoder5(digit5, HEX5);
endmodule