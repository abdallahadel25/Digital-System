module uartRx_edge_counter(
input	wire		edge_cnt_en,
input	wire		clk,
input	wire		rst,
input	wire	[5:0]	prescale,
output	reg	[4:0]	edge_cnt,
output	reg	[3:0]	bit_cnt
);

always @(posedge clk or negedge rst)
begin
	if(!rst)
	begin
		edge_cnt <= 5'b0_0001;
		bit_cnt <= 4'b0000;
	end
	else if(edge_cnt_en)
	begin
		if(edge_cnt != prescale - 1) edge_cnt <= edge_cnt + 1;
		else edge_cnt <= 5'b0_0000;
		
		if(bit_cnt == 4'b1010 && edge_cnt == prescale - 1) bit_cnt <= 4'b0000;
		else if(edge_cnt == prescale - 1) bit_cnt <= bit_cnt + 1;
	end
end
endmodule 