vlib work
vlog uart/uartTX/*.v
vsim -voptargs=+acc work.uartTx_tb
do uart/uartTX/waveTX.do
run -all