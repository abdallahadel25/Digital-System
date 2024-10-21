module arithUnit#(
    parameter width = 16
)(
input   wire    [width-1:0]         A,
input   wire    [width-1:0]         B,
input   wire          [1:0]         aluFunc,
input   wire                        arithEn,
input   wire                        clk,
input   wire                        rst,
output  reg     [width*2-1:0]       arithOut,
output  wire                        arithFlag
);

always@(posedge clk or negedge rst)
begin
    if (!rst)
        begin
            arithOut <= {width{1'b0}};
        end
    else if(arithEn)
        begin
            case(aluFunc)
                2'b00: arithOut <= A+B;
                2'b01: arithOut <= A-B;
                2'b10: arithOut <= A*B;
                2'b11: arithOut <= A/B;
            endcase
        end
end

assign arithFlag = arithEn;

endmodule