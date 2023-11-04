@x l.14
extern Graph *econ();
@y
#ifndef GB_ECON_H
#define GB_ECON_H
typedef struct graph_struct Graph;
extern Graph *econ(unsigned long,unsigned long,unsigned long,long);
@z

@x l.72
@d flow a.I /* utility field |a| specifies the flow in an arc */
@y
@(gb_econ.h@>=
#define flow @t\quad@> a.I /* utility field |a| specifies the flow in an arc */
#endif /* |GB_ECON_H| */
@z

@x l.162
@(gb_econ.h@>=
#define flow @t\quad@> a.I
   /* definitions of utility fields in the header file */
#define SIC_codes @t\quad@> z.A
#define sector_total @t\quad@> y.I

@y
@z

@x l.181
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
@y
#include "gb_econ.h" /* we use our own interface |@(gb_econ.h@>| first */
@z

@x l.190
Graph *econ(n,omit,threshold,seed)
  unsigned long n; /* number of vertices desired */
  unsigned long omit; /* number of special vertices to omit */
  unsigned long threshold; /* minimum per-64K-age in arcs leading in */
  long seed; /* random number seed */
@y
Graph *econ(
  unsigned long n, /* number of vertices desired */
  unsigned long omit, /* number of special vertices to omit */
  unsigned long threshold, /* minimum per-64K-age in arcs leading in */
  long seed) /* random number seed */
@z
