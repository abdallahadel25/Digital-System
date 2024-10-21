module shiftUnit#(
    parameter width = 16
)(
input   wire    [width-1:0]         A,
input   wire    [width-1:0]         B,
input   wire    [1:0]               aluFunc,
input   wire                        shiftEn,
input   wire                        clk,
input   wire                        rst,
output  reg     [width-1:0]         shiftOut,
output  wire                        shiftFlag
);

always@(posedge clk or negedge rst)
begin
    if (!rst)
        begin
            shiftOut <= {width{1'b0}};
        end
    else if(shiftEn)
        begin
            case(aluFunc)
                2'b00: shiftOut <= A>>1;
                2'b01: shiftOut <= A<<1;
                2'b10: shiftOut <= B>>1;
                2'b11: shiftOut <= B<<1;
            endcase
        end
end

assign shiftFlag = shiftEn;

endmodule