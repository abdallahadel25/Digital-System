module fifo_wr#(
parameter depth = 8
)(
input	wire						winc,
input	wire						wclk,
input	wire						wrst,
input	wire	[$clog2(depth):0]	rptr,
output	wire	[$clog2(depth)-1:0]	waddr,
output	wire	[$clog2(depth):0]	wptr,
output	wire						wfull
);

localparam p_width = $clog2(depth);

reg [p_width:0] wptr_bin;

assign wptr = (wptr_bin >> 1) ^ wptr_bin;
assign wfull = (wptr == {~rptr[p_width],~rptr[p_width-1],rptr[p_width-2:0]}) ? 1'b1:1'b0;
assign waddr = wptr_bin[p_width-1:0];

always @(posedge wclk or negedge wrst)
begin
	if(!wrst)
	begin
		wptr_bin <= {p_width+1{1'b0}};
	end
	else if (winc && !wfull)
	begin
		wptr_bin <= wptr_bin+1;
	end
end

endmodule 