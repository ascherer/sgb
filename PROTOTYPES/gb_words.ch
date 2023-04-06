@x l.17
extern Graph *words();
extern Vertex *find_word();
@y
#ifndef GB_WORDS_H
#define GB_WORDS_H
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
extern Graph *words(unsigned long,long [],long,long);
extern Vertex *find_word(char *,void (*)(Vertex *));
@z

@x l.152
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
#include "gb_flip.h"
 /* we will use the {\sc GB\_\,FLIP} routines for random numbers */
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
@y
#include "gb_words.h" /* we use our own interface first */
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
#include "gb_flip.h"
 /* we will use the {\sc GB\_\,FLIP} routines for random numbers */
@z

@x l.162
Graph *words(n,wt_vector,wt_threshold,seed)
  unsigned long n; /* maximum number of vertices desired */
  long wt_vector[]; /* pointer to array of weights */
  long wt_threshold; /* minimum qualifying weight */
  long seed; /* random number seed */
@y
Graph *words(
  unsigned long n, /* maximum number of vertices desired */
  long wt_vector[], /* pointer to array of weights */
  long wt_threshold, /* minimum qualifying weight */
  long seed) /* random number seed */
@z

@x l.210
static double flabs(x)
  long x;
@y
static double flabs(
  long x)
@z

@x l.256
static long iabs(x)
  long x;
@y
static long iabs(
  long x)
@z

@x l.359
  do@+{
@y
  do {
@z

@x l.366
  }@+while (gb_char()==',');
@y
  } while (gb_char()==',');
@z

@x l.418
@d weight u.I /* weighted frequencies */
@d loc a.I /* index of difference (0, 1, 2, 3, or 4) */

@(gb_words.h@>=
#define weight @[u.I@] /* repeat the definitions in the header file */
#define loc @[a.I@]
@y
@(gb_words.h@>=
#define weight @[u.I@] /* weighted frequencies */
#define loc @[a.I@] /* index of difference (0, 1, 2, 3, or 4) */
@#
#endif /* |GB_WORDS_H| */
@z

@x l.426
if (n==0 || nn<n)
@y
if (n==0 || nn<(long)n)
@z

@x l.508
@p Vertex *find_word(q,f)
  char *q;
  void @[@] (*f)(); /* |*f| should take one argument, of type |Vertex *|,
                        or |f| should be |NULL| */
@y
@p Vertex *find_word(
  char *q,
  void @[@] (*f)(Vertex *))
    /* |*f| should take one argument, of type |Vertex *|,
       or |f| should be |NULL| */
@z
