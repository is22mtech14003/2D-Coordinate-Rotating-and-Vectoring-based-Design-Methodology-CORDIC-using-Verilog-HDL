# ####################################################################

#  Created by Genus(TM) Synthesis Solution 20.10-p001_1 on Thu Apr 27 23:11:22 IST 2023

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design ROTATING

create_clock -name "clk" -period 1.0 -waveform {0.0 0.5} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports clk]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[9]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[10]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[11]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[12]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[13]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[14]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {theta[15]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {y0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {x0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[10]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[11]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[12]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[13]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[14]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {yf[15]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[8]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[9]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[10]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[11]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[12]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[13]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[14]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.0004 [get_ports {xf[15]}]
set_wire_load_mode "enclosed"
