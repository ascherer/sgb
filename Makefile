#
#   Makefile for the Stanford GraphBase
#

#   Change DATADIR to the directory where the data files will go (425K bytes)
DATADIR = /usr/local/lib

#   Uncomment the next line if your C uses <string.h> but not <strings.h>
# SYS = -DSYSV

#   If you prefer optimization to debugging, change CFLAGS to something like -O
CFLAGS = -g

#   Change MLIB, if necessary, to the code that loads the C math library
MLIB = -lm

install:
	- mkdir $(DATADIR)
	install -c -m 444 *.dat $(DATADIR)

%.c: %.w
	ctangle $*

%.o: %.c
	cc $(CFLAGS) -c $*.c

IFGS = gb_io.o gb_flip.o gb_graph.o gb_sort.o
IFG = gb_io.o gb_flip.o gb_graph.o
IG = gb_io.o gb_graph.o
FG = gb_flip.o gb_graph.o

assign_mona: assign_mona.c $(IG) gb_mona.o
	cc $(CFLAGS) assign_mona.c $(IG) gb_mona.o -o assign_mona

book_components: book_components.c $(IFGS) gb_books.o
	cc $(CFLAGS) book_components.c $(IFGS) gb_books.o -o book_components

econ_order: econ_order.c $(IFG) gb_econ.o
	cc $(CFLAGS) econ_order.c $(IFG) gb_econ.o -o econ_order

football: football.c $(IFGS) gb_games.o
	cc $(CFLAGS) football.c $(IFGS) gb_games.o -o football

gb_graph.o: gb_graph.c
	cc $(CFLAGS) $(SYS) -c $*.c

gb_io.o: gb_io.c
	echo "#define DATA_DIRECTORY \"$(DATADIR)/\"" >localdefs.h
	cc $(CFLAGS) $(SYS) -c $*.c
	rm localdefs.h

gb_plane.o: gb_miles.o

girth: girth.c $(FG) gb_raman.o
	cc $(CFLAGS) girth.c $(FG) gb_raman.o -o girth $(MLIB)

miles_span: miles_span.c $(IFGS) gb_miles.o
	cc $(CFLAGS) miles_span.c $(IFGS) gb_miles.o -o miles_span

multiply: multiply.c $(FG) gb_gates.o
	cc $(CFLAGS) multiply.c $(FG) gb_gates.o -o multiply

queen: queen.c $(IG) gb_basic.o gb_save.o
	cc $(CFLAGS) queen.c $(IG) gb_basic.o gb_save.o -o queen

queen_wrap.c: queen.w queen_wrap.ch
	ctangle queen_wrap.w queen_wrap.ch queen_wrap.c

queen_wrap: queen_wrap.c $(IG) gb_basic.o gb_save.o
	cc $(CFLAGS) queen_wrap.c $(IG) gb_basic.o gb_save.o -o queen_wrap

roget_components: roget_components.c $(IFG) gb_roget.o
	cc $(CFLAGS) roget_components.c $(IFG) gb_roget.o -o roget_components

take_risc: take_risc.c $(FG) gb_gates.o
	cc $(CFLAGS) take_risc.c $(FG) gb_gates.o -o take_risc

word_components: word_components.c $(IFGS) gb_words.o
	cc $(CFLAGS) word_components.c $(IFGS) gb_words.o -o word_components

ladders: ladders.c $(IFGS) gb_words.o gb_dijk.o
	cc $(CFLAGS) ladders.c $(IFGS) gb_words.o gb_dijk.o -o ladders

test_io: gb_io.o
	cc $(CFLAGS) test_io.c gb_io.o -o test_io

test_graph: gb_graph.o
	cc $(CFLAGS) test_graph.c gb_graph.o -o test_graph

test_flip: gb_flip.o
	cc $(CFLAGS) test_flip.c gb_flip.o -o test_flip

test_sample: test_sample.c $(IFGS) gb_basic.o gb_books.o gb_econ.o \
	  gb_games.o gb_gates.o gb_miles.o gb_mona.o gb_plane.o gb_raman.o \
	  gb_rand.o gb_roget.o gb_save.o gb_words.o
	cc $(CFLAGS) test_sample.c $(IFGS) gb_basic.o gb_books.o gb_econ.o \
	gb_games.o gb_gates.o gb_miles.o gb_mona.o gb_plane.o gb_raman.o \
	gb_rand.o gb_roget.o gb_save.o gb_words.o -o test_sample

test_all: test_io test_graph test_flip test_sample
	test_io
	test_graph
	test_flip
	test_sample > sample.out
	diff test.gb test.correct
	diff sample.out sample.correct
	rm test.gb sample.out test_io test_graph test_flip test_sample

veryclean:
	rm -f *.o *.c *.h \
	       assign_mona book_components econ_order football \
	       girth ladders miles_span multiply roget_components \
	       take_risc word_components
