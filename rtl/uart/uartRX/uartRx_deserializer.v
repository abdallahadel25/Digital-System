module uartRx_deserializer#(
parameter dataWidth = 8
)(
input 	wire					deserializer_en,
input 	wire					sampled_bit,
input 	wire					data_sampled,
input 	wire					clk,
input 	wire					rst,
input	wire	[3:0]			bit_cnt,
output	reg		[dataWidth-1:0]	p_data
);

always @(posedge clk or negedge rst)
begin
	if(!rst)
	begin
		p_data <= {dataWidth{1'b0}};
	end
	else if(deserializer_en && data_sampled)
	begin
		p_data[bit_cnt-1] <= sampled_bit;
	end
end
endmodule 