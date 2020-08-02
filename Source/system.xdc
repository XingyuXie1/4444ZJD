set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports led]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports clk_100M]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_100M}];
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports rst]