module fifo_rd#(
parameter depth = 8
)(
input	wire				rinc,
input	wire				rclk,
input	wire				rrst,
input	wire	[$clog2(depth):0]	wptr,
output	reg	[$clog2(depth)-1:0]	raddr,
output	wire	[$clog2(depth):0]	rptr,
output	wire				rempty
);

reg [$clog2(depth):0] rptr_bin;

assign rptr = (rptr_bin >> 1) ^ rptr_bin;
assign rempty = (wptr == rptr || wptr == (rptr + 1'b1)) ? 1'b1:1'b0;

always @(posedge rclk or negedge rrst)
begin
	if(!rrst)
	begin
		raddr <= {$clog2(depth){1'b0}};
		rptr_bin <= {$clog2(depth)+1{1'b0}};
	end
	else if (rinc)
	begin
		if (rptr_bin == depth-1) raddr <= {$clog2(depth){1'b0}};
		else raddr <= rptr_bin[$clog2(depth)-1:0]+1;
		if(rptr_bin == depth-1) rptr_bin <= {~rptr_bin[$clog2(depth)],{$clog2(depth){1'b0}}};
		else rptr_bin <= rptr_bin+1;
	end
end
endmodule 