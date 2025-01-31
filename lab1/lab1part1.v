module D-ff (input d,clk, output reg q, output q_b);
	always @(posedge clk)
	begin
		q<=d;
	end
	assign q_b = ~q;
endmodule

module D-ff_ls_reset (input d,clk,reset, output reg q, output q_b);
	always @(posedge clk)
	begin
	if(~reset)
	begin
		q<=1'b0;
	end
	else
	begin
		q<=d;
	end
	assign q_b = ~q;
endmodule

module D-ff_ls_reset_enable (input d,clk,reset,enable, output reg q, output q_b);
	always @(posedge clk)
	begin
	if(~reset)
	begin
		q<=1'b0;
	end
	else if(enable)
	begin
		q=d;
	end
	else
	begin
		q<=d;
	end
	assign q_b = ~q;
endmodule

module dlatch(input d,en, output reg q);
	always @(en or d)
	begin
	if (en)
		begin
			q <= d;
		end
	end
endmodule

module mux_4to1(input a,b,c,d, input [1:0] s, output reg out);
	always @(*)
	begin
		case(s)
			2'b00 : out <= a;
			2'b01 : out <= b;
			2'b10 : out <= c;
			2'b11 : out <= d;
		endcase
	end
endmodule

module counter(input reset,enable,clk, input [3:0] data, output reg [3:0] out);
	always @(posedge clk)
	begin
		if(reset)
		begin
			count<=0;
		end
		else if(enable)
		begin
			count <= data;
		end
		else
		begin
			count <= count+1;
		end
	end
endmodule
