`timescale 1us/1ns

module alu_tb();

parameter dataWidth = 8;

reg     [dataWidth-1:0] tb_A; 
reg     [dataWidth-1:0] tb_B;
reg     [3:0]           tb_alu_fun;
reg                     alu_en_tb;
reg                     tb_clk;
reg                     tb_rst;
wire    [dataWidth-1:0] tb_alu_out;
wire                    out_valid_tb;

alu #(
    .dataWidth(dataWidth)
) DUT(
    .A(tb_A),
    .B(tb_B),
    .alu_fun(tb_alu_fun),
    .alu_en(alu_en_tb),
    .clk(tb_clk),
    .rst(rst_tb),
    .alu_out(tb_alu_out),
    .out_valid(out_valid_tb)
);

always #5 tb_clk=~tb_clk;

integer i;

initial
    begin
    
        tb_clk = 1'b1;
        tb_rst = 1'b1;
        alu_en_tb = 1'b0;
        #5 tb_rst = 1'b0;
        #10 tb_rst = 1'b1;
        #10
        tb_A = 8'b0000_1010; //10
        tb_B = 8'b0000_0010; //2
        alu_en_tb = 1'b1;

        $display("A_d = %d\tA_b = %b",tb_A,tb_A);
        $display("B_d = %d\tB_b = %b",tb_B,tb_B);

        for(i=0;i<16;i=i+1) begin
            tb_alu_fun = i;
            #10 $display("Alu_Sel = %b\tOut_d = %d\tOut_b = %b\tout_valid = %0b",tb_alu_fun,tb_alu_out,tb_alu_out,out_valid_tb);
        end
        #200 $finish();
    end
endmodule