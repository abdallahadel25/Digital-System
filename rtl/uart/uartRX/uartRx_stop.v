module uartRx_stop(
input	wire	stp_check_en,
input	wire	sampled_bit,
input	wire	data_sampled,
input	wire	clk,
input	wire	rst,
output	reg		stp_err
);

always @(posedge clk or negedge rst)
begin
	if(!rst)
		stp_err <= 1'b0;
	else if (stp_check_en && data_sampled)
		stp_err <= (sampled_bit == 1'b1) ? 1'b0 : 1'b1;
end
endmodule 