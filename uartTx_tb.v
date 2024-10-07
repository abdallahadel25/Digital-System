`timescale 1ns\1ps

module uartTx_tb;

parameter clkPeriod = 5;
parameter cases = 10;
parameter dataWidth = 8;

reg [dataWidth-1:0] testCases [0:cases-1];
reg [dataWidth+2:0] fetchedData;
integer i,j;

reg [7:0] 	p_data_tb;
reg 		data_valid_tb;
reg 		par_en_tb;
reg 		par_type_tb;
reg 		clk_tb;
reg			rst_tb;
wire		tx_out_tb;
wire		busy_tb;

uartTX_top #(
.dataWidth(dataWidth),
.counterWidth(3),
.muxSelWidth(3)
)DUT(
.p_data(p_data_tb),
.data_valid(data_valid_tb),
.par_en(par_en_tb),
.par_type(par_type_tb),
.clk(clk_tb),
.rst(rst_tb),
.tx_out(tx_out_tb),
.busy(busy_tb)
);

task initialize;
begin
	clk_tb = 1'b1;
	rst_tb = 1'b1;
	data_valid_tb = 1'b0;
	par_en_tb = 1'b1;
	par_type_tb = 1'b0;
	$readmemh("testCases.txt",testCases);
	@(negedge clk_tb);
end
endtask

task reset ;
begin
	rst_tb =  1'b1;
	#(clkPeriod)
	rst_tb  = 1'b0;
	#(clkPeriod)
    	rst_tb  = 1'b1;
	#(clkPeriod);
end
endtask

task send;
input [7:0] data;
begin
	p_data_tb=data;
	data_valid_tb = 1'b1;
	@(posedge clk_tb)
	data_valid_tb = 1'b0;
end
endtask

task readData;
begin
	#(clkPeriod/2)
	for(j=0;j<11;j=j+1)
	begin
		fetchedData[j] = tx_out_tb;
		#(clkPeriod);
	end
end
endtask

always #(clkPeriod/2) clk_tb = ~(clk_tb);

initial
begin

$dumpfile("uartTx.vcd");
$dumpvars;

initialize();

reset();

for(i=0;i<10;i=i+1)
begin
	send(testCases[i]);
	@(negedge busy_tb);
	if (fetchedData == {1'b1,^testCases[i],testCases[i],1'b0})
		$display("Test case %0d : %0h , passed %b",i,testCases[i],fetchedData);
	else
		$display("Test case %0d : %0h , failed %b",i,testCases[i],fetchedData);
end

#200 $stop();
end

always @(posedge busy_tb) readData();
endmodule
