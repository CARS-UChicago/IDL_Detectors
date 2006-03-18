# Makefile for GridrecIDL for Linux

SHELL = /bin/sh
CFLAGS = -O -fPIC -Wall
INCLUDES=-I../
MAKE = make

# For FFTW
OBJ = mar3xx_pck.o mar345_IDL.o
SRC = mar3xx_pck.c mar345_IDL.c

mar345_IDL.so: $(OBJ)
	@echo "Creating mar345_IDL.so"
	$(LD) -G -o$@ $(OBJ);

clean:
	rm *.o mar345_IDL.so 

