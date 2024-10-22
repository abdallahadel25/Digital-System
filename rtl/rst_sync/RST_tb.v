module RST_tb();

parameter clkPeriod = 10;
parameter stages = 2;

reg	clk;
reg	rst;
wire	sync_rst;

RST_SYNC #(
.stages(stages)
) DUT (
.clk(clk),
.rst(rst),
.sync_rst(sync_rst)
);

always #(clkPeriod/2) clk = ~clk;

task initialize ;
begin
	clk = 1'b1;
	rst = 1'b1;
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

#100 $stop();
end
endmodule 