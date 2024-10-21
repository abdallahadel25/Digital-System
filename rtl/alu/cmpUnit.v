module cmpUnit#(
    parameter width = 16
)(
input   wire    [width-1:0]         A,
input   wire    [width-1:0]         B,
input   wire    [1:0]               aluFunc,
input   wire                        cmpEn,
input   wire                        clk,
input   wire                        rst,
output  reg     [1:0]               cmpOut,
output  wire                        cmpFlag
);

always@(posedge clk or negedge rst)
begin
    if (!rst)
        begin
            cmpOut <= 2'b00;
        end
    else if(cmpEn)
        begin
            case(aluFunc)
                2'b00: cmpOut <= 2'b00;
                2'b01: cmpOut <= (A==B) ? 2'b01:2'b00;
                2'b10: cmpOut <= (A>B) ? 2'b10:2'b00;
                2'b11: cmpOut <= (A<B) ? 2'b11:2'b00;
            endcase
        end
end

assign cmpFlag = cmpEn;

endmodule