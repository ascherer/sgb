@x l.14
extern Graph *econ();
@y
extern Graph *econ(unsigned long,unsigned long,unsigned long,long);
@z

@x l.190
Graph *econ(n,omit,threshold,seed)
  unsigned long n; /* number of vertices desired */
  unsigned long omit; /* number of special vertices to omit */
  unsigned long threshold; /* minimum per-64K-age in arcs leading in */
  long seed; /* random number seed */
@y
Graph *econ(@t\1\1@>
  unsigned long n, /* number of vertices desired */
  unsigned long omit, /* number of special vertices to omit */
  unsigned long threshold, /* minimum per-64K-age in arcs leading in */
  long seed@t\2\2@>) /* random number seed */
@z
