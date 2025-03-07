
module dsp_subsystem (input sample_clock,  input reset, input [1:0] selector, input [15:0] input_sample, output [15:0] output_sample);

wire [15:0] echo_out, FIR_out;

FIR #(.taps(66)) fir(.input_sample(input_sample),.reset(reset), .clk(sample_clock),.output_sample(FIR_out));

echo_machine echo(.input_sample(input_sample), .sample_clock(sample_clock),.output_sample(echo_out));

mux mux1(.mode1(input_sample),.mode2(FIR_out),.mode3(echo_out),.sel(selector), .out(output_sample));

endmodule
