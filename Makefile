CC = gcc
CFLAGS = `idris --include`

baseline_idris.o: baseline_idris.c baseline_idris.h

clean: .PHONY
	rm baseline_idris.o

.PHONY:
