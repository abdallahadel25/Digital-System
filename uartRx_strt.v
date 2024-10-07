module uartRx_strt(
input	wire	strt_check_en,
input	wire	sampled_bit,
input	wire	data_sampled,
input	wire	clk,
input	wire	rst,
output	reg	strt_glitch
);

always @(posedge clk or negedge rst)
begin
	if(!rst)
		strt_glitch <= 1'b0;
	else if (strt_check_en && data_sampled)
		strt_glitch <= (sampled_bit == 1'b0) ? 1'b0 : 1'b1;
end
endmodule 