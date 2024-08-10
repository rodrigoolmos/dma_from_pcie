
###############################################################################
# USER Constraints
###############################################################################



###############################################################################
# Timing Constraints
###############################################################################

create_clock -period 10.000 -name pcie_clkin [get_ports {pcie_clkin_clk_p[0]}]

###############################################################################
# Physical Constraints
###############################################################################

# Input reset is resynchronized within FPGA design as necessary
set_false_path -from [get_ports pcie_reset]

###############################################################################
# Additional design / project settings
###############################################################################

# LEDS

set_property PACKAGE_PIN AA2 [get_ports {dataout[7]}]
set_property PACKAGE_PIN AD5 [get_ports {dataout[6]}]
set_property PACKAGE_PIN W10 [get_ports {dataout[5]}]
set_property PACKAGE_PIN Y10 [get_ports {dataout[4]}]
set_property PACKAGE_PIN AE10 [get_ports {dataout[3]}]
set_property PACKAGE_PIN W11 [get_ports {dataout[2]}]
set_property PACKAGE_PIN V11 [get_ports {dataout[1]}]
set_property PACKAGE_PIN Y12 [get_ports {dataout[0]}]

set_property IOSTANDARD LVCMOS15 [get_ports {dataout[*]}]


# High-speed configuration so FPGA is up in time to negotiate with PCIe root complex
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CCLK_TRISTATE TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 66 [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]

set_property PACKAGE_PIN H6 [get_ports {pcie_clkin_clk_p[0]}]
