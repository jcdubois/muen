SYSTEM_CONFIG     ?= $(POLICY_OBJ_DIR)/system_config.xml
SYSTEM_POLICY_SRC ?= $(POLICY_OBJ_DIR)/$(SYSTEM_NAME).xml
SYSTEM_POLICY_A   ?= $(POLICY_OBJ_DIR)/$(SYSTEM_NAME)_a.xml
SYSTEM_POLICY_B   ?= $(POLICY_OBJ_DIR)/$(SYSTEM_NAME)_b.xml

SCHED_CONFIG ?= xml/scheduling_config.xml

SCHED_PLAN_XML ?= $(POLICY_OBJ_DIR)/scheduling_plans.xml
SCHED_PLAN_PDF ?= $(POLICY_OBJ_DIR)/scheduling_plans.pdf
SCHED_PLAN_RAW ?= $(POLICY_OBJ_DIR)/scheduling_plans
SCHED_PLAN_DBG ?= $(POLICY_OBJ_DIR)/mugenschedcfg.log

OUTPUT   = $(OBJ_DIR)/skp.ads
LAST_CFG = $(shell cat $(OBJ_DIR)/.cfg 2>/dev/null)
CUR_CFG  = $(HARDWARE):$(ADDITIONAL_HW):$(PLATFORM):$(SYSTEM)

SOURCES  = $(wildcard xml/*.xml)
SOURCES += $(PLATFORM)
SOURCES += $(HARDWARE)
SOURCES += $(ADDITIONAL_HW)

GENERATORS =         \
	$(MUGENACPI)     \
	$(MUGENIOBM)     \
	$(MUGENMSRBM)    \
	$(MUGENMSRSTORE) \
	$(MUGENPT)       \
	$(MUGENSPEC)     \
	$(MUGENVTD)      \
	$(MUGENZP)

GENERATOR_OPTS = -o $(OBJ_DIR) $(SYSTEM_POLICY_B)

include ../Makeconf

DUMMY := $(shell mkdir -p $(OBJ_DIR))

ifneq ($(CUR_CFG),$(LAST_CFG))
	CFG_DEPS = cfgchange
endif

all: .validated $(OUTPUT)

cfgchange:
	rm -f $(OBJ_DIR)/*
	echo $(CUR_CFG) > $(OBJ_DIR)/.cfg

$(SYSTEM_CONFIG): $(CFG_DEPS)
	@echo '<system>'                                                         > $@;
	@echo ' <config>'                                                       >> $@;
	@echo '  <string name="system"              value="$(SYSTEM)"/>'        >> $@;
	@echo '  <string name="hardware"            value="$(HARDWARE)"/>'      >> $@;
	@echo '  <string name="additional_hardware" value="$(ADDITIONAL_HW)"/>' >> $@;
	@echo '  <string name="platform"            value="$(PLATFORM)"/>'      >> $@;
	@echo ' </config>'                                                      >> $@;
	@echo '</system>'                                                       >> $@;

$(SCHED_PLAN_PDF): $(SCHED_PLAN_XML)
	(cd $(POLICY_OBJ_DIR) && gnuplot<$(MUGENSCHEDCFG_DIR)/plot.gnuplot)

$(SCHED_PLAN_XML): $(SCHED_CONFIG) $(MUGENSCHEDCFG)
	$(MUGENSCHEDCFG) -r $(SCHED_PLAN_RAW) -d $(SCHED_PLAN_DBG) $^

$(SYSTEM_POLICY_SRC): $(SYSTEM_CONFIG) $(SCHED_PLAN_PDF) $(MUCFGMERGE) $(SOURCES)
	@$(MUCFGMERGE) $< $@ -I $(POLICY_OBJ_DIR)

$(SYSTEM_POLICY_A): $(SYSTEM_POLICY_SRC) $(MUCFGEXPAND)
	@$(MUCFGEXPAND) $< $@

$(SYSTEM_POLICY_B): $(SYSTEM_POLICY_A) $(MUCFGALLOC)
	@$(MUCFGALLOC) $< $@

.validated: $(SYSTEM_POLICY_B) $(MUCFGVALIDATE)
	@$(MUCFGVALIDATE) $<
	@touch $@

$(OUTPUT): $(GENERATORS) $(SYSTEM_POLICY_B)
	@for gen in $(GENERATORS); do $$gen $(GENERATOR_OPTS) || exit 1; done
	ln -sf $(SYSTEM_POLICY_SRC) $(POLICY_SRC)
	ln -sf $(SYSTEM_POLICY_A) $(POLICY_A)
	ln -sf $(SYSTEM_POLICY_B) $(POLICY_B)

clean:
	@rm -rf $(OBJ_DIR) .validated
