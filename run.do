vlib work
vlog rtl/*/*.v
vlog rtl/*/*/*.v
vsim -voptargs=+acc work.system_tb
do waveSystem.do
run -all