module decoder(
input   wire [1:0]  aluFunc,
output  reg         arithEn,
output  reg         logicEn,
output  reg         cmpEn,
output  reg         shiftEn 
);

always@(*)
    begin
        arithEn = 1'b0;
        logicEn = 1'b0;
        cmpEn = 1'b0;
        shiftEn = 1'b0;
        case(aluFunc)
            2'b00: arithEn = 1'b1;
            2'b01: logicEn = 1'b1;
            2'b10: cmpEn = 1'b1;
            2'b11: shiftEn = 1'b1;
        endcase
    end
endmodule