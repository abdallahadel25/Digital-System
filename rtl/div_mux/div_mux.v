module div_mux #(
    parameter widthInput = 6,
    parameter widthOutput = 8,
)(
    input   wire    [widthInput-1:0]    in,
    output  wire    [widthOutput-1:0]   out
);

always @(*)
begin
    case(in)
        {{widthInput-6{1'b0}},6'b100000} : out = 'b1;
        {{widthInput-5{1'b0}},5'b10000}  : out = 'b2;
        {{widthInput-4{1'b0}},4'b1000}   : out = 'b4;
        {{widthInput-3{1'b0}},3'b100}    : out = 'b8;
        default                          : out = 'b1;
    endcase
end
endmodule