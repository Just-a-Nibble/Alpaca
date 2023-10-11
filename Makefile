all: compiler

COMP_SRCS = $(shell find alpaca/ -name '.ccls-cache' -type d -prune -o -type f -name '*.alpaca' -print)

COMP_OBJS = $(COMP_SRCS:%.alpaca=%.o)

%.o: %.alpaca
	cat $(@:%.o=%.alpaca) | ./compiler | as -o $@

compiler: $(COMP_OBJS)
	ld -S $(COMP_OBJS) llama/std.o -o selfhost

clean:
	rm -f selfhost $(COMP_OBJS)