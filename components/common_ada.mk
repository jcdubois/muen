include ../../Makeconf

BUILD_OPTS += --RTS=$(TOP_DIR)/rts/obj

ifdef GENERATE_CSPECS
ALL = cspecs
endif

ALL += $(COMPONENT)

all: $(ALL)

$(COMPONENT):
	gprbuild $(BUILD_OPTS) -P$(COMPONENT) -Xstacksize=$(COMPONENT_STACK_SIZE)
	$(MUCHECKSTACK) -P$(COMPONENT) -l$(COMPONENT_STACK_SIZE)
