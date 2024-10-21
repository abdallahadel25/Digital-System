module clkDivider_tb;

parameter clkPeriod = 10;

reg 		clk_tb;
reg 		rst_tb;
reg 		clk_div_en_tb;
reg 	[7:0] 	div_ratio_tb;
wire 		div_clk_tb;

integer i;

clkDivider DUT(
.i_ref_clk(clk_tb),
.i_rst_n(rst_tb),
.i_clk_en(clk_div_en_tb),
.i_div_ratio(div_ratio_tb),
.o_div_clk(div_clk_tb)
);

task initialize;
begin
	clk_tb = 1'b1;
	rst_tb = 1'b1;
	clk_div_en_tb = 1'b0;
	div_ratio_tb = 4'b0000;
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

always #(clkPeriod/2) clk_tb = ~(clk_tb);

initial
begin

initialize();

reset();

clk_div_en_tb = 1'b1;

for(i=1;i<9;i = i+1)
begin
	div_ratio_tb = i;
	#(clkPeriod *16);
end

#200 $stop();

end
endmodule 