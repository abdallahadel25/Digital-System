onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color {Violet Red} /uartTx_tb/clk_tb
add wave -noupdate /uartTx_tb/rst_tb
add wave -noupdate /uartTx_tb/p_data_tb
add wave -noupdate /uartTx_tb/data_valid_tb
add wave -noupdate -color Cyan /uartTx_tb/busy_tb
add wave -noupdate -color Thistle /uartTx_tb/tx_out_tb
add wave -noupdate -expand -group state /uartTx_tb/DUT/fsm_U0/currentState
add wave -noupdate -expand -group state /uartTx_tb/DUT/fsm_U0/nextState
add wave -noupdate -expand -group state /uartTx_tb/DUT/fsm_U0/mux_sel
add wave -noupdate -group serializer /uartTx_tb/DUT/serializer_U0/ser_data
add wave -noupdate -group serializer /uartTx_tb/DUT/serializer_U0/ser_done
add wave -noupdate -group serializer /uartTx_tb/DUT/serializer_U0/ser_en
add wave -noupdate -group serializer /uartTx_tb/DUT/serializer_U0/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
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
WaveRestoreZoom {0 ns} {252 ns}
