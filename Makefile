IVERILOG := iverilog
VVP      := vvp
GTKWAVE  := gtkwave
BUILD    := build
SRC      := src
TB       := tb

# Scan targets from testbench directory
TBS      := $(wildcard $(TB)/*.v)
TARGETS  := $(patsubst $(TB)/%.v,%,$(TBS))

.PHONY: all list clean help $(TARGETS)

# Default target: display usage instructions
help:
	@echo "=== Verilog Playground Makefile ==="
	@echo "Usage:"
	@echo "  make <filename>       : Compile and run (e.g., make xor_gate)"
	@echo "  make run FILE=<name>  : Alternative way to compile and run"
	@echo "  make wave FILE=<name> : Open waveform (.vcd) in GTKWave"
	@echo "  make list             : List all available testbenches"
	@echo "  make clean            : Remove build artifacts"

$(BUILD):
	@mkdir -p $(BUILD)

# Rule for direct target execution: make <target>
$(TARGETS): %: $(BUILD)/%.vvp
	@echo "==> Running simulation for $*..."
	@$(VVP) $<

# Rule for compiling both design (src/) and testbench (tb/)
$(BUILD)/%.vvp: $(SRC)/%.v $(TB)/%.v | $(BUILD)
	@echo "==> Compiling $< and $(TB)/$*.v..."
	@$(IVERILOG) -o $@ $(SRC)/$*.v $(TB)/$*.v

# Alternative execution via FILE variable
run:
ifndef FILE
	$(error Please specify a file, e.g., make run FILE=xor_gate)
endif
	@$(MAKE) $(FILE)

# Open waveform file in GTKWave (auto-run if .vcd is missing)
wave:
ifndef FILE
	$(error Please specify a file, e.g., make wave FILE=xor_gate)
endif
	@if [ ! -f $(BUILD)/$(FILE).vcd ]; then \
		echo "==> $(BUILD)/$(FILE).vcd not found. Running simulation first..."; \
		$(MAKE) $(FILE); \
	fi
	@if [ -f $(BUILD)/$(FILE).vcd ]; then \
		$(GTKWAVE) $(BUILD)/$(FILE).vcd; \
	else \
		echo "Error: .vcd file not found for $(FILE)"; \
	fi

list:
	@echo "Available test targets:"
	@for f in $(TARGETS); do echo "  - $$f"; done

clean:
	rm -rf $(BUILD)
