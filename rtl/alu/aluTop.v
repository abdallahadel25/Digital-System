module aluTop#(
    parameter width = 16
)(
input   [width-1:0]     A,
input   [width-1:0]     B,
input   [3:0]           aluFunc,
input                   clk,
input                   rst,
output  [width*2-1:0]    arithOut,
output                  arithFlag,
output  [width-1:0]     logicOut,
output                  logicFlag,
output  [1:0]           cmpOut,
output                  cmpFlag,
output  [width-1:0]     shiftOut,
output                  shiftFlag
);

wire arithEn;
wire logicEn;
wire cmpEn;
wire shiftEn;

decoder decoder_u0(
    .aluFunc(aluFunc[3:2]),
    .arithEn(arithEn),
    .logicEn(logicEn),
    .cmpEn(cmpEn),
    .shiftEn(shiftEn)
);

arithUnit #(
    .width(width)
)arithUnit_u0(
    .A(A),
    .B(B),
    .aluFunc(aluFunc[1:0]),
    .arithEn(arithEn),
    .clk(clk),
    .rst(rst),
    .arithOut(arithOut),
    .arithFlag(arithFlag)
);

logicUnit #(
    .width(width)
)logicUnit_u0(
    .A(A),
    .B(B),
    .aluFunc(aluFunc[1:0]),
    .logicEn(logicEn),
    .clk(clk),
    .rst(rst),
    .logicOut(logicOut),
    .logicFlag(logicFlag)
);

cmpUnit #(
    .width(width)
)cmpUnit_u0(
    .A(A),
    .B(B),
    .aluFunc(aluFunc[1:0]),
    .cmpEn(cmpEn),
    .clk(clk),
    .rst(rst),
    .cmpOut(cmpOut),
    .cmpFlag(cmpFlag)
);

shiftUnit #(
    .width(width)
)shiftUnit_u0(
    .A(A),
    .B(B),
    .aluFunc(aluFunc[1:0]),
    .shiftEn(shiftEn),
    .clk(clk),
    .rst(rst),
    .shiftOut(shiftOut),
    .shiftFlag(shiftFlag)
);

endmodule