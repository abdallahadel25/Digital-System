module parity#(
parameter dataWidth = 8
)(
input 	wire [dataWidth-1:0]	p_data,
input 	wire 					data_valid,
input 	wire 					par_type,
input	wire 					clk,
input	wire 					rst,
output 	reg 					par
);

always @(posedge clk or negedge rst)
begin
	if(!rst)
		par <= 1'b0;
	else if(data_valid)
	begin
		par <= par_type ? ~^p_data : ^p_data;
	end
end
endmodule 