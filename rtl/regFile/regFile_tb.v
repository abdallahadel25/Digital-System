`timescale 1ns/1ps

module regFile_tb();

reg     [7:0]   wrData_tb;
reg     [3:0]   addr_tb;
reg             wrEn_tb;
reg             rdEn_tb;
reg             clk_tb;
reg             rst_tb;
wire    [7:0]   rdData_tb;
wire            rdData_valid_tb;
wire    [7:0]   reg_0_tb;
wire    [7:0]   reg_1_tb;
wire    [7:0]   reg_2_tb;
wire    [7:0]   reg_3_tb;

regFile #(
    .dataWidth(8),
    .depth(16)
    )DUT (
    .wrData(wrData_tb),
    .addr(addr_tb),
    .wrEn(wrEn_tb),
    .rdEn(rdEn_tb),
    .clk(clk_tb),
    .rst(rst_tb),
    .rdData(rdData_tb),
    .rdData_valid(rdData_valid_tb),
    .reg_0(reg_0_tb),
    .reg_1(reg_1_tb),
    .reg_2(reg_2_tb),
    .reg_3(reg_3_tb)
);

always #5 clk_tb=~clk_tb;

integer i;
reg [6*8:0] test;

initial
    begin
        $dumpfile("regFile.vcd");
        $dumpvars;
        clk_tb = 1'b1;
        rst_tb = 1'b1;
        wrEn_tb = 1'b0;
        rdEn_tb = 1'b0;

        addr_tb = 0;

        // testing rst

        #5 rst_tb = 1'b0;
        #5 rst_tb = 1'b1;
        #5 rdEn_tb = 1'b1;

        for(i=0;i<16;i=i+1)
            begin
                addr_tb = i;
                #10 $display("regFile[%0d] = %0h",i,rdData_tb);
            end

        rdEn_tb = 1'b0;
        
        // writing reg 5 with value 10

        addr_tb = 5;
        wrEn_tb = 1'b1;
        wrData_tb = 10;

        #10 
        
        // reading reg 5

        wrEn_tb = 1'b0;
        rdEn_tb = 1'b1;
        
        #10
        
        if(rdData_tb==10) test = "passed";
        else test = "failed";

        $display("regFile[5] = %0d , %s",rdData_tb,test);

        // writing reg 3 with value 15

        rdEn_tb = 1'b0;
        addr_tb = 3;
        wrEn_tb = 1'b1;
        wrData_tb = 15;

        #10 
        
        // reading reg 3

        wrEn_tb = 1'b0;
        rdEn_tb = 1'b1;
        
        #10
        
        if(rdData_tb==15) test = "passed";
        else test = "failed";

        $display("regFile[3] = %0d , %s",rdData_tb,test);

        //testing latch for rdData if both rdEn and wrEN are active

        wrEn_tb = 1'b1;
        addr_tb = 5;

        #10

        $display("addr = %0d\trdData = %0d\twrEn = %0b\trdEn = %0b",addr_tb,rdData_tb,wrEn_tb,rdEn_tb);

        #100 $finish();
    end 
endmodule