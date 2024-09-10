module fsm(
input	wire 		data_valid,
input 	wire 		par_en,
input 	wire 		ser_done,
input	wire		clk,
input	wire		rst,
output	reg 		ser_en,
output 	reg	[2:0] 	mux_sel,
output	reg 		busy
);

typedef enum bit [2:0]{
	IDLE 		= 3'b000,
	startBit 	= 3'b001,
	data 		= 3'b010,
	parity 		= 3'b011,
	stopBit 	= 3'b100
}state_e;

state_e currentState;
state_e nextState;

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
	data	:begin
		if(!ser_done) nextState = data;
		else if (par_en) nextState = parity;
		else nextState = stopBit;
	end
	parity	:	nextState = stopBit;
	stopBit	:	nextState = data_valid ? startBit : IDLE;
endcase
end

always @(*)
begin
case(currentState)
	IDLE:begin
		ser_en = 1'b0;
		busy = 1'b0;
	end
	startBit:begin
		ser_en = 1'b1;
		busy = 1'b1;
	end
	data:begin
		ser_en = 1'b0;
		busy = 1'b1;
	end
	parity:begin
		ser_en = 1'b0;
		busy = 1'b1;
	end
	stopBit:begin
		ser_en = 1'b0;
		busy = 1'b1;
	end
	default:begin
		ser_en = 1'b0;
		busy = 1'b0;
	end
endcase
end
endmodule 