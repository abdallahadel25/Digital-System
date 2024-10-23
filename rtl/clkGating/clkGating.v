module clk_gate (
input      clk_en,
input      clk,
output     gated_clk
);

reg latch_out;

always @(clk or clk_en)
begin
    if (!clk)
        latch_out <= clk_en;
end

assign gated_clk = clk & latch_out;

/*

TLATNCAX12M U0_TLATNCAX12M (
.E(CLK_EN),
.CK(CLK),
.ECK(GATED_CLK)
);

*/

endmodule