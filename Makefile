# Makefile Flex & Bison Project

# $@ : the current target
# $^ : the current prerequisites
# $< : the first current prerequisite

CC = gcc
CFLAGS = -Wall
EXEC1 = as
EXEC2 = tpc-2020-2021

all: $(EXEC1) clean

$(EXEC1): lex.yy.o $(EXEC2).tab.c
	$(CC) $^ -o $@ $(CFLAGS)

lex.yy.c: src/$(EXEC1).lex $(EXEC2).tab.h
	flex src/$(EXEC1).lex

$(EXEC2).tab.c : src/$(EXEC2).y
	bison -d $(EXE2C).y

$(EXEC2).tab.h : src/$(EXEC2).y
	bison -d src/$(EXEC2).y

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -rf lex.yy.* $(EXEC2).tab.h $(EXEC2).tab.c

mrproper:
	rm -rf as