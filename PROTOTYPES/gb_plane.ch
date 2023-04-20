@x l.16
@d plane_miles p_miles /* abbreviation for Procrustean external linkage */

@(gb_plane.h@>=
#define plane_miles p_miles
extern Graph *plane();
extern Graph *plane_miles();
extern void delaunay();
@y
@(gb_plane.h@>=
#ifndef GB_PLANE_H
#define GB_PLANE_H
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
#define plane_miles p_miles /* abbreviation for Procrustean external linkage */
extern Graph *plane(unsigned long,unsigned long,unsigned long,@|
  unsigned long,unsigned long,long);
extern Graph *plane_miles(unsigned long,long,long,long,@|
  unsigned long,unsigned long,long);
extern void delaunay(Graph *,void (*)(Vertex *,Vertex *));
#endif /* |GB_PLANE_H| */
@z

@x l.61
@(gb_plane.h@>=
#define INFTY @t\quad@> 0x10000000L

@y
@z

@x l.76
#include "gb_flip.h"
 /* we will use the {\sc GB\_\,FLIP} routines for random numbers */
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
#include "gb_miles.h" /* and we might use {\sc GB\_\,MILES} for mileage data */
#include "gb_io.h"
 /* and {\sc GB\_\,MILES} uses {\sc GB\_\,IO}, which has |str_buf| */
@y
#include "gb_plane.h" /* we use our own interface |@(gb_plane.h@>| first */
#include "gb_flip.h"
 /* we will use the {\sc GB\_\,FLIP} routines for random numbers */
#include "gb_miles.h" /* and we might use {\sc GB\_\,MILES} for mileage data */
@z

@x l.92
Graph *plane(n,x_range,y_range,extend,prob,seed)
  unsigned long n; /* number of vertices desired */
  unsigned long x_range,y_range; /* upper bounds on rectangular coordinates */
  unsigned long extend; /* should a point at infinity be included? */
  unsigned long prob; /* probability of rejecting a Delaunay edge */
  long seed; /* random number seed */
@y
Graph *plane(
  unsigned long n,
    /* number of vertices desired */
  unsigned long x_range,unsigned long y_range,
    /* upper bounds on rectangular coordinates */
  unsigned long extend,
    /* should a point at infinity be included? */
  unsigned long prob,
    /* probability of rejecting a Delaunay edge */
  long seed)
    /* random number seed */
@z

@x l.135
for (k=0,v=new_graph->vertices; k<n; k++,v++) {
@y
for (k=0,v=new_graph->vertices; k<(long)n; k++,v++) {
@z

@x l.149
@ @(gb_plane.h@>=
#define x_coord @t\quad@> x.I
#define y_coord @t\quad@> y.I
#define z_coord @t\quad@> z.I
@y
@ (This section remains empty for historic reasons.)
@z

@x l.226
void delaunay(g,f)
  Graph *g; /* vertices in the plane */
  void @[@] (*f)(); /* procedure that absorbs the triangulated edges */
@y
void delaunay(
  Graph *g, /* vertices in the plane */
  void @[@] (*f)(Vertex *,Vertex *))
    /* procedure that absorbs the triangulated edges */
@z

@x l.252
static void new_euclid_edge(u,v)
  Vertex *u,*v;
@y
static void new_euclid_edge(Vertex *u,Vertex *v)
@z

@x l.255
  if ((gb_next_rand()>>15)>=gprob) {
@y
  if ((unsigned long)(gb_next_rand()>>15)>=gprob) {
@z

@x l.283
static long int_sqrt(x)
  long x;
@y
static long int_sqrt(
  long x)
@z

@x l.322
static long sign_test(x1,x2,x3,y1,y2,y3)
  long x1,x2,x3,y1,y2,y3;
@y
static long sign_test(
  long x1,long x2,long x3,long y1,long y2,long y3)
@z

@x l.431
static long ccw(u,v,w)
  Vertex *u,*v,*w;
@y
static long ccw(
  Vertex *u,Vertex *v,Vertex *w)
@z

@x l.474
static long incircle(t,u,v,w)
  Vertex *t,*u,*v,*w;
@y
static long incircle(
  Vertex *t,Vertex *u,Vertex *v,Vertex *w)
@z

@x l.542
static long ff(t,u,v,w)
  Vertex *t,*u,*v,*w;
@y
static long ff(
  Vertex *t,Vertex *u,Vertex *v,Vertex *w)
@z

@x l.550
static long gg(t,u,v,w)
  Vertex *t,*u,*v,*w;
@y
static long gg(
  Vertex *t,Vertex *u,Vertex *v,Vertex *w)
@z

@x l.558
static long hh(t,u,v,w)
  Vertex *t,*u,*v,*w;
@y
static long hh(
  Vertex *t,Vertex *u,Vertex *v,Vertex *w)
@z

@x l.563
static long jj(t,u,v,w)
  Vertex *t,*u,*v,*w;
@y
static long jj(
  Vertex *t,Vertex *u,Vertex *v,Vertex *w)
@z

@x l.751
do@+{
@y
do {
@z

@x l.755
}@+while (x->u);
@y
} while (x->u);
@z

@x l.882
static void flip(c,d,e,t,tp,tpp,p,xp,xpp)
  arc *c,*d,*e;
  Vertex *t,*tp,*tpp,*p;
  node *xp,*xpp;
@y
static void flip(
  arc *c,arc *d,arc *e,@|
  Vertex *t,Vertex *tp,Vertex *tpp,Vertex *p,@|
  node *xp,node *xpp)
@z

@x l.886
{@+register arc *ep=e->next, *cp=c->next, *cpp=cp->next;
@y
{@+register arc *ep=e->next, *cp=c->next, *cpp=cp->next;
  (void) t; (void) tp;
@z

@x l.931
Graph *plane_miles(n,north_weight,west_weight,pop_weight,extend,prob,seed)
  unsigned long n; /* number of vertices desired */
  long north_weight; /* coefficient of latitude in the weight function */
  long west_weight; /* coefficient of longitude in the weight function */
  long pop_weight; /* coefficient of population in the weight function */
  unsigned long extend; /* should a point at infinity be included? */
  unsigned long prob; /* probability of rejecting a Delaunay edge */
  long seed; /* random number seed */
@y
Graph *plane_miles(
  unsigned long n,
    /* number of vertices desired */
  long north_weight,
    /* coefficient of latitude in the weight function */
  long west_weight,
    /* coefficient of longitude in the weight function */
  long pop_weight,
    /* coefficient of population in the weight function */
  unsigned long extend,
    /* should a point at infinity be included? */
  unsigned long prob,
    /* probability of rejecting a Delaunay edge */
  long seed)
    /* random number seed */
@z

@x l.982
static void new_mile_edge(u,v)
  Vertex *u,*v;
@y
static void new_mile_edge(
  Vertex *u,Vertex *v)
@z

@x l.985
  if ((gb_next_rand()>>15)>=gprob) {
@y
  if ((unsigned long)(gb_next_rand()>>15)>=gprob) {
@z
