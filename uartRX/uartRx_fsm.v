module uartRXFSM(
input	wire		rx_in,
input	wire		par_en,
input	wire	[3:0]	bit_cnt,
input	wire		par_err,
input	wire		strt_glitch,
input	wire		stp_err,
input	wire		clk,
input	wire		rst,
output	reg		data_sample_en,
output	reg		edge_cnt_en,
output	reg		par_check_en,
output	reg		strt_check_en,
output	reg		stp_check_en,
output	reg		deserializer_en,
output	reg		data_valid
);

localparam [2:0] IDLE = 3'b000;
localparam [2:0] start_bit = 3'b001;
localparam [2:0] data = 3'b011;
localparam [2:0] parity_bit = 3'b010; 
localparam [2:0] end_bit = 3'b110;

reg [2:0] currentState;
reg [2:0] nextState;

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        currentState <= IDLE;
    end
    else
    begin
        currentState <= nextState;
    end
end

always @(*)
begin
case(currentState)
	IDLE : nextState = (!rx_in) ? start_bit : IDLE;
	start_bit : begin
		if(bit_cnt == 1)
		begin
			if(strt_glitch) nextState = IDLE;
			else 		nextState = data;
		end
		else nextState = start_bit;
		end
	data : nextState = (bit_cnt == 9) ? parity_bit : data;
	parity_bit : nextState = (bit_cnt == 10) ? end_bit : parity_bit;
	end_bit : begin
		if(bit_cnt == 0)
		begin
			if(!rx_in) nextState = start_bit;
			else nextState = IDLE;
		end
		else nextState = end_bit;
		end
	default : nextState = IDLE;
endcase
end

always @(*)
begin
case(currentState)
	IDLE : begin
		data_sample_en = 1'b0;
		edge_cnt_en = 1'b0;
		strt_check_en = 1'b0;
		deserializer_en = 1'b0;
		par_check_en = 1'b0;
		stp_check_en = 1'b0;
		data_valid = 1'b0;
	end
	start_bit : begin
		data_sample_en = 1'b1;
		edge_cnt_en = 1'b1;
		strt_check_en = 1'b1;
		deserializer_en = 1'b0;
		par_check_en = 1'b0;
		stp_check_en = 1'b0;
		data_valid = 1'b0;
	end
	data : begin
		data_sample_en = 1'b1;
		edge_cnt_en = 1'b1;
		strt_check_en = 1'b0;
		deserializer_en = 1'b1;
		par_check_en = 1'b0;
		stp_check_en = 1'b0;
		data_valid = 1'b0;
	end
	parity_bit : begin
		data_sample_en = 1'b1;
		edge_cnt_en = 1'b1;
		strt_check_en = 1'b0;
		deserializer_en = 1'b0;
		par_check_en = 1'b1;
		stp_check_en = 1'b0;
		data_valid = 1'b0;
	end
	end_bit : begin
		data_sample_en = 1'b1;
		edge_cnt_en = 1'b1;
		strt_check_en = 1'b0;
		deserializer_en = 1'b0;
		par_check_en = 1'b0;
		stp_check_en = 1'b1;
		data_valid = ({par_err,stp_err}==2'b00) ? 1'b1 : 1'b0;
	end
	default : begin
		data_sample_en = 1'b0;
		edge_cnt_en = 1'b0;
		strt_check_en = 1'b0;
		deserializer_en = 1'b0;
		par_check_en = 1'b0;
		stp_check_en = 1'b0;
		data_valid = 1'b0;
	end
endcase
end
endmodule 