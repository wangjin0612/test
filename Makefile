SRCDIR  := ./src
INCLDIR := ./include
OUTPUT  := ./output
OBJDIR  := $(OUTPUT)/obj
BINDIR  := $(OUTPUT)/bin
SRCS	:= $(wildcard $(SRCDIR)/*.c)
INCL    := $(wildcard $(INCLDIR)/*.h) \
			$(wildcard $(SRCDIR)/*.h)
OBJS	:= $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))
EXEC    := $(BINDIR)/exec
EXEC_LINK := ./exec

INC_FLAGS += -I./include -I. -I./src
CFLAGS += $(INC_FLAGS)

all: $(EXEC)
	@echo "TARGET: $<"
	@if [ -e $(EXEC_LINK) ]; then rm $(EXEC_LINK); fi
	@ln -s $(EXEC) $(EXEC_LINK)
	@echo "Link: $(EXEC_LINK) <= $(EXEC)"

$(EXEC): $(OBJS)
	@echo "$(CC): $@ <= $^"
	@gcc -o $@ $^

$(OBJS): $(OBJDIR)/%.o:$(SRCDIR)/%.c $(INCL)
	@if [ ! -e $(OBJDIR) ]; then mkdir -p $(OBJDIR); fi
	@if [ ! -e $(BINDIR) ]; then mkdir -p $(BINDIR); fi
	@echo "$(CC): $@ <= $<"
	@$(CC) -c $<  -o $@ $(CFLAGS)

.PHONY: clean
clean:
	@echo "RM: $(OUTPUT)"
	@rm -rf $(OUTPUT)
