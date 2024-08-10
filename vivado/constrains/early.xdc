###############################################################################
# PCIe x4
###############################################################################

# PCIe lane 0
set_property -dict {PACKAGE_PIN B5} [get_ports {pcie_mgt_rxn[0]}]
set_property -dict {PACKAGE_PIN B6} [get_ports {pcie_mgt_rxp[0]}]
set_property -dict {PACKAGE_PIN A3} [get_ports {pcie_mgt_txn[0]}]
set_property -dict {PACKAGE_PIN A4} [get_ports {pcie_mgt_txp[0]}]

# PCIe lane 1
set_property -dict {PACKAGE_PIN C3} [get_ports {pcie_mgt_rxn[1]}]
set_property -dict {PACKAGE_PIN C4} [get_ports {pcie_mgt_rxp[1]}]
set_property -dict {PACKAGE_PIN B1} [get_ports {pcie_mgt_txn[1]}]
set_property -dict {PACKAGE_PIN B2} [get_ports {pcie_mgt_txp[1]}]

# PCIe lane 2
set_property -dict {PACKAGE_PIN E3} [get_ports {pcie_mgt_rxn[2]}]
set_property -dict {PACKAGE_PIN E4} [get_ports {pcie_mgt_rxp[2]}]
set_property -dict {PACKAGE_PIN D1} [get_ports {pcie_mgt_txn[2]}]
set_property -dict {PACKAGE_PIN D2} [get_ports {pcie_mgt_txp[2]}]

# PCIe lane 3
set_property -dict {PACKAGE_PIN G3} [get_ports {pcie_mgt_rxn[3]}]
set_property -dict {PACKAGE_PIN G4} [get_ports {pcie_mgt_rxp[3]}]
set_property -dict {PACKAGE_PIN F1} [get_ports {pcie_mgt_txn[3]}]
set_property -dict {PACKAGE_PIN F2} [get_ports {pcie_mgt_txp[3]}]

# PCIe refclock

# Other PCIe signals
# set_property PACKAGE_PIN G1 [get_ports {pcie_clkreq[0]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {pcie_clkreq[0]}]
set_property PACKAGE_PIN C24 [get_ports pcie_reset]
set_property IOSTANDARD LVCMOS33 [get_ports pcie_reset]

