vlib work
vlog *.*v
vsim -voptargs=+acc work.uartTx_tb
do wave.do
run -all