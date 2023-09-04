all: compiler

SRCS = $(shell find alpaca/ -name '.ccls-cache' -type d -prune -o -type f -name '*.S' -print)
HDRS = $(shell find alpaca/ -name '.ccls-cache' -type d -prune -o -type f -name '*.h' -print)

OBJS = $(SRCS:%.S=%.o)

%.o: %.S $(HDRS)
	as $(@:%.o=%.S) -o $@

compiler: $(OBJS) $(HDRS)
	ld $(OBJS) -o compiler

compiler-debug: $(SRCS) $(HDRS)
	ld $(OBJS) -o compiler-debug

clean:
	rm -f compiler compiler-debug $(OBJS)