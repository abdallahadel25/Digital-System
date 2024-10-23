`timescale 1ns / 1ps

module system_tb();

parameter dataWidth = 8;
parameter regDepth = 16;

parameter ref_clk_period = 20;
parameter uart_clk_period = 271.27;
parameter tx_clk_period = 8681;

parameter wrCMD = 8'hAA;
parameter rdCMD = 8'hBB;
parameter aluOpCMD = 8'hCC;
parameter aluNopCMD = 8'hDD;

parameter ADD  = 8'b0000_0000;
parameter SUB  = 8'b0000_0001;
parameter MUL  = 8'b0000_0010;
parameter DIV  = 8'b0000_0011;
parameter AND  = 8'b0000_0100;
parameter OR   = 8'b0000_0101;
parameter NAND = 8'b0000_0110;
parameter NOR  = 8'b0000_0111;
parameter XOR  = 8'b0000_1000;
parameter XNOR = 8'b0000_1001;
parameter EQU  = 8'b0000_1010;
parameter CMPA = 8'b0000_1011;
parameter CMPB = 8'b0000_1100;
parameter SHRA = 8'b0000_1101;
parameter SHLA = 8'b0000_1110;
parameter NOP  = 8'b0000_1111;

reg     tx_clk;

reg     ref_clk;
reg     uart_clk;
reg     rst;
reg     rx_in;

wire    tx_out;
wire    par_err;
wire    frame_err;

reg [dataWidth+2:0] fetchedData;

integer i,j;

always #(ref_clk_period/2.0) ref_clk = ~ref_clk;
always #(uart_clk_period/2.0) uart_clk = ~uart_clk;
always #(tx_clk_period/2.0) tx_clk = ~tx_clk;

SYS_TOP DUT (
    .RST_N(rst),
    .UART_CLK(uart_clk),
    .REF_CLK(ref_clk),
    .UART_RX_IN(rx_in),
    .UART_TX_O(tx_out),
    .parity_error(par_err),
    .framing_error(frame_err)
);

task initialize;
begin
	ref_clk = 1'b1;
	uart_clk = 1'b1;
    tx_clk = 1'b1;
	rst = 1'b1;
    rx_in = 1'b1;

	@(negedge ref_clk);
end
endtask

task reset ;
begin
	rst =  1'b1;
	#(uart_clk_period)
	rst  = 1'b0;
	#(uart_clk_period)
    rst  = 1'b1;
	#(uart_clk_period);
end
endtask

task send;
input [dataWidth-1:0] data;
integer j;
begin
	for(j=0;j<dataWidth+3;j=j+1)
	begin
		@(negedge tx_clk)
		if(j==0) rx_in = 1'b0;
        else if (j==dataWidth+1) rx_in = ^data;
        else if (j==dataWidth+2) rx_in = 1'b1;
        else rx_in = data[j-1];
	end
end
endtask

task REG_WR;
input [dataWidth-1:0] wraddrINPUT,wrdataINPUT;
begin
    send(wrCMD);
    send(wraddrINPUT);
    send(wrdataINPUT);
end
endtask

task REG_RD;
input [dataWidth-1:0] rdaddrINPUT;
begin
    send(rdCMD);
    send(rdaddrINPUT);
end
endtask

task ALU_OP;
input [dataWidth-1:0] A,B,func;
begin
    send(aluOpCMD);
    send(A);
    send(B);
    send(func);
end
endtask

task ALU_NOP;
input [dataWidth-1:0] func;
begin
    send(aluNopCMD);
    send(func);
end
endtask

initial
begin

initialize();
reset();

@(negedge tx_clk)

// UART CONFIG

REG_WR('d2,'b100000_01);
REG_WR('d3,'b00_100000);

// writing in reg file test

$display("WRITING REG FILE");
for(i=4;i<regDepth;i=i+1)
    REG_WR(i,i);

// reading the writen data test

$display("READING REG FILE");
for(i=4;i<regDepth;i=i+1)
    REG_RD(i);
#(tx_clk_period*100)
// ALU OP TEST

$display("TESTING ALU OP CMD");

ALU_OP(8'h08,8'h07,ADD);
ALU_OP(8'h0a,8'h05,SUB);
ALU_OP(8'h0a,8'h05,MUL);
ALU_OP(8'h0a,8'h05,DIV);
ALU_OP(8'h0a,8'h05,AND);
ALU_OP(8'h0a,8'h05,OR);
ALU_OP(8'h0a,8'h05,NAND);
ALU_OP(8'h0a,8'h05,NOR);
ALU_OP(8'h0a,8'h05,XOR);
ALU_OP(8'h0a,8'h05,XNOR);
ALU_OP(8'h0a,8'h05,EQU);
ALU_OP(8'h0a,8'h05,CMPA);
ALU_OP(8'h0a,8'h05,CMPB);

// ALU NOP TEST
#(tx_clk_period*100)
$display("TESTING ALU NOP CMD");

REG_WR('b0,'d5);
REG_WR('b1,'d10);
ALU_NOP(ADD);

REG_WR('b0,'d20);
ALU_NOP(SHRA);

REG_WR('b0,'d15);
ALU_NOP(SHLA);

#600000 $stop();
end

always @(negedge tx_out)
begin
    for(j=0;j<dataWidth+3;j=j+1)
	begin
		fetchedData[j] = tx_out;
		#(tx_clk_period);
	end
    if (fetchedData[9] != ^fetchedData[8:1]) $display("Recived Data = %d %b\t PAR ERR",fetchedData[8:1],fetchedData[8:1]);
    else if (fetchedData[10] != 1'b1) $display("Recived Data = %d %b\t STP ERR",fetchedData[8:1],fetchedData[8:1]);
    else $display("Recived Data = %d %b\t NO ERR",fetchedData[8:1],fetchedData[8:1]);
end

always @(posedge par_err) $display("RX PAR ERR");
always @(posedge frame_err) $display("RX FRAME ERR");

endmodule