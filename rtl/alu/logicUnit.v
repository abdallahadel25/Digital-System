module logicUnit#(
    parameter width = 16
)(
input   wire    [width-1:0]         A,
input   wire    [width-1:0]         B,
input   wire    [1:0]               aluFunc,
input   wire                        logicEn,
input   wire                        clk,
input   wire                        rst,
output  reg     [width-1:0]         logicOut,
output  wire                        logicFlag
);

always@(posedge clk or negedge rst)
begin
    if (!rst)
        begin
            logicOut <= {width{1'b0}};
        end
    else if(logicEn)
        begin
            case(aluFunc)
                2'b00: logicOut <= A&B;
                2'b01: logicOut <= A|B;
                2'b10: logicOut <= ~(A&B);
                2'b11: logicOut <= ~(A|B);
            endcase
        end
end

assign logicFlag = logicEn;

endmodule