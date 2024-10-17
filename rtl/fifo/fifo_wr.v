module fifo_wr#(
parameter depth = 8
)(
input	wire				winc,
input	wire				wclk,
input	wire				wrst,
input	wire	[$clog2(depth):0]	rptr,
output	reg	[$clog2(depth)-1:0]	waddr,
output	wire	[$clog2(depth):0]	wptr,
output	wire				wfull
);

reg [$clog2(depth):0] wptr_bin;

assign wptr = (wptr_bin >> 1) ^ wptr_bin;
assign wfull = (wptr == {~rptr[$clog2(depth)],~rptr[$clog2(depth)-1],rptr[$clog2(depth)-2:0]}) ? 1'b1:1'b0;

always @(posedge wclk or negedge wrst)
begin
	if(!wrst)
	begin
		waddr <= {$clog2(depth){1'b0}};
		wptr_bin <= {{$clog2(depth){1'b0}},{1'b1}};
	end
	else if (winc)
	begin
		waddr <= wptr_bin[$clog2(depth)-1:0];
		if(wptr_bin == depth-1) wptr_bin <= {~wptr_bin[$clog2(depth)],{$clog2(depth){1'b0}}};
		else wptr_bin <= wptr_bin+1;
	end
end
endmodule 