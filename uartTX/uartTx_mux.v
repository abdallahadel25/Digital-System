module uartMux#(
parameter muxSelWidth = 3
)(
input 	wire [muxSelWidth-1:0]	mux_sel,
input 	wire  			ser_data,
input 	wire 			par,
output 	reg 			tx_out
);

localparam [2:0] IDLE 		= 3'b000;
localparam [2:0] startBit 	= 3'b001;
localparam [2:0] data	 	= 3'b010;
localparam [2:0] parity		= 3'b011;
localparam [2:0] stopBit 	= 3'b100;

always @(*)
begin
case(mux_sel)
	IDLE: tx_out = 1'b1;
	startBit: tx_out = 1'b0;
	data: tx_out = ser_data;
	parity: tx_out = par;
	stopBit: tx_out = 1'b1;
endcase
end
endmodule 