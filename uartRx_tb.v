`timescale 1us / 1ps

module uartRx_tb();

parameter clkPeriod_tx = 8.68;
parameter cases = 10;

reg		clk_tx;

reg		rx_in_tb;
reg		par_en_tb;
reg		par_type_tb;
wire		data_valid_tb;
reg 		clk_tb;
reg		rst_tb;
reg	[5:0]	prescale_tb;
wire	[7:0]	p_data_tb;

reg	[7:0]	test_data [0:cases-1];

integer i,j;

uartRx_top U0_uartRx(
.rx_in(rx_in_tb),
.prescale(prescale_tb),
.par_en(par_en_tb),
.par_type(par_type_tb),
.clk(clk_tb),
.rst(rst_tb),
.data_valid(data_valid_tb),
.p_data(p_data_tb)
);

task initialize;
begin
	clk_tb = 1'b1;
	clk_tx = 1'b1;
	rst_tb = 1'b1;
	prescale_tb = 6'h08;
	par_en_tb = 1'b1;
	par_type_tb = 1'b0;
	rx_in_tb = 1'b1;
	$readmemh("testCases.txt",test_data);
	@(negedge clk_tb);
end
endtask

task reset ;
begin
	rst_tb =  1'b1;
	#(clkPeriod_tx/prescale_tb)
	rst_tb  = 1'b0;
	#(clkPeriod_tx/prescale_tb)
    	rst_tb  = 1'b1;
	#(clkPeriod_tx/prescale_tb);
end
endtask

task send;
input [10:0] data;
begin
	for(j=0;j<11;j=j+1)
	begin
		@(posedge clk_tx)
		rx_in_tb = data[j];
	end
end
endtask

initial
begin

initialize();

reset();

$display("Prescale = 8");

for(i=0;i<10;i=i+1)
begin
	send({1'b1,^test_data[i],test_data[i],1'b0});
	repeat(2) @(posedge clk_tb);
	if ({p_data_tb,data_valid_tb} == {test_data[i],1'b1}) $display("Data = %h Data valid = %0b, passed",p_data_tb,data_valid_tb);
	else $display("Data = %h Data valid = %0b, failed",p_data_tb,data_valid_tb);
	repeat(i%2) @(posedge clk_tx);
end

prescale_tb = 6'h10;

$display("Prescale = 16");

for(i=0;i<10;i=i+1)
begin
	send({1'b1,^test_data[i],test_data[i],1'b0});
	repeat(2) @(posedge clk_tb);
	if ({p_data_tb,data_valid_tb} == {test_data[i],1'b1}) $display("Data = %h Data valid = %0b, passed",p_data_tb,data_valid_tb);
	else $display("Data = %h Data valid = %0b, failed",p_data_tb,data_valid_tb);
	repeat(i%2) @(posedge clk_tx);
end

prescale_tb = 6'h20;

$display("Prescale = 32");

for(i=0;i<10;i=i+1)
begin
	send({1'b1,^test_data[i],test_data[i],1'b0});
	repeat(2) @(posedge clk_tb);
	if ({p_data_tb,data_valid_tb} == {test_data[i],1'b1}) $display("Data = %h Data valid = %0b, passed",p_data_tb,data_valid_tb);
	else $display("Data = %h Data valid = %0b, failed",p_data_tb,data_valid_tb);
	repeat(i%2) @(posedge clk_tx);
end

#100 $stop();
end

always #(clkPeriod_tx/(2*prescale_tb)) clk_tb = ~(clk_tb);
always #(clkPeriod_tx/2) clk_tx = ~(clk_tx);

endmodule 