@x l.14
extern Graph *roget();
@y
#ifndef GB_ROGET_H
#define GB_ROGET_H
typedef struct graph_struct Graph;
extern Graph *roget(unsigned long,unsigned long,unsigned long,long);
@z

@x l.70
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
@y
#include "gb_roget.h" /* we use our own interface |@(gb_roget.h@>| first */
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
@z

@x l.78
Graph *roget(n,min_distance,prob,seed)
  unsigned long n; /* number of vertices desired */
  unsigned long min_distance; /* smallest inter-category distance allowed
                            in an arc */
  unsigned long prob; /* 65536 times the probability of rejecting an arc */
  long seed; /* random number seed */
@y
Graph *roget(
  unsigned long n, /* number of vertices desired */
  unsigned long min_distance,
    /* smallest inter-category distance allowed in an arc */
  unsigned long prob, /* 65536 times the probability of rejecting an arc */
  long seed) /* random number seed */
@z

@x l.170
@d cat_no u.I /* utility field |u| of each vertex holds the category number */

@y
@z

@x l.176
    if (gb_number(10)!=k) panic(syntax_error); /* out of synch */
@y
    if ((long)gb_number(10)!=k) panic(syntax_error); /* out of synch */
@z

@x l.188
#define cat_no @t\quad@> u.I
 /* definition of |cat_no| is repeated in the header file */
@y
#define cat_no @t\quad@> u.I
  /* utility field |u| of each vertex holds the category number */
#endif /* |GB_ROGET_H| */
@z

@x l.198
  if (mapping[j] && iabs(j-k)>=min_distance &&
       (prob==0 || ((gb_next_rand()>>15)>=prob)))
@y
  if (mapping[j] && (unsigned long)iabs(j-k)>=min_distance &&
       (prob==0 || ((unsigned long)(gb_next_rand()>>15)>=prob)))
@z

@x l.205
    /* fall through to the space case */
  case ' ': j=gb_number(10);@+break;
@y
    @=/* fall through */@>@;
  case ' ': j=gb_number(10);@+break;
@z
