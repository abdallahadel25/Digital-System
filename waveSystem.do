onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/ref_clk
add wave -noupdate /system_tb/uart_clk
add wave -noupdate -radix hexadecimal -childformat {{{/system_tb/DUT/regFile_U0/regFile[0]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[1]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[2]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[3]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[4]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[5]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[6]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[7]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[8]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[9]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[10]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[11]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[12]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[13]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[14]} -radix hexadecimal} {{/system_tb/DUT/regFile_U0/regFile[15]} -radix hexadecimal}} -subitemconfig {{/system_tb/DUT/regFile_U0/regFile[0]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[1]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[2]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[3]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[4]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[5]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[6]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[7]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[8]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[9]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[10]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[11]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[12]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[13]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[14]} {-radix hexadecimal} {/system_tb/DUT/regFile_U0/regFile[15]} {-radix hexadecimal}} /system_tb/DUT/regFile_U0/regFile
add wave -noupdate /system_tb/DUT/sys_control_U0/currentState
add wave -noupdate /system_tb/DUT/sys_control_U0/nextState
add wave -noupdate /system_tb/DUT/uart_U0/data_valid_rx
add wave -noupdate /system_tb/rx_in
add wave -noupdate /system_tb/tx_out
add wave -noupdate /system_tb/DUT/uart_U0/p_data_rx
add wave -noupdate /system_tb/DUT/uart_U0/p_data_tx
add wave -noupdate /system_tb/DUT/alu_U0/alu_out
add wave -noupdate /system_tb/DUT/alu_U0/out_valid
add wave -noupdate /system_tb/DUT/clk_gate_alu/gated_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {771476140 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {16777216 ns}
