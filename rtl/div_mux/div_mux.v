module div_mux #(
    parameter widthInput = 6,
    parameter widthOutput = 8
)(
    input   wire    [widthInput-1:0]    in,
    output  reg    [widthOutput-1:0]   out
);

always @(*)
begin
    case(in)
        {{widthInput-6{1'b0}},6'b100000} : out = 'd1;
        {{widthInput-5{1'b0}},5'b10000}  : out = 'd2;
        {{widthInput-4{1'b0}},4'b1000}   : out = 'd4;
        {{widthInput-3{1'b0}},3'b100}    : out = 'd8;
        default                          : out = 'd1;
    endcase
end
endmodule