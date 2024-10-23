module DATA_SYNC #(
parameter stages = 2,
parameter dataWidth = 8
)(
input	wire						bus_enable,
input	wire						clk,
input	wire						rst,
input	wire	[dataWidth-1:0]	unsync_bus,
output	reg		[dataWidth-1:0]	sync_bus,
output	reg							enable_pulse
);

integer i;
wire	[dataWidth-1:0]	multiplexed_bus;
wire						comb_pulse;

reg		[stages-1:0]		meta_flop;
reg							pulse_gen;

assign comb_pulse = ~(pulse_gen) & meta_flop[stages-1];
assign multiplexed_bus = comb_pulse ? unsync_bus : sync_bus;

always @(posedge clk or negedge rst)
begin
	if(!rst)
		meta_flop <= {stages{1'b0}};
	else
	begin
		meta_flop[0] <= bus_enable;
		for(i=1;i<stages;i=i+1)
			meta_flop[i] <= meta_flop[i-1];
	end
end

always @(posedge clk or negedge rst)
begin

	if(!rst)
	begin
		pulse_gen <= 1'b0;
		enable_pulse <= 1'b0;
	end
	else
	begin
		pulse_gen <= meta_flop[stages-1];
		enable_pulse <= comb_pulse;
	end
end

always @(posedge clk or negedge rst)
begin
	if(!rst)
		sync_bus <= {dataWidth{1'b0}};
	else
		sync_bus <= multiplexed_bus;
end
endmodule 