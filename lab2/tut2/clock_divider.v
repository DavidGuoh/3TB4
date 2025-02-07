module clock_divider(input Clock, Reset_n, output reg clk_ms);
	parameter factor =10; //50000; // 32 ’ h 000061 a 7;
	reg [31:0] countQ;
	always@(posedge Clock, negedge Reset_n)
	begin
		if (~Reset_n)
			begin
			countQ[31:0] <= 32'b0;
			clk_ms <= 1'b1;
			end
		else
			begin
				if (countQ<factor/2)
					begin
					countQ <= countQ+1;
					clk_ms <= 1'b1;
					end
			else if (countQ<factor)
				begin
					countQ <= countQ+1;
					clk_ms <= 1'b0;
				end
			else // countQ == factor
				begin
				countQ[31:0] <= 32'b0;
				clk_ms <= ~clk_ms;
				end
			end
		end
endmodule