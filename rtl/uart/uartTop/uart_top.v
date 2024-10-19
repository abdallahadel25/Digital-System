module uart_top#(
parameter dataWidth = 8
)(
input   wire [dataWidth-1:0]    p_data_tx,
input   wire                    data_valid_tx,
input   wire                    par_en,
input   wire                    par_type,
input   wire                    rx_in,
input   wire [5:0]              prescale,
input   wire                    clk_tx,
input   wire                    clk_rx,
input   wire                    rst,
output  wire                    tx_out,
output  wire                    busy,
output  wire                    data_valid_rx,
output  wire [dataWidth-1:0]    p_data_rx
);

uartTX_top #(
    .dataWidth(dataWidth)
) U0_uartTx(
.p_data(p_data_tx),
.data_valid(data_valid_tx),
.par_en(par_en),
.par_type(par_type),
.clk(clk_tx),
.rst(rst),
.tx_out(tx_out),
.busy(busy)
);

uartRx_top #(
    .dataWidth(dataWidth)
) U0_uartRx(
.rx_in(rx_in),
.prescale(prescale),
.par_en(par_en),
.par_type(par_type),
.clk(clk_rx),
.rst(rst),
.data_valid(data_valid_rx),
.p_data(p_data_rx)
);

endmodule