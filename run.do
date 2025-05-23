# === ALU Project Simulation Script ===

# Step 1: Create library
vlib work

# Step 2: Compile all source files
vlog ALU.sv
vlog InstructionDecoder.sv
vlog ALU_Control.sv
vlog ALU_Pipeline.sv
vlog ALU_Pipeline_tb.sv

# Step 3: Launch simulation
vsim work.ALU_Pipeline_tb

# Step 4: Add waveforms
add wave -r /*

# Step 5: Run the testbench
run -all
