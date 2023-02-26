@x l.31
extern Graph *random_graph();
extern Graph *random_bigraph();
extern long random_lengths();
@y
extern Graph *random_graph(unsigned long,unsigned long,long,long,long,@|
  long *,long *,long,long,long);
extern Graph *random_bigraph(unsigned long,unsigned long,unsigned long,@|
  long,long *,long *,long,long,long);
extern long random_lengths(Graph *,long,long,long,long *,long);
@z

@x l.139
Graph *random_graph(n,m,multi,self,directed,dist_from,dist_to,min_len,max_len,
                       seed)
  unsigned long n; /* number of vertices desired */
  unsigned long m; /* number of arcs or edges desired */
  long multi; /* allow duplicate arcs? */
  long self; /* allow self loops? */
  long directed; /* directed graph? */
  long *dist_from; /* distribution of arc sources */
  long *dist_to; /* distribution of arc destinations */
  long min_len,max_len; /* bounds on random lengths */
  long seed; /* random number seed */
@y
Graph *random_graph(@t\1\1@>
  unsigned long n, /* number of vertices desired */
  unsigned long m, /* number of arcs or edges desired */
  long multi, /* allow duplicate arcs? */
  long self, /* allow self loops? */
  long directed, /* directed graph? */
  long *dist_from, /* distribution of arc sources */
  long *dist_to, /* distribution of arc destinations */
  long min_len,long max_len, /* bounds on random lengths */
  long seed@t\2\2@>) /* random number seed */
@z

@x l.369
static magic_entry *walker(n,nn,dist,g)
  long n; /* length of |dist| vector */
  long nn; /* $2^{\lceil\mskip1mu\lg n\rceil}$ */
  register long *dist;
    /* start of distribution table, which sums to $2^{30}$ */
  Graph *g; /* tables will be allocated for this graph's vertices */
@y
static magic_entry *walker(@t\1\1@>
  long n, /* length of |dist| vector */
  long nn, /* $2^{\lceil\mskip1mu\lg n\rceil}$ */
  register long *dist, /* start of distribution table, which sums to $2^{30}$ */
  Graph *g@t\2\2@>) /* tables will be allocated for this graph's vertices */
@z

@x l.454
Graph *random_bigraph(n1,n2,m,multi,dist1,dist2,min_len,max_len,seed)
  unsigned long n1,n2; /* number of vertices desired in each part */
  unsigned long m; /* number of edges desired */
  long multi; /* allow duplicate edges? */
  long *dist1, *dist2; /* distribution of edge endpoints */
  long min_len,max_len; /* bounds on random lengths */
  long seed; /* random number seed */
@y
Graph *random_bigraph(@t\1\1@>
  unsigned long n1,unsigned long n2,
    /* number of vertices desired in each part */
  unsigned long m,
    /* number of edges desired */
  long multi,
    /* allow duplicate edges? */
  long *dist1,long *dist2,
    /* distribution of edge endpoints */
  long min_len,long max_len,
    /* bounds on random lengths */
  long seed@t\2\2@>)
    /* random number seed */
@z

@x l.523
long random_lengths(g,directed,min_len,max_len,dist,seed)
  Graph *g; /* graph whose lengths will be randomized */
  long directed; /* is it directed? */
  long min_len,max_len; /* bounds on random lengths */
  long *dist; /* distribution of lengths */
  long seed; /* random number seed */
@y
long random_lengths(@t\1\1@>
  Graph *g, /* graph whose lengths will be randomized */
  long directed, /* is it directed? */
  long min_len,long max_len, /* bounds on random lengths */
  long *dist, /* distribution of lengths */
  long seed@t\2\2@>) /* random number seed */
@z
