module sys_control#(
parameter dataWidth = 8,
parameter depth = 16
)(
input   wire                        clk,
input   wire                        rst,
input   wire    [dataWidth-1:0]     alu_out,
input   wire                        out_valid,
input   wire    [dataWidth-1:0]     rdData,
input   wire                        rdData_valid,
input   wire    [dataWidth-1:0]     rx_p_data,
input   wire                        rx_d_valid,
input   wire                        fifo_full,
output  reg     [3:0]               alu_fun,
output  reg                         alu_en,
output  reg                         clk_en,
output  reg     [$clog2(depth)-1:0] addr,
output  reg                         wrEn,
output  reg                         rdEn,
output  reg     [dataWidth-1:0]     wrData,
output  reg     [dataWidth-1:0]     tx_p_data,
output  reg                         tx_d_valid
);

localparam IDLE          = 6'b0000_00;
localparam RF_WR_CMD     = 6'b0001_00;
localparam RF_WR_ADDR    = 6'b0001_01;
localparam RF_WR_DATA    = 6'b0001_11;
localparam RF_RD_CMD     = 6'b0010_00;
localparam RF_RD_ADDR    = 6'b0010_01;
localparam ALU_OP_CMD    = 6'b0100_00;
localparam ALU_OP_A      = 6'b0100_01;
localparam ALU_OP_A_IDLE = 6'b0100_11;
localparam ALU_OP_B      = 6'b0101_11;
localparam ALU_OP_B_IDLE = 6'b0101_10;
localparam ALU_OP_FUNC   = 6'b0101_00;
localparam ALU_NOP_CMD   = 6'b1000_00;
localparam ALU_NOP_FUNC  = 6'b1000_01;
localparam ALU_OFF       = 6'b1100_11;

reg [5:0] currentState;
reg [5:0] nextState;

reg [$clog2(depth)-1:0] addr_reg;

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        currentState <= IDLE;
    end
    else
    begin
        currentState <= nextState;
    end
end

always @(*)
begin
    case(currentState)
        IDLE         : begin
            case({rx_p_data,rx_d_valid})
                {8'hAA,1'b1} : nextState = RF_WR_CMD;
                {8'hBB,1'b1} : nextState = RF_RD_CMD;
                {8'hCC,1'b1} : nextState = ALU_OP_CMD;
                {8'hDD,1'b1} : nextState = ALU_NOP_CMD;
                default : nextState = IDLE;
            endcase
        end
        RF_WR_CMD     : nextState = (rx_d_valid) ? RF_WR_ADDR : RF_WR_CMD;
        RF_WR_ADDR    : nextState = (rx_d_valid) ? RF_WR_DATA : RF_WR_ADDR;
        RF_WR_DATA    : nextState = IDLE;
        RF_RD_CMD     : nextState = (rx_d_valid) ? RF_RD_ADDR : RF_RD_CMD;
        RF_RD_ADDR    : nextState = (rdData_valid && !fifo_full) ? IDLE : RF_RD_ADDR;
        ALU_OP_CMD    : nextState = (rx_d_valid) ? ALU_OP_A : ALU_OP_CMD;
        ALU_OP_A      : nextState = ALU_OP_A_IDLE;
        ALU_OP_A_IDLE : nextState = (rx_d_valid) ? ALU_OP_B : ALU_OP_A_IDLE;
        ALU_OP_B      : nextState = ALU_OP_B_IDLE;
        ALU_OP_B_IDLE : nextState = (rx_d_valid) ? ALU_OP_FUNC : ALU_OP_B_IDLE;
        ALU_OP_FUNC   : nextState = (out_valid) ? ALU_OFF : ALU_OP_FUNC;
        ALU_NOP_CMD   : nextState = (rx_d_valid) ? ALU_NOP_FUNC : ALU_NOP_CMD;
        ALU_NOP_FUNC  : nextState = (out_valid) ? ALU_OFF : ALU_NOP_FUNC;
        ALU_OFF       : nextState = IDLE;
        default : nextState = IDLE;
    endcase
end

always @(posedge clk or negedge rst)
begin
    if (!rst)
        addr_reg <= {$clog2(depth){1'b0}};
    else if (nextState == RF_WR_ADDR)
        addr_reg <= rx_p_data;
end

always @(*)
begin
    alu_fun    = 'b0;
    alu_en     = 'b0;
    clk_en     = 'b0;
    addr       = 'b0;
    wrEn       = 'b0;
    rdEn       = 'b0;
    wrData     = 'b0;
    tx_p_data  = 'b0;
    tx_d_valid = 'b0;
    case(currentState)
        RF_WR_DATA : begin
            addr = addr_reg;
            wrEn = 1'b1;
            wrData = rx_p_data;
        end
        RF_RD_ADDR : begin
            addr = rx_p_data;
            rdEn = 1'b1;
            tx_p_data = rdData;
            tx_d_valid = rdData_valid & !fifo_full;
        end
        ALU_OP_A : begin
            addr = {$clog2(depth){1'b0}};
            wrEn = 1'b1;
            wrData = rx_p_data;
        end
        ALU_OP_B : begin
            addr = {{$clog2(depth)-1{1'b0}},1'b1};
            wrEn = 1'b1;
            wrData = rx_p_data;
        end
        ALU_OP_FUNC : begin
            wrEn = 1'b0;
            alu_fun = rx_p_data[3:0];
            alu_en = 1'b1;
            clk_en = 1'b1;
            tx_p_data = alu_out;
            tx_d_valid = out_valid;
        end
        ALU_NOP_FUNC : begin
            alu_fun = rx_p_data[3:0];
            alu_en = 1'b1;
            clk_en = 1'b1;
            tx_p_data = alu_out;
            tx_d_valid = out_valid;
        end
        ALU_OFF : begin
            clk_en = 1'b1;
        end
        default : begin
            alu_fun    = 'b0;
            alu_en     = 'b0;
            clk_en     = 'b0;
            addr       = 'b0;
            wrEn       = 'b0;
            rdEn       = 'b0;
            wrData     = 'b0;
            tx_p_data  = 'b0;
            tx_d_valid = 'b0;
        end
    endcase
end
endmodule