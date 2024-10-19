`timescale 1us / 1ps

module uartRx_tb();

parameter clkPeriod_tx = 8.68;
parameter total_cases = 10;
parameter test_cases  = 10;
parameter prescale_itt = 3;

reg				clk_tx;

reg				rx_in_tb;
reg				par_en_tb;
reg				par_type_tb;
wire			data_valid_tb;
reg 			clk_tb;
reg				rst_tb;
reg		[5:0]	prescale_tb;
wire	[7:0]	p_data_tb;

reg	[7:0]	test_data [0:total_cases-1];
reg [5:0]	prescale_data [0:prescale_itt-1];

integer i,m,n,k=0,z;

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
	par_en_tb = 1'b0;
	par_type_tb = 1'b1;
	rx_in_tb = 1'b1;

	prescale_data[0] = 6'h08;
	prescale_data[1] = 6'h10;
	prescale_data[2] = 6'h20;
	prescale_tb = prescale_data[0];
	
	$readmemh("rtl/uart/testCases.txt",test_data);
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

task send_par;
input [10:0] data;
begin
	for(m=0;m<11;m=m+1)
	begin
		@(posedge clk_tx)
		rx_in_tb = data[m];
	end
end
endtask

task send_npar;
input [9:0] data_n;
begin
	for(n=0;n<10;n=n+1)
	begin
		@(posedge clk_tx)
		rx_in_tb = data_n[n];
	end
end
endtask

initial
begin

$dumpfile("rtl/uartRX/uartRx.vcd");
$dumpvars;

initialize();

reset();

for(z=0;z<prescale_itt;z=z+1)
begin
	prescale_tb = prescale_data[z];
	$display("Prescale = %0d",prescale_data[z]);

	for(i=0;i<test_cases;i=i+1)
	begin
		if(par_en_tb && !par_type_tb) send_par({1'b1,^test_data[i],test_data[i],1'b0});
		else if(par_en_tb && par_type_tb) send_par({1'b1,~^test_data[i],test_data[i],1'b0});
		else send_npar({1'b1,test_data[i],1'b0});
		repeat(i%2) @(posedge clk_tx);
	end
	@(posedge clk_tx);
end

#100 $stop();
end

always @(posedge data_valid_tb)
begin
	if ({p_data_tb,data_valid_tb} == {test_data[k],1'b1}) $display("Data = %h Data valid = %0b, passed",p_data_tb,data_valid_tb);
	else $display("Data = %h Data valid = %0b, failed",p_data_tb,data_valid_tb);
	if (k != test_cases-1) k = k+1;
	else k = 0;
end

always #(clkPeriod_tx/(2*prescale_tb)) clk_tb = ~(clk_tb);
always #(clkPeriod_tx/2) clk_tx = ~(clk_tx);

endmodule 