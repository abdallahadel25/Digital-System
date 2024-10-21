`timescale 1us/1ns

module alu_tb();

reg     [15:0]  A_tb;
reg     [15:0]  B_tb;
reg     [3:0]   aluFunc_tb;
reg             clk_tb;
reg             rst_tb;
wire    [31:0]  arithOut_tb;
wire            arithFlag_tb;
wire    [15:0]  logicOut_tb;
wire            logicFlag_tb;
wire    [1:0]   cmpOut_tb;
wire            cmpFlag_tb;
wire    [15:0]  shiftOut_tb;
wire            shiftFlag_tb;

aluTop #(
    .width(16)
)aluTop_u0(
    .A(A_tb),
    .B(B_tb),
    .aluFunc(aluFunc_tb),
    .clk(clk_tb),
    .rst(rst_tb),
    .arithOut(arithOut_tb),
    .arithFlag(arithFlag_tb),
    .logicOut(logicOut_tb),
    .logicFlag(logicFlag_tb),
    .cmpOut(cmpOut_tb),
    .cmpFlag(cmpFlag_tb),
    .shiftOut(shiftOut_tb),
    .shiftFlag(shiftFlag_tb)
);

reg [6*8:0] test;

always
begin
    #6 clk_tb=~clk_tb;
    #4 clk_tb=~clk_tb;
end

initial
begin
    $dumpfile("alu.vcd");
    $dumpvars;
    clk_tb = 1'b1;
    rst_tb = 1'b1;
    #5 rst_tb = 1'b0;
    #5 rst_tb = 1'b1;

    // testcase 1 -A + -B

    #5
    // A_tb = -5;
    // B_tb = -10;
    // aluFunc_tb = 4'h0;
    // #6
    // if(arithOut_tb==-15) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 2 +A + -B

    // A_tb = 5;
    // B_tb = -10;
    // aluFunc_tb = 4'h0;
    // #10
    // if(arithOut_tb==-5) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);
    
    // testcase 3 -A + +B

    // A_tb = -5;
    // B_tb = 10;
    // aluFunc_tb = 4'h0;
    // #10
    // if(arithOut_tb==5) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 4 +A + +B

    A_tb = 5;
    B_tb = 10;
    aluFunc_tb = 4'h0;
    #10
    if(arithOut_tb==15) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 5 -A - -B

    // A_tb = -5;
    // B_tb = -10;
    // aluFunc_tb = 4'h1;
    // #10
    // if(arithOut_tb==5) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 6 +A - -B

    // A_tb = 5;
    // B_tb = -10;
    // aluFunc_tb = 4'h1;
    // #10
    // if(arithOut_tb==15) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);
    
    // testcase 7 -A - +B

    // A_tb = -5;
    // B_tb = 10;
    // aluFunc_tb = 4'h1;
    // #10
    // if(arithOut_tb==-15) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 8 +A - +B

    A_tb = 5;
    B_tb = 10;
    aluFunc_tb = 4'h1;
    #10
    if(arithOut_tb==-5) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 9 -A * -B

    // A_tb = -5;
    // B_tb = -10;
    // aluFunc_tb = 4'h2;
    // #10
    // if(arithOut_tb==50) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 10 +A * -B

    // A_tb = 5;
    // B_tb = -10;
    // aluFunc_tb = 4'h2;
    // #10
    // if(arithOut_tb==-50) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);
    
    // testcase 11 -A * +B

    // A_tb = -5;
    // B_tb = 10;
    // aluFunc_tb = 4'h2;
    // #10
    // if(arithOut_tb==-50) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 12 +A * +B

    A_tb = 5;
    B_tb = 10;
    aluFunc_tb = 4'h2;
    #10
    if(arithOut_tb==50) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 13 -A / -B

    // A_tb = -10;
    // B_tb = -5;
    // aluFunc_tb = 4'h3;
    // #10
    // if(arithOut_tb==2) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 14 +A / -B

    // A_tb = 10;
    // B_tb = -5;
    // aluFunc_tb = 4'h3;
    // #10
    // if(arithOut_tb==-2) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT = %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);
    
    // testcase 15 -A / +B

    // A_tb = -10;
    // B_tb = 5;
    // aluFunc_tb = 4'h3;
    // #10
    // if(arithOut_tb==-2) test = "passed";
    // else test = "failed";
    // $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 16 +A / +B

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'h3;
    #10
    if(arithOut_tb==2) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tArith FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,arithOut_tb,arithFlag_tb,test);

    // testcase 17 logical AND

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'h4;
    #10
    if(logicOut_tb==0) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0h\tLogic FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,logicOut_tb,logicFlag_tb,test);

    // testcase 18 logical OR

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'h5;
    #10
    if(logicOut_tb==15) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0h\tLogic FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,logicOut_tb,logicFlag_tb,test);

    // testcase 19 logical NAND

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'h6;
    #10
    if(logicOut_tb==16'hffff) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0h\tLogic FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,logicOut_tb,logicFlag_tb,test);

    // testcase 20 logical NOR

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'h7;
    #10
    if(logicOut_tb==16'hfff0) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0h\tLogic FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,logicOut_tb,logicFlag_tb,test);

    // testcase 21 Compare Equal

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'h9;
    #10
    if(cmpOut_tb==0) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0h\tCmp FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,cmpOut_tb,cmpFlag_tb,test);

    // testcase 22 Compare A > B

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'ha;
    #10
    if(cmpOut_tb==2'b10) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0h\tCmp FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,cmpOut_tb,cmpFlag_tb,test);

    // testcase 23 Compare A > B

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'hb;
    #10
    if(cmpOut_tb==0) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0h\tCmp FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,cmpOut_tb,cmpFlag_tb,test);

    // testcase 24 Shift A >> 1

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'hc;
    #10
    if(shiftOut_tb==5) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tShift FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,shiftOut_tb,shiftFlag_tb,test);

    // testcase 25 Shift A << 1+

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'hd;
    #10
    if(shiftOut_tb==20) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tShift FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,shiftOut_tb,shiftFlag_tb,test);

    // testcase 26 Shift B >> 1

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'he;
    #10
    if(shiftOut_tb==2) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tShift FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,shiftOut_tb,shiftFlag_tb,test);

    // testcase 27 Shift B >> 1

    A_tb = 10;
    B_tb = 5;
    aluFunc_tb = 4'hf;
    #10
    if(shiftOut_tb==10) test = "passed";
    else test = "failed";
    $display("A = %0d\tB = %0d\tALU FUNC = %b\tOUT =  %0d\tShift FLag = %0b\t%s",A_tb,B_tb,aluFunc_tb,shiftOut_tb,shiftFlag_tb,test);

    // testcase 28 NOP
    aluFunc_tb = 4'h8;
    #10
    $display("Arith = %0d\tLogic = %0h\tCmp = %0d\tShift = %0d",arithOut_tb,logicOut_tb,cmpOut_tb,shiftOut_tb);

    #100 $stop();

end



endmodule