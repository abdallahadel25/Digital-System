vlib work
vlog rtl/uart/*/*.v
vsim -voptargs=+acc work.uart_top
# do rtl/uart/uartTX/waveTX.do
run -all