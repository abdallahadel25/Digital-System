onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Magenta /fifo_tb/rclk_tb
add wave -noupdate -color Cyan /fifo_tb/wclk_tb
add wave -noupdate -radix hexadecimal /fifo_tb/rdata_tb
add wave -noupdate -radix hexadecimal /fifo_tb/wdata_tb
add wave -noupdate -radix hexadecimal -childformat {{{/fifo_tb/async_fifo/U0_mem/fifo[0]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[1]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[2]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[3]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[4]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[5]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[6]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[7]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[8]} -radix hexadecimal} {{/fifo_tb/async_fifo/U0_mem/fifo[9]} -radix hexadecimal}} -subitemconfig {{/fifo_tb/async_fifo/U0_mem/fifo[0]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[1]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[2]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[3]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[4]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[5]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[6]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[7]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[8]} {-height 15 -radix hexadecimal} {/fifo_tb/async_fifo/U0_mem/fifo[9]} {-height 15 -radix hexadecimal}} /fifo_tb/async_fifo/U0_mem/fifo
add wave -noupdate -group {write signals} /fifo_tb/async_fifo/U0_mem/waddr
add wave -noupdate -group {write signals} /fifo_tb/async_fifo/U0_wr/wptr
add wave -noupdate -group {write signals} /fifo_tb/async_fifo/U0_wr/winc
add wave -noupdate -group {read signals} /fifo_tb/async_fifo/U0_mem/raddr
add wave -noupdate -group {read signals} /fifo_tb/async_fifo/U0_rd/rptr
add wave -noupdate -group {read signals} /fifo_tb/async_fifo/U0_rd/rinc
add wave -noupdate -group {control signals} -color Cyan /fifo_tb/async_fifo/U0_wr/wfull
add wave -noupdate -group {control signals} -color Magenta /fifo_tb/async_fifo/U0_rd/rempty
add wave -noupdate -group {control signals} /fifo_tb/async_fifo/U0_wr/wptr_bin
add wave -noupdate -group {control signals} /fifo_tb/async_fifo/U0_rd/rptr_bin
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {424932 ps} 0}
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
WaveRestoreZoom {0 ps} {512 ns}
