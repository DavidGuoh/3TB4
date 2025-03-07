module FIR(input signed [15:0] input_sample, input clk, input reset, output signed [15:0] output_sample);

parameter taps=66;
reg signed [15:0] register [taps:0];
wire signed [15:0] multiplier_output [taps:0];
reg signed [15:0] coeff [taps:0];
reg signed [31:0] sum;

always @ (*)
begin
	coeff[  0]=         0;
	coeff[  1]=        -6;
	coeff[  2]=        -0;
	coeff[  3]=        18;
	coeff[  4]=         0;
	coeff[  5]=       -43;
	coeff[  6]=        -0;
	coeff[  7]=        87;
	coeff[  8]=         0;
	coeff[  9]=      -158;
	coeff[ 10]=        -0;
	coeff[ 11]=       261;
	coeff[ 12]=         0;
	coeff[ 13]=      -403;
	coeff[ 14]=        -0;
	coeff[ 15]=       585;
	coeff[ 16]=         0;
	coeff[ 17]=      -807;
	coeff[ 18]=        -0;
	coeff[ 19]=      1061;
	coeff[ 20]=         0;
	coeff[ 21]=     -1338;
	coeff[ 22]=        -0;
	coeff[ 23]=      1620;
	coeff[ 24]=         0;
	coeff[ 25]=     -1890;
	coeff[ 26]=        -0;
	coeff[ 27]=      2127;
	coeff[ 28]=         0;
	coeff[ 29]=     -2313;
	coeff[ 30]=        -0;
	coeff[ 31]=      2431;
	coeff[ 32]=         0;
	coeff[ 33]=     30296;
	coeff[ 34]=         0;
	coeff[ 35]=      2431;
	coeff[ 36]=        -0;
	coeff[ 37]=     -2313;
	coeff[ 38]=         0;
	coeff[ 39]=      2127;
	coeff[ 40]=        -0;
	coeff[ 41]=     -1890;
	coeff[ 42]=         0;
	coeff[ 43]=      1620;
	coeff[ 44]=        -0;
	coeff[ 45]=     -1338;
	coeff[ 46]=         0;
	coeff[ 47]=      1061;
	coeff[ 48]=        -0;
	coeff[ 49]=      -807;
	coeff[ 50]=         0;
	coeff[ 51]=       585;
	coeff[ 52]=        -0;
	coeff[ 53]=      -403;
	coeff[ 54]=         0;
	coeff[ 55]=       261;
	coeff[ 56]=        -0;
	coeff[ 57]=      -158;
	coeff[ 58]=         0;
	coeff[ 59]=        87;
	coeff[ 60]=        -0;
	coeff[ 61]=       -43;
	coeff[ 62]=         0;
	coeff[ 63]=        18;
	coeff[ 64]=        -0;
	coeff[ 65]=        -6;
	coeff[ 66]=         0;
end

integer i;

always@(posedge clk or posedge reset) 
begin
	if (reset)
	begin
		for (i = taps;i>=0;i=i-1)
		begin
			register[i] = 0; 
		end
	end
	else
	begin
		for (i = taps;i>0;i=i-1)
		begin
			 register[i] = register[i-1]; 
		end
		register[0] = input_sample;
	end
end

genvar j;
generate
	for(j=0;j<=taps;j=j+1) 
	begin: multi_taps
		multiplier m(.dataa(register[j]),.datab(coeff[taps-j]),.result(multiplier_output[j]));
	end
endgenerate


integer z;
always@(posedge clk)
begin
	sum = 32'b0;
	for (z = 0; z <= taps; z = z + 1)
	begin
		sum = sum + multiplier_output[z];
	end	
end

//assign output_sample = {sum[31], sum[29:15]};
assign output_sample = sum >>> 15;
endmodule