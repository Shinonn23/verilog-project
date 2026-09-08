# Verilog Project

A minimal Verilog project using Icarus Verilog for simulation.

## Layout

- `src/` — synthesizable RTL
- `tb/` — simulation testbenches
- `build/` — generated simulation files and waveforms

## Commands

```sh
make          # compile and run the self-checking testbench
make interactive # enter commands to control the simulated counter
make wave     # simulate and open GTKWave if it is installed
make clean    # remove generated files
```

The example design is a parameterized synchronous counter with asynchronous,
active-low reset and an enable input.
