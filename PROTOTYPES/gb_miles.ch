@x l.14
extern Graph *miles();
@y
#ifndef GB_MILES_H
#define GB_MILES_H
typedef struct graph_struct Graph;
typedef struct vertex_struct Vertex;
extern Graph *miles(unsigned long,long,long,long,@|
  unsigned long,unsigned long,long);
@z

@x l.63
@d MAX_N 128

@y
@z

@x l.107
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
@y
#include "gb_miles.h" /* we use our own interface |@(gb_miles.h@>| first */
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
@z

@x l.116
Graph *miles(n,north_weight,west_weight,pop_weight,
    max_distance,max_degree,seed)
  unsigned long n; /* number of vertices desired */
  long north_weight; /* coefficient of latitude in the weight function */
  long west_weight; /* coefficient of longitude in the weight function */
  long pop_weight; /* coefficient of population in the weight function */
  unsigned long max_distance; /* maximum distance in an edge, if nonzero */
  unsigned long max_degree;
       /* maximum number of edges per vertex, if nonzero */
  long seed; /* random number seed */
@y
Graph *miles(
  unsigned long n, /* number of vertices desired */
  long north_weight, /* coefficient of latitude in the weight function */
  long west_weight, /* coefficient of longitude in the weight function */
  long pop_weight, /* coefficient of population in the weight function */
  unsigned long max_distance, /* maximum distance in an edge, if nonzero */
  unsigned long max_degree, /* maximum number of edges per vertex, if nonzero */
  long seed) /* random number seed */
@z

@x l.303
@d x_coord x.I
@d y_coord y.I
@d index_no z.I
@y
@z

@x l.324
#define people @t\quad@> w.I
@y
@z

@x l.366
      if (j>max_distance)
@y
      if (j>(long)max_distance)
@z

@x l.378
    if (++j>max_degree)
@y
    if (++j>(long)max_degree)
@z

@x l.389
The result might be negative when an edge has been suppressed. Moreover,
we can in fact have |miles_distance(u,v)<0| when |miles_distance(v,u)>0|,
@y
The result might be negative when an edge has been suppressed.
We can in fact have |miles_distance(u,v)<0| when |miles_distance(v,u)>0|,
@z

@x l.394
@p long miles_distance(u,v)
  Vertex *u,*v;
@y
@p long miles_distance(
  Vertex *u,Vertex *v)
@z

@x l.401
extern long miles_distance();
@y
extern long miles_distance(Vertex *,Vertex *);
#endif /* |GB_MILES_H| */
@z
