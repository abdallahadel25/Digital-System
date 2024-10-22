module DATA_tb();

parameter clkPeriod = 10;
parameter data_width = 8;
parameter stages = 3;

parameter testCases = 10;

reg							bus_enable;
reg							clk;
reg							rst;
reg		[data_width-1:0]	unsync_bus;
wire	[data_width-1:0]	sync_bus;
wire						enable_pulse;

reg	[data_width-1:0] testData [0:testCases-1];

integer i;

DATA_SYNC #(
.stages(stages),
.data_width(data_width)
) DUT (
.bus_enable(bus_enable),
.clk(clk),
.rst(rst),
.unsync_bus(unsync_bus),
.sync_bus(sync_bus),
.enable_pulse(enable_pulse)
);

always #(clkPeriod/2) clk = ~clk;

task initialize ;
begin
	clk = 1'b1;
	rst = 1'b1;
	bus_enable = 1'b0;
	$readmemh("rtl/data_sync/testCases.txt",testData);
	@(negedge clk);
end
endtask

task reset ;
begin
	rst = 1'b1;
	#(clkPeriod)
	rst = 1'b0;
	#(clkPeriod)
	rst = 1'b1;
end
endtask

initial
begin

	initialize();

	reset();

	for(i=0;i<testCases;i=i+1)
	begin
		bus_enable = 1'b1;
		unsync_bus = testData[i];
		#(clkPeriod)
		bus_enable = 1'b0;
		@(posedge enable_pulse)
		if (sync_bus == testData[i]) $display("Data = %0h , passed",sync_bus);
		else $display("Data = %0h , failed",sync_bus);
		#(clkPeriod);
	end
	#100 $stop();
end
endmodule 