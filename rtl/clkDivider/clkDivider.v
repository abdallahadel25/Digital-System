module clkDivider(
input 	wire 		i_ref_clk,
input 	wire 		i_rst_n,
input 	wire 		i_clk_en,
input 	wire [7:0]	i_div_ratio,
output 	wire		o_div_clk
);

wire 		clk_div_en;
reg			clk_div;
reg [6:0] 	counter;

assign clk_div_en = i_clk_en && (i_div_ratio != 8'h00) && (i_div_ratio != 8'h01);
assign o_div_clk = (clk_div_en) ? clk_div : i_ref_clk;


always @(posedge i_ref_clk or negedge i_rst_n)
begin
if(!i_rst_n)
begin
	counter <= 7'b000_0000;
	clk_div <= 1'b0;
end
else if(clk_div_en)
begin
	counter <= (counter != i_div_ratio-1) ? counter + 1 : 7'b000_0000;
	clk_div <= (counter < i_div_ratio >> 1) ? 1'b1 : 1'b0;
end
end
endmodule 