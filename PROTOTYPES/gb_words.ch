@x l.17
extern Graph *words();
extern Vertex *find_word();
@y
extern Graph *words(unsigned long,long [],long,long);
extern Vertex *find_word(char *,void (*)(Vertex *));
@z

@x l.162
Graph *words(n,wt_vector,wt_threshold,seed)
  unsigned long n; /* maximum number of vertices desired */
  long wt_vector[]; /* pointer to array of weights */
  long wt_threshold; /* minimum qualifying weight */
  long seed; /* random number seed */
@y
Graph *words(@t\1\1@>
  unsigned long n, /* maximum number of vertices desired */
  long wt_vector[], /* pointer to array of weights */
  long wt_threshold, /* minimum qualifying weight */
  long seed@t\2\2@>) /* random number seed */
@z

@x l.210
static double flabs(x)
  long x;
@y
static double flabs(long x)
@z

@x l.256
static long iabs(x)
  long x;
@y
static long iabs(long x)
@z

@x l.508
@p Vertex *find_word(q,f)
  char *q;
  void @[@] (*f)(); /* |*f| should take one argument, of type |Vertex *|,
                        or |f| should be |NULL| */
@y
@p Vertex *find_word(@t\1\1@>
  char *q,void (*f)(Vertex *)@t\2\2@>)
    /* |*f| should take one argument, of type |Vertex *|,
       or |f| should be |NULL| */
@z
