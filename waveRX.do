onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Cyan /uartRx_tb/clk_tb
add wave -noupdate -color Magenta /uartRx_tb/clk_tx
add wave -noupdate /uartRx_tb/test_data
add wave -noupdate /uartRx_tb/rx_in_tb
add wave -noupdate /uartRx_tb/data_valid_tb
add wave -noupdate -radix hexadecimal -radixshowbase 0 /uartRx_tb/p_data_tb
add wave -noupdate -group {TB Signals} /uartRx_tb/prescale_tb
add wave -noupdate -group {TB Signals} /uartRx_tb/i
add wave -noupdate -group {TB Signals} /uartRx_tb/rst_tb
add wave -noupdate -group {TB Signals} /uartRx_tb/par_en_tb
add wave -noupdate -group {TB Signals} /uartRx_tb/par_type_tb
add wave -noupdate -group {FSM State} /uartRx_tb/U0_uartRx/U0_fsm/edge_cnt_en
add wave -noupdate -group {FSM State} /uartRx_tb/U0_uartRx/U0_fsm/currentState
add wave -noupdate -group {FSM State} /uartRx_tb/U0_uartRx/U0_fsm/nextState
add wave -noupdate -group {Edge Bit Counter} /uartRx_tb/U0_uartRx/U0_edge_counter/edge_cnt
add wave -noupdate -group {Edge Bit Counter} /uartRx_tb/U0_uartRx/U0_edge_counter/bit_cnt
add wave -noupdate -group {Data Sampling} /uartRx_tb/U0_uartRx/U0_dataSampling/s1
add wave -noupdate -group {Data Sampling} /uartRx_tb/U0_uartRx/U0_dataSampling/s2
add wave -noupdate -group {Data Sampling} /uartRx_tb/U0_uartRx/U0_dataSampling/sampled_bit
add wave -noupdate -group {Error Signals} /uartRx_tb/U0_uartRx/U0_strt/strt_glitch
add wave -noupdate -group {Error Signals} /uartRx_tb/U0_uartRx/U0_parity/par_err
add wave -noupdate -group {Error Signals} /uartRx_tb/U0_uartRx/U0_stop/stp_err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25894594 ps} 0}
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
WaveRestoreZoom {0 ps} {33554432 ps}
