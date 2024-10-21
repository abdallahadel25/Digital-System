`timescale 1ns/1ps

module fifo_tb();

parameter data_width = 8;
parameter depth = 8; // minimum is 6

parameter wclk_period = 10;
parameter rclk_period = 25;

parameter testCases = 10;

reg							wclk_tb;
reg							wrst_tb;
reg							winc_tb;
reg							rclk_tb;
reg							rrst_tb;
reg							rinc_tb;
reg		[data_width-1:0]	wdata_tb;
wire	[data_width-1:0]	rdata_tb;
wire						wfull_tb;
wire						rempty_tb;

reg	[data_width-1:0]	testData [0:testCases-1];

integer i,j;

always #(wclk_period/2) wclk_tb = ~ wclk_tb;
always #(rclk_period/2.0) rclk_tb = ~ rclk_tb;

fifo_top #(
.depth(depth),
.data_width(data_width)
) async_fifo (
.wclk(wclk_tb),
.wrst(wrst_tb),
.winc(winc_tb),
.rclk(rclk_tb),
.rrst(rrst_tb),
.rinc(rinc_tb),
.wdata(wdata_tb),
.rdata(rdata_tb),
.wfull(wfull_tb),
.rempty(rempty_tb)
);

task initialize_wr ;
begin
	wclk_tb = 1'b1;
	wrst_tb = 1'b1;
	winc_tb = 1'b0;	
	$readmemh("rtl/fifo/testCases.txt",testData);
	@(negedge wclk_tb);
end
endtask

task initialize_rd ;
begin
	rclk_tb = 1'b1;
	rrst_tb = 1'b1;
	rinc_tb = 1'b0;
	@(negedge rclk_tb);
end
endtask

task reset_wr ;
begin
	wrst_tb =  1'b1;
	#(wclk_period)
	wrst_tb  = 1'b0;
	#(wclk_period)
	wrst_tb  = 1'b1;
end
endtask

task reset_rd ;
begin
	rrst_tb =  1'b1;
	#(rclk_period)
	rrst_tb  = 1'b0;
	#(rclk_period)
	rrst_tb  = 1'b1;
end
endtask

initial
begin

initialize_wr();

reset_wr();

@(posedge rrst_tb)
// #(wclk_period*5)

for(i=0;i<testCases;i=i+1)
begin
	wdata_tb = testData[i];
	winc_tb = 1'b1;
	#(wclk_period);
	winc_tb = 1'b0;
end
end

initial
begin

initialize_rd();

reset_rd();

j=0;

wait(~rempty_tb);

while(~rempty_tb)
begin
	@(negedge rclk_tb)
	if({rdata_tb,rempty_tb} == {testData[j],1'b0}) $display("Data = %0h Empty = %0b , passed",rdata_tb,rempty_tb);
	else if (rdata_tb != testData[j] && rempty_tb == 1'b1) $display("Data = %0h Empty = %0b , passed",rdata_tb,rempty_tb);
	else $display("Data = %0h Empty = %0b , failed",rdata_tb,rempty_tb);
	
	rinc_tb = 1'b1;
	@(posedge rclk_tb)
	rinc_tb = 1'b0;
	
	j = j+1;

	@(rdata_tb);
end

end

initial #800 $stop();

endmodule 