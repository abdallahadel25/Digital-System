module RST_SYNC #(
parameter stages = 2
)(
input	wire	clk,
input	wire	rst,
output	reg		sync_rst
);

integer i;

reg [stages-2:0] meta_flop;

always @(posedge clk or negedge rst)
begin
	if(!rst)
	begin
		meta_flop <= {stages-1{1'b0}};
		sync_rst <= 1'b0;
	end
	else
	begin
		meta_flop[0] <= 1'b1;
		for(i=1;i<stages-1;i=i+1)
			meta_flop[i] <= meta_flop[i-1];
		sync_rst <= meta_flop[stages-2];
	end
end
endmodule 