module uartRx_top(
input	wire		rx_in,
input	wire	[5:0]	prescale,
input	wire		par_en,
input	wire		par_type,
input	wire		clk,
input	wire		rst,
output	wire		data_valid,
output	wire	[7:0]	p_data
);

wire		data_sample_en;
wire	[4:0]	edge_cnt;
wire		sampled_bit;
wire		data_sampled;
wire	[3:0]	bit_cnt;
wire		par_err;
wire		strt_glitch;
wire		stp_err;
wire		edge_cnt_en;
wire		par_check_en;
wire		strt_check_en;
wire		stp_check_en;
wire		deserializer_en;

uartRX_dataSampling U0_dataSampling(
.prescale(prescale),
.rx_in(rx_in),
.data_sample_en(data_sample_en),
.edge_cnt(edge_cnt),
.clk(clk),
.rst(rst),
.sampled_bit(sampled_bit),
.data_sampled(data_sampled)
);

uartRx_edge_counter U0_edge_counter(
.edge_cnt_en(edge_cnt_en),
.clk(clk),
.rst(rst),
.prescale(prescale),
.edge_cnt(edge_cnt),
.bit_cnt(bit_cnt)
);

uartRXFSM U0_fsm(
.rx_in(rx_in),
.par_en(par_en),
.bit_cnt(bit_cnt),
.par_err(par_err),
.strt_glitch(strt_glitch),
.stp_err(stp_err),
.clk(clk),
.rst(rst),
.data_sample_en(data_sample_en),
.edge_cnt_en(edge_cnt_en),
.par_check_en(par_check_en),
.strt_check_en(strt_check_en),
.stp_check_en(stp_check_en),
.deserializer_en(deserializer_en),
.data_valid(data_valid)
);

uartRx_deserializer U0_deserializer(
.deserializer_en(deserializer_en),
.sampled_bit(sampled_bit),
.data_sampled(data_sampled),
.clk(clk),
.rst(rst),
.bit_cnt(bit_cnt),
.p_data(p_data)
);

uartRx_parity U0_parity(
.par_check_en(par_check_en),
.sampled_bit(sampled_bit),
.data_sampled(data_sampled),
.par_type(par_type),
.p_data(p_data),
.clk(clk),
.rst(rst),
.par_err(par_err)
);

uartRx_strt U0_strt(
.strt_check_en(strt_check_en),
.sampled_bit(sampled_bit),
.data_sampled(data_sampled),
.clk(clk),
.rst(rst),
.strt_glitch(strt_glitch)
);

uartRx_stop U0_stop(
.stp_check_en(stp_check_en),
.sampled_bit(sampled_bit),
.data_sampled(data_sampled),
.clk(clk),
.rst(rst),
.stp_err(stp_err)
);

endmodule 