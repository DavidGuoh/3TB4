module counter(
	input clk, 
	input reset_n,
	input start_n, 
	input stop_n, 
	output reg [19:0] ms_count
	);
	reg status = 1'b0;
	always@(posedge clk, negedge reset_n)
	//always@(posedge clk, negedge reset_n, start_n, stop_n)
	begin
		if (~reset_n)
			begin
			ms_count[19:0] <= 20'b0;
			end
		else if(~stop_n)
			begin
			status <= 1'b0;
			end
		else if(~start_n)
			begin
			status <= 1'b1;
			end
		else
			begin
				if(status)
				begin
					ms_count <= ms_count+1;
				end
			end
	end	
endmodule