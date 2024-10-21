module fifo_rd#(
parameter depth = 8
)(
input	wire						rinc,
input	wire						rclk,
input	wire						rrst,
input	wire	[$clog2(depth):0]	wptr,
output	wire	[$clog2(depth)-1:0]	raddr,
output	wire	[$clog2(depth):0]	rptr,
output	wire						rempty
);

localparam p_width = $clog2(depth);

reg [p_width:0] rptr_bin;

assign rptr = (rptr_bin >> 1) ^ rptr_bin;
assign rempty = (wptr == rptr) ? 1'b1:1'b0;
assign raddr = rptr_bin[p_width-1:0];

always @(posedge rclk or negedge rrst)
begin
	if(!rrst)
	begin
		rptr_bin <= {p_width+1{1'b0}};
	end
	else if (rinc && !rempty)
	begin
		rptr_bin <= rptr_bin+1;
	end
end

endmodule 