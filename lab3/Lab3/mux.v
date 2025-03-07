module mux(input signed [15:0] mode1,mode2,mode3, input [1:0]sel, output signed [15:0] out);
assign out = (sel == 2'b00) ? mode1:
				 (sel == 2'b10) ? mode2: 
				 (sel == 2'b01) ? mode3: 
				 mode1;
endmodule
