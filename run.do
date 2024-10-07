vlib work
vlog *.*v
vsim -voptargs=+acc work.uartRx_tb
do wave.do
run -all