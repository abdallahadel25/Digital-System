module SYS_TOP (
input   wire   RST_N,
input   wire   UART_CLK,
input   wire   REF_CLK,
input   wire   UART_RX_IN,
output  wire   UART_TX_O,
output  wire   parity_error,
output  wire   framing_error
);

localparam dataWidth = 8;

localparam rstStages = 2;
localparam dataStages = 2;
localparam reg_div = 6;
localparam clk_div = 8;

localparam reg_depth = 16;
localparam fifo_depth = 8;

wire                            rst_sync_0;
wire                            rst_sync_1;
wire                            tx_clk;
wire                            rx_clk;
wire    [clk_div-1:0]           tx_div_ratio;
wire    [clk_div-1:0]           rx_div_ratio;
wire                            par_en_wire;
wire                            par_type_wire;
wire    [reg_div-1:0]           prescale_wire;
wire                            busy_pulse;
wire                            rinc_wire;
wire                            winc_wire;
wire    [dataWidth-1:0]         rdData_fifo;
wire    [dataWidth-1:0]         wrData_fifo;
wire                            fifo_empty;
wire                            fifo_full;
wire                            rx_d_valid_wire;
wire                            ctrl_d_valid_wire;
wire    [dataWidth-1:0]         p_data_rx_wire;
wire    [dataWidth-1:0]         p_data_ctrl_wire;
wire    [dataWidth-1:0]         wrData_wire;
wire    [dataWidth-1:0]         rdData_wire;
wire    [$clog2(reg_depth)-1:0] addr_wire;
wire                            wrEn_wire;
wire                            rdEn_wire;
wire                            rdData_valid_wire;
wire    [dataWidth-1:0]         op_A;
wire    [dataWidth-1:0]         op_B;
wire                            alu_clk;
wire                            alu_clk_en;
wire    [3:0]                   alu_fun_wire;
wire                            alu_en_wire;
wire    [dataWidth-1:0]         alu_out_wire;
wire                            alu_out_valid_wire;

RST_SYNC #(
    .stages(rstStages)
) RST_SYNC_U0 (
    .clk(REF_CLK),
    .rst(RST_N),
    .sync_rst(rst_sync_0)
);

RST_SYNC #(
    .stages(rstStages)
) RST_SYNC_U1 (
    .clk(UART_CLK),
    .rst(RST_N),
    .sync_rst(rst_sync_1)
);

uart_top #(
    .dataWidth(dataWidth)
) uart_U0 (
    .p_data_tx(rdData_fifo),
    .data_valid_tx(~fifo_empty),
    .par_en(par_en_wire),
    .par_type(par_type_wire),
    .rx_in(UART_RX_IN),
    .prescale(prescale_wire),
    .clk_tx(tx_clk),
    .clk_rx(rx_clk),
    .rst(rst_sync_1),
    .tx_out(UART_TX_O),
    .busy(busy_pulse),
    .data_valid_rx(rx_d_valid_wire),
    .p_data_rx(p_data_rx_wire),
    .par_error(parity_error),
    .framing_error(framing_error)
);

DATA_SYNC #(
    .stages(dataStages),
    .dataWidth(dataWidth)
) DATA_SYNC_U0 (
    .bus_enable(rx_d_valid_wire),
    .clk(REF_CLK),
    .rst(rst_sync_1),
    .unsync_bus(p_data_rx_wire),
    .sync_bus(p_data_ctrl_wire),
    .enable_pulse(ctrl_d_valid_wire)
);

pulse_gen pulse_gen_U0 (
    .clk(tx_clk),
    .rst(rst_sync_1),
    .lvl_sig(busy_pulse),
    .pulse_sig(rinc_wire)
);

clkDivider divClk_tx(
    .i_ref_clk(UART_CLK),
    .i_rst_n(rst_sync_1),
    .i_clk_en(1'b1),
    .i_div_ratio(tx_div_ratio),
    .o_div_clk(tx_clk)
);

div_mux #(
    .widthInput(reg_div),
    .widthOutput(clk_div)
) div_mux_rx (
    .in(prescale_wire),
    .out(rx_div_ratio)
);

clkDivider divClk_rx(
    .i_ref_clk(UART_CLK),
    .i_rst_n(rst_sync_1),
    .i_clk_en(1'b1),
    .i_div_ratio(rx_div_ratio),
    .o_div_clk(rx_clk)
);

regFile #(
    .dataWidth(dataWidth),
    .depth(reg_depth)
) regFile_U0 (
    .wrData(wrData_wire),
    .addr(addr_wire),
    .wrEn(wrEn_wire),
    .rdEn(rdEn_wire),
    .clk(REF_CLK),
    .rst(rst_sync_0),
    .rdData(rdData_wire),
    .rdData_valid(rdData_valid_wire),
    .reg_0(op_A),
    .reg_1(op_B),
    .reg_2({prescale_wire,par_type_wire,par_en_wire}),
    .reg_3(tx_div_ratio)
);

fifo_top #(
    .depth(fifo_depth),
    .data_width(dataWidth)
) fifo_U0 (
    .wclk(REF_CLK),
    .wrst(rst_sync_0),
    .winc(winc_wire),
    .rclk(tx_clk),
    .rrst(rst_sync_1),
    .rinc(rinc_wire),
    .wdata(wrData_fifo),
    .rdata(rdData_fifo),
    .wfull(fifo_full),
    .rempty(fifo_empty)
);

alu #(
    .dataWidth(8)
) alu_U0 (
    .A(op_A),
    .B(op_B),
    .alu_fun(alu_fun_wire),
    .alu_en(alu_en_wire),
    .clk(alu_clk),
    .rst(rst_sync_0),
    .alu_out(alu_out_wire),
    .out_valid(alu_out_valid_wire)
);

clk_gate clk_gate_alu (
    .clk_en(alu_clk_en),
    .clk(REF_CLK),
    .gated_clk(alu_clk)
);

sys_control #(
    .dataWidth(dataWidth),
    .depth(reg_depth)
) sys_control_U0 (
    .clk(REF_CLK),
    .rst(rst_sync_0),
    .alu_out(alu_out_wire),
    .out_valid(alu_out_valid_wire),
    .rdData(rdData_wire),
    .rdData_valid(rdData_valid_wire),
    .rx_p_data(p_data_ctrl_wire),
    .rx_d_valid(ctrl_d_valid_wire),
    .fifo_full(fifo_full),
    .alu_fun(alu_fun_wire),
    .alu_en(alu_en_wire),
    .clk_en(alu_clk_en),
    .addr(addr_wire),
    .wrEn(wrEn_wire),
    .rdEn(rdEn_wire),
    .wrData(wrData_wire),
    .tx_p_data(wrData_fifo),
    .tx_d_valid(winc_wire)
);

endmodule