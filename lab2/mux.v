module mux(input [3:0] mode1,mode2,mode3,mode4, input [1:0]sel, output reg[3:0] out);
	always @(*)
		begin
		case(sel)
			2'b00: out<=mode1;
			2'b01: out<=mode2;
			2'b10: out<=mode3;
			2'b11: out<=mode4;
		endcase
	end
endmodule
