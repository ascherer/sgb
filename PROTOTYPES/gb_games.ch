@x l.14
extern Graph *games();
@y
#ifndef GB_GAMES_H
#define GB_GAMES_H
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
extern Graph *games(unsigned long,long,long,long,long,long,long,long);
@z

@x l.90
@d MAX_N 120
@d MAX_DAY 128
@d MAX_WEIGHT 131072
@d ap u.I /* Associated Press scores: |(ap0<<16)+ap1| */
@d upi v.I /* United Press International scores |(upi0<<16)+upi1| */
@y
@d MAX_N 120
@d MAX_DAY 128
@d MAX_WEIGHT 131072

@(gb_games.h@>=
#define ap @[u.I@] /* Associated Press scores: |(ap0<<16)+ap1| */
#define upi @[v.I@] /* United Press International scores |(upi0<<16)+upi1| */
@z

@x l.112
@d conference z.S
@y
@(gb_games.h@>=
#define conference @[z.S@]
@z

@x l.124
@d nickname y.S
@d abbr x.S
@y
@(gb_games.h@>=
#define abbr @[x.S@]
#define nickname @[y.S@]
@z

@x l.134
@d HOME 1
@d NEUTRAL 2 /* this value is halfway between |HOME| and |AWAY| */
@d AWAY 3
@d venue a.I
@d date b.I

@y
@z

@x l.141
#define ap @[u.I@] /* repeat the definitions in the header file */
#define upi @[v.I@]
#define abbr @[x.S@]
#define nickname @[y.S@]
#define conference @[z.S@]
#define HOME 1
#define NEUTRAL 2
#define AWAY 3
#define venue @[a.I@]
#define date @[b.I@]
@y
#define HOME 1
#define NEUTRAL 2
#define AWAY 3
#define date @[b.I@]
@#
#endif /* |GB_GAMES_H| */
@z

@x l.164
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
#include "gb_flip.h"
 /* we will use the {\sc GB\_\,FLIP} routines for random numbers */
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
@y
#include "gb_games.h" /* we use our own interface first */
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
#include "gb_flip.h"
 /* we will use the {\sc GB\_\,FLIP} routines for random numbers */
@z

@x l.174
Graph *games(n,ap0_weight,upi0_weight,ap1_weight,upi1_weight,
     first_day,last_day,seed)
  unsigned long n; /* number of vertices desired */
  long ap0_weight; /* coefficient of |ap0| in the weight function */
  long ap1_weight; /* coefficient of |ap1| in the weight function */
  long upi0_weight; /* coefficient of |upi0| in the weight function */
  long upi1_weight; /* coefficient of |upi1| in the weight function */
  long first_day; /* lower cutoff for games to be considered */
  long last_day; /* upper cutoff for games to be considered */
  long seed; /* random number seed */
@y
Graph *games(
  unsigned long n, /* number of vertices desired */
  long ap0_weight, /* coefficient of |ap0| in the weight function */
  long upi0_weight, /* coefficient of |ap1| in the weight function */
  long ap1_weight, /* coefficient of |upi0| in the weight function */
  long upi1_weight, /* coefficient of |upi1| in the weight function */
  long first_day, /* lower cutoff for games to be considered */
  long last_day, /* upper cutoff for games to be considered */
  long seed) /* random number seed */
@z

@x l.440
static Vertex *team_lookup() /* read and decode an abbreviation */
@y
static Vertex *team_lookup(void) /* read and decode an abbreviation */
@z

@x l.459
@<Enter a new edge@>=
@y
@d venue a.I

@<Enter a new edge@>=
@z
