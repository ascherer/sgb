@x l.21
extern long* lisa();
extern Graph *plane_lisa();
extern Graph *bi_lisa();
@y
extern long* lisa(unsigned long,unsigned long,unsigned long,@|
   unsigned long,unsigned long,unsigned long,unsigned long,@|
   unsigned long,unsigned long,Area);@/
extern Graph *plane_lisa(unsigned long,unsigned long,unsigned long,@|
   unsigned long,unsigned long,unsigned long,@|
   unsigned long,unsigned long,unsigned long);
extern Graph *bi_lisa(unsigned long,unsigned long,@|
   unsigned long,unsigned long,unsigned long,unsigned long,@|
   unsigned long,long);
@z

@x l.149
long *lisa(m,n,d,m0,m1,n0,n1,d0,d1,area)
  unsigned long m,n; /* number of rows and columns desired */
  unsigned long d; /* maximum pixel value desired */
  unsigned long m0,m1; /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,n1; /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,d1; /* lower and upper threshold of raw pixel scores */
  Area area; /* where to allocate the matrix that will be output */
@y
long *lisa(@t\1\1@>
  unsigned long m,unsigned long n,
    /* number of rows and columns desired */
  unsigned long d,
    /* maximum pixel value desired */
  unsigned long m0,unsigned long m1,
    /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,unsigned long n1,
    /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,unsigned long d1,
    /* lower and upper threshold of raw pixel scores */
  Area area@t\2\2@>)
    /* where to allocate the matrix that will be output */
@z

@x l.286
static long na_over_b(n,a,b)
  long n,a,b;
@y
static long na_over_b(long n,long a,long b)
@z

@x l.405
@p Graph *plane_lisa(m,n,d,m0,m1,n0,n1,d0,d1)
  unsigned long m,n; /* number of rows and columns desired */
  unsigned long d; /* maximum value desired */
  unsigned long m0,m1; /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,n1; /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,d1; /* lower and upper threshold of raw pixel scores */
@y
@p Graph *plane_lisa(@t\1\1@>
  unsigned long m,unsigned long n,
    /* number of rows and columns desired */
  unsigned long d,
    /* maximum value desired */
  unsigned long m0,unsigned long m1,
    /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,unsigned long n1,
    /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,unsigned long d1@t\2\2@>)
    /* lower and upper threshold of raw pixel scores */
@z

@x l.562
static void adjac(u,v)
  Vertex *u,*v;
@y
static void adjac(Vertex *u,Vertex *v)
@z

@x l.591
@p Graph *bi_lisa(m,n,m0,m1,n0,n1,thresh,c)
  unsigned long m,n; /* number of rows and columns desired */
  unsigned long m0,m1; /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,n1; /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long thresh; /* threshold defining adjacency */
  long c; /* should we prefer dark pixels to light pixels? */
@y
@p Graph *bi_lisa(@t\1\1@>
  unsigned long m,unsigned long n,
    /* number of rows and columns desired */
  unsigned long m0,unsigned long m1,
    /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,unsigned long n1,
    /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long thresh,
    /* threshold defining adjacency */
  long c@t\2\2@>)
    /* should we prefer dark pixels to light pixels? */
@z
