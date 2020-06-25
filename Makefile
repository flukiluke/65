# This should point to your QB64 installation
QB64 := /home/luke/comp/git_qb64/qb64 -v
OUTPUT_BINARY := $(CURDIR)/65

SRC_DIR := $(CURDIR)/src
TOOLS_DIR := $(CURDIR)/tools
RULES_DIR := $(CURDIR)/rules

all: $(OUTPUT_BINARY)

$(TOOLS_DIR)/%.tool: $(TOOLS_DIR)/%.bas
	$(QB64) -x $< -o $@.tool

TS_FILES := $(RULES_DIR)/ts_data.bi $(RULES_DIR)/ts_data.bm
TOKEN_FILES := $(RULES_DIR)/token_data.bi $(RULES_DIR)/token_registrations.bm

$(TS_FILES): $(RULES_DIR)/ts.rules $(TOOLS_DIR)/tsgen.tool
	$(TOOLS_DIR)/tsgen.tool $(RULES_DIR)/ts.rules $(TS_FILES)

$(TOKEN_FILES): $(RULES_DIR)/tokens.list $(TOOLS_DIR)/tokgen.tool
	$(TOOLS_DIR)/tokgen.tool $(RULES_DIR)/tokens.list $(TOKEN_FILES)

# Main binary
$(OUTPUT_BINARY): $(SRC_DIR)/65.bas $(TS_FILES) $(TOKEN_FILES) $(shell find $(SRC_DIR) -type f -name '*.bm' -o -name '*.bi')
	$(QB64) -x $< -o $@

.PHONY: clean
clean:
	rm -r $(TS_FILES) $(TOKEN_FILES) $(TOOLS_DIR)/*.tool $(OUTPUT_BINARY) 2> /dev/null || true
