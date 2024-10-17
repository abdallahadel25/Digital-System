module fifo_mem#(
parameter depth = 8,
parameter data_width = 8
)(
input	wire	[data_width-1:0]	wdata,
input	wire	[$clog2(depth)-1:0]	waddr,
input	wire				winc,
input	wire				wfull,
input	wire				wclk,
input	wire				wrst,
input	wire	[$clog2(depth)-1:0]	raddr,
output	reg	[data_width-1:0]	rdata
);

wire wclken;
integer i;

reg [data_width-1:0] fifo [0:depth-1];

assign wclken = winc & ~(wfull);

always @(posedge wclk or negedge wrst)
begin
	if(!wrst)
		for(i=0;i<depth;i=i+1) fifo[i] <= {data_width{1'b0}};
	else if (wclken)
		fifo[waddr] <= wdata;
end

always @(*)
begin
	rdata = fifo[raddr];
end

endmodule 