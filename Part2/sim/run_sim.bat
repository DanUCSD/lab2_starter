if exist ../top_level_lab2_part2.v (
    vsim -pli simfpga.vpi -Lf 220model -Lf altera_mf_ver -Lf verilog -c -do "run -all" tb
)
if exist ../top_level_lab2_part2.sv (
    vsim -pli simfpga.vpi -Lf 220model -Lf altera_mf_ver -Lf verilog -c -do "run -all" tb
)
if exist ../top_level_lab2_part2.vhd (
    vsim -pli simfpga.vpi -Lf 220model -Lf altera_mf -t 1ns -c -do "set StdArithNoWarnings 1" -do "set NumericStdNoWarnings 1" -do "run -all" tb
)
