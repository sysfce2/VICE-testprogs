##########################################################################
#
# FILE  Makefile
# Copyright (c) 2016 Daniel Kahlin <daniel@kahlin.net>
# Written by Daniel Kahlin <daniel@kahlin.net>
#
# DESCRIPTION
#   makefile
#
######

all::	rr-freeze.bin rr-freeze.crt nr-freeze.crt analyze

rr-freeze.prg:	rr-freeze.asm
	dasm $< -o$@
rr-freeze.crt:	rr-freeze.prg
	cartconv -i $< -o $@ -t rr
rr-freeze.bin:	rr-freeze.crt
	cartconv -i $< -o $@ -t bin
nr-freeze.crt:	rr-freeze.prg
	cartconv -i $< -o $@ -t rr -s 1

CC=gcc
CFLAGS=-Wall -Wextra -Wno-unused-parameter
analyze:	analyze.c
	$(CC) $(CFLAGS) -o$@ $^

# clean out old targets
clean::
	rm -f *~ \#*\#
	rm -f a.out
	rm -f rr-freeze.prg
	rm -f rr-freeze.bin rr-freeze.crt nr-freeze.crt
	rm -f analyze

# eof
