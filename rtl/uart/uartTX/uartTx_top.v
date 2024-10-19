module uartTX_top#(
parameter dataWidth = 8
)(
input 	wire [dataWidth-1:0]	p_data,
input 	wire					data_valid,
input 	wire					par_en,
input 	wire					par_type,
input	wire					clk,
input	wire					rst,
output 	wire					tx_out,
output	wire					busy
);

wire 		ser_en;
wire 		ser_data;
wire 		ser_done;
wire [2:0] 	mux_sel;
wire		par;

serializer #(
	.dataWidth(dataWidth)
)serializer_U0(
	.p_data(p_data),
	.ser_en(ser_en),
	.clk(clk),
	.rst(rst),
	.ser_data(ser_data),
	.ser_done(ser_done)
);

fsm fsm_U0(
	.data_valid(data_valid),
	.par_en(par_en),
	.ser_done(ser_done),
	.clk(clk),
	.rst(rst),
	.ser_en(ser_en),
	.mux_sel(mux_sel),
	.busy(busy)
);

parity #(
	.dataWidth(dataWidth)
)parity_U0(
	.p_data(p_data),
	.data_valid(data_valid),
	.par_type(par_type),
	.clk(clk),
	.rst(rst),
	.par(par)
);

uartMux #(
	.muxSelWidth($clog2(dataWidth))
)uartMux_U0(
	.mux_sel(mux_sel),
	.ser_data(ser_data),
	.par(par),
	.tx_out(tx_out)
);
endmodule 