CC = gcc
CFLAGS = `idris --include`

editline_idris.o: editline_idris.c editline_idris.h

clean: .PHONY
	rm editline_idris.o

.PHONY:
