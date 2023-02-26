@x l.32
extern Graph *raman();
@y
extern Graph *raman(long,long,unsigned long,unsigned long);
@z

@x l.92
Graph *raman(p,q,type,reduce)
  long p; /* one less than the desired degree; must be prime */
  long q; /* size parameter; must be prime and properly related to |type| */
  unsigned long type; /* selector between different possible constructions */
  unsigned long reduce; /* if nonzero, multiple edges and self-loops won't occur */
@y
Graph *raman(@t\1\1@>
  long p, /* one less than the desired degree; must be prime */
  long q, /* size parameter; must be prime and properly related to |type| */
  unsigned long type, /* selector between different possible constructions */
  unsigned long reduce@t\2\2@>)
    /* if nonzero, multiple edges and self-loops won't occur */
@z

@x l.481
static void deposit(a,b,c,d)
  long a,b,c,d; /* a solution to $a^2+b^2+c^2+d^2=p$ */
@y
static void deposit(long a,long b,long c,long d)
  /* a solution to $a^2+b^2+c^2+d^2=p$ */
@z

@x l.697
static long lin_frac(a,k)
  long a; /* the number being transformed; $q$ represents $\infty$ */
  long k; /* index into |gen| table */
@y
static long lin_frac(@t\1\1@>
  long a, /* the number being transformed; $q$ represents $\infty$ */
  long k@t\2\2@>) /* index into |gen| table */
@z
