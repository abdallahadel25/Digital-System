module uartRX_dataSampling(
input	wire	[5:0]	prescale,
input	wire			rx_in,
input	wire			data_sample_en,
input	wire	[4:0]	edge_cnt,
input	wire			clk,	
input	wire			rst,
output	reg				sampled_bit,
output	reg				data_sampled
);

reg s1;
reg s2;

wire [4:0] s1_en;
wire [4:0] s2_en;
wire [4:0] out_en;

assign s1_en = (prescale >> 1) - 2;
assign s2_en = (prescale >> 1) - 1;
assign out_en = (prescale >> 1);

always @(posedge clk or negedge rst)
begin

if (!rst)
begin
	sampled_bit <= 1'b0;
	s1 <= 1'b0;
	s2 <= 1'b0;
	data_sampled <= 1'b0;
end
else if (data_sample_en)
begin
	data_sampled <= 1'b0;
	case (edge_cnt)
		s1_en : s1 <= rx_in;
		s2_en : s2 <= rx_in;
		out_en : begin
			sampled_bit <= (s1 & s2) | (s2 & rx_in) | (s1 & rx_in);
			data_sampled <= 1'b1;
		end
	endcase
end
end
endmodule 