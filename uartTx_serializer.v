module serializer#(
parameter dataWidth = 8,
parameter counterWidth = 3
)(
input 	wire [dataWidth-1:0] 	p_data,
input 	wire 			ser_en,
input	wire			clk,
input	wire			rst,
output 	reg			ser_data,
output	wire			ser_done
);

reg [counterWidth-1:0] 	counter; 

assign ser_done = (counter == 0);

always@(posedge clk or negedge rst)
begin
	if(!rst)
	begin
		ser_data <= 1'b0;
		counter <= {counterWidth{1'b0}};
	end

	else if (counter != 0)
	begin
		ser_data <= p_data[dataWidth-counter];
		counter <= counter - 1;
	end
	else if (ser_en)
	begin
		counter <= dataWidth - 1;
		ser_data <= p_data[0];
	end
end
endmodule
