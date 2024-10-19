module uartRx_parity#(
parameter dataWidth = 8
)(
input	wire					par_check_en,
input	wire					sampled_bit,
input	wire					data_sampled,
input	wire					par_type,
input	wire	[dataWidth-1:0]	p_data,
input	wire					clk,
input	wire					rst,
output	reg						par_err
);

wire par;

assign par = par_type ? ~^p_data : ^p_data;

always @(posedge clk or negedge rst)
begin
	if(!rst)
		par_err <= 1'b0;
	else if(par_check_en && data_sampled)
	begin
		par_err <= (par == sampled_bit) ? 1'b0 : 1'b1;
	end
end
endmodule 