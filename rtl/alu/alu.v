module alu #(
parameter dataWidth = 8
)(
input   wire    [dataWidth-1:0] A,
input   wire    [dataWidth-1:0] B,
input   wire    [3:0]           alu_fun,
input   wire                    alu_en,
input   wire                    clk,
input   wire                    rst,
output  reg     [dataWidth-1:0] alu_out,
output  reg                     out_valid
);

reg [dataWidth-1:0] alu_result;

always@(posedge clk or negedge rst)
    begin
        if(!rst)
        begin
            alu_out <= {dataWidth{1'b0}};
            out_valid <= 1'b0;
        end
        else if (alu_en)
        begin
            alu_out <= alu_result;
            out_valid <= 1'b1;
        end
        else out_valid <= 1'b0;
    end

always@(*)
    begin
        case (alu_fun)
            4'b0000: alu_result = A+B;
            4'b0001: alu_result = A-B;
            4'b0010: alu_result = A*B;
            4'b0011: alu_result = A/B;
            4'b0100: alu_result = A&B;
            4'b0101: alu_result = A|B;
            4'b0110: alu_result = ~(A&B);
            4'b0111: alu_result = ~(A|B);
            4'b1000: alu_result = A^B;
            4'b1001: alu_result = ~(A^B);
            4'b1010: alu_result = (A==B) ?  {{dataWidth-1{1'b0}},{1'b1}} :{dataWidth{1'b0}};
            4'b1011: alu_result = (A>B)  ?  {{dataWidth-2{1'b0}},{2'b10}}:{dataWidth{1'b0}};
            4'b1100: alu_result = (A<B)  ?  {{dataWidth-2{1'b0}},{2'b11}}:{dataWidth{1'b0}};
            4'b1101: alu_result = A>>1;
            4'b1110: alu_result = A<<1;
            4'b1110: alu_result = A<<1;
            4'b1111: alu_result = {dataWidth{1'b0}};
            default: alu_result = {dataWidth{1'b0}};
        endcase
    end

endmodule