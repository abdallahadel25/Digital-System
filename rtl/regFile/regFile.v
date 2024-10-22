module regFile #(
parameter dataWidth = 8,
parameter depth = 16 
)(
input   wire    [dataWidth-1:0]         wrData,
input   wire    [$clog2(depth)-1:0]     addr,
input   wire                            wrEn,
input   wire                            rdEn,
input   wire                            clk,
input   wire                            rst,
output  reg     [dataWidth-1:0]         rdData,
output  reg                             rdData_valid,
output  wire    [dataWidth-1:0]         reg_0,
output  wire    [dataWidth-1:0]         reg_1,
output  wire    [dataWidth-1:0]         reg_2,
output  wire    [dataWidth-1:0]         reg_3
);

reg [dataWidth-1:0] regFile [0:depth-1];

integer i;

always@(posedge clk or negedge rst)
    begin
        if (!rst)
            begin
                rdData <= {dataWidth{1'b0}};
                rdData_valid <= 1'b0;
                for(i=0;i<depth;i=i+1) regFile[i] <= {dataWidth{1'b0}};
            end
        else if (wrEn && !rdEn)
            begin
                regFile[addr] <= wrData;
            end
        else if (rdEn && !wrEn)
            begin
                rdData <= regFile[addr];
                rdData_valid <= 1'b1;
            end
        else
            rdData_valid <= 1'b0;
    end

assign reg_0 = regFile[0];
assign reg_1 = regFile[1];
assign reg_2 = regFile[2];
assign reg_3 = regFile[3];

endmodule