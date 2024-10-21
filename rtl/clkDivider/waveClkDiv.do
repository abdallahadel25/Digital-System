onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Magenta /clkDivider_tb/clk_tb
add wave -noupdate -color Cyan /clkDivider_tb/div_clk_tb
add wave -noupdate -radix decimal /clkDivider_tb/div_ratio_tb
add wave -noupdate /clkDivider_tb/DUT/counter
add wave -noupdate -group controlSignals /clkDivider_tb/clk_div_en_tb
add wave -noupdate -group controlSignals /clkDivider_tb/rst_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 67
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {544 ps}
