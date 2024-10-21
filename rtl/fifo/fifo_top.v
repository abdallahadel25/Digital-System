module fifo_top#(
parameter depth = 8,
parameter data_width = 8
)(
input	wire				        wclk,
input	wire				        wrst,
input	wire				        winc,
input	wire				        rclk,
input	wire				        rrst,
input	wire				        rinc,
input	wire	[data_width-1:0]	wdata,
output	wire	[data_width-1:0]	rdata,
output	wire				        wfull,
output	wire				        rempty
);

localparam p_width = $clog2(depth);

wire	[p_width-1:0]	waddr;
wire	[p_width-1:0]	raddr;
wire	[p_width:0]	    wptr;
wire	[p_width:0]	    rptr;
wire	[p_width:0]	    wptr_sync;
wire	[p_width:0]	    rptr_sync;

fifo_mem #(
.depth(depth),
.data_width(data_width)
) U0_mem(
.wdata(wdata),
.waddr(waddr),
.winc(winc),
.wfull(wfull),
.wclk(wclk),
.wrst(wrst),
.raddr(raddr),
.rdata(rdata)
);

fifo_wr #(
.depth(depth)
) U0_wr (
.winc(winc),
.wclk(wclk),
.wrst(wrst),
.rptr(rptr_sync),
.waddr(waddr),
.wptr(wptr),
.wfull(wfull)
);

fifo_rd #(
.depth(depth)
) U0_rd (
.rinc(rinc),
.rclk(rclk),
.rrst(rrst),
.wptr(wptr_sync),
.raddr(raddr),
.rptr(rptr),
.rempty(rempty)
);

fifo_DFsync #(
.data_width(p_width+1)
) rptr_DF (
.clk(wclk),
.rst(wrst),
.data(rptr),
.sync_data(rptr_sync)
);

fifo_DFsync #(
.data_width(p_width+1)
) wptr_DF (
.clk(rclk),
.rst(rrst),
.data(wptr),
.sync_data(wptr_sync)
);

endmodule 