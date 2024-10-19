module serializer#(
parameter dataWidth = 8
)(
input 	wire [dataWidth-1:0] 	p_data,
input 	wire 					ser_en,
input	wire					clk,
input	wire					rst,
output 	wire					ser_data,
output	wire					ser_done
);

reg [$clog2(dataWidth)-1:0] 	counter;
reg [dataWidth-1:0]		data_v;

assign ser_done = (counter == 0);
assign ser_data = data_v[0];

always@(posedge clk or negedge rst)
begin
	if(!rst)
	begin
		data_v <= {dataWidth{1'b0}};
		counter <= {$clog2(dataWidth){1'b0}};
	end
	else if (counter != 0)
	begin
		data_v <= data_v >> 1;
		counter <= counter - 1;
	end
	else if (ser_en)
	begin
		data_v <= p_data;
		counter <= dataWidth - 1;
	end
end
endmodule
