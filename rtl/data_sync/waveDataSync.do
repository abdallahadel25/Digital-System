onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DATA_tb/clk
add wave -noupdate /DATA_tb/rst
add wave -noupdate -color Cyan /DATA_tb/bus_enable
add wave -noupdate /DATA_tb/DUT/comb_pulse
add wave -noupdate -color Magenta /DATA_tb/enable_pulse
add wave -noupdate /DATA_tb/sync_bus
add wave -noupdate /DATA_tb/unsync_bus
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {91 ps} {343 ps}
