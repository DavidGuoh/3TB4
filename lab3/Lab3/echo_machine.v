module echo_machine(input signed [15:0] input_sample, input sample_clock, output signed [15:0] output_sample);
wire signed [15:0] delayed_signal, feedback;
reg signed [15:0] output_echo;
assign feedback = output_echo;
shiftregister sr(.clock(sample_clock),.shiftin(feedback),.shiftout(delayed_signal),.taps());
always @(posedge sample_clock)
begin
	output_echo <= (delayed_signal>>>8) + input_sample;
end

assign output_sample = output_echo;

endmodule