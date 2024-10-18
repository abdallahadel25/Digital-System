module fsm(
input	wire 		data_valid,
input 	wire 		par_en,
input 	wire 		ser_done,
input	wire		clk,
input	wire		rst,
output	wire 		ser_en,
output 	reg	[2:0] 	mux_sel,
output	wire 		busy
);

localparam	IDLE 		= 3'b000;
localparam	startBit 	= 3'b001;
localparam	data 		= 3'b010;
localparam	parity 		= 3'b011;
localparam	stopBit 	= 3'b100;

reg [2:0]	currentState;
reg [2:0]	nextState;

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        currentState <= IDLE;
		mux_sel <= IDLE;
    end
    else
    begin
        currentState <= nextState;
		mux_sel <= nextState;
    end
end

always @(*)
begin
case(currentState)
	IDLE	: 	nextState = data_valid ? startBit : IDLE;
	startBit:	nextState = data;
	data	:	begin
		if(!ser_done) nextState = data;
		else if (par_en) nextState = parity;
		else nextState = stopBit;
		end
	parity	:	nextState = stopBit;
	stopBit	:	nextState = data_valid ? startBit : IDLE;
	default	:	nextState = IDLE;
endcase
end

assign ser_en 	= (currentState == startBit) ? 1'b1 : 1'b0;
assign busy 	= (currentState != IDLE) | (!rst);

endmodule 