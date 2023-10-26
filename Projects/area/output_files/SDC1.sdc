# Set the target device
set_global_assignment -name TARGET_FPGA "10M40DAF484C7G"

# Define the clock signal
create_clock -period 5 [get_ports {clk}]
report_timing
