all: compiler stdlib

COMP_SRCS = $(shell find alpaca/ -name '.ccls-cache' -type d -prune -o -type f -name '*.S' -print)
COMP_HDRS = $(shell find alpaca/ -name '.ccls-cache' -type d -prune -o -type f -name '*.h' -print)

STD_SRCS = $(shell find llama/ -name '.ccls-cache' -type d -prune -o -type f -name '*.S' -print)
STD_HDRS = $(shell find llama/ -name '.ccls-cache' -type d -prune -o -type f -name '*.h' -print)

COMP_OBJS = $(COMP_SRCS:%.S=%.o)

%.o: %.S $(COMP_HDRS)
	as $(@:%.o=%.S) -o $@

compiler: $(COMP_OBJS) $(COMP_HDRS)
	ld -S $(COMP_OBJS) -o compiler

compiler-debug: $(COMP_OBJS) $(COMP_HDRS)
	ld $(COMP_OBJS) -o compiler-debug

stdlib: $(STD_HDRS)
	as $(STD_SRCS) -o llama/std.o

clean:
	rm -f compiler compiler-debug $(COMP_OBJS) llama/std.o