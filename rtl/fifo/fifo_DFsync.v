module fifo_DFsync #(
parameter data_width = 8
)(
input	wire						clk,
input	wire						rst,
input	wire	[data_width-1:0]	data,
output	reg		[data_width-1:0]	sync_data
);

reg [data_width-1:0] meta_flop;

always @(posedge clk or negedge rst)
begin
	if(!rst)
	begin
		meta_flop <= {data_width{1'b0}};
		sync_data <= {data_width{1'b0}};
	end
	else
	begin
		meta_flop <= data;
		sync_data <= meta_flop;
	end
end
endmodule 