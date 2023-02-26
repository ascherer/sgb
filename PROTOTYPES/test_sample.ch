@x l.32
@t\4@>int main()
@y
int main(void)
@z

@x l.165
static void pr_vert();
   /* a subroutine for printing a vertex is declared below */
static void pr_arc(); /* likewise for arcs */
static void pr_util(); /* and for utility fields in general */
static void print_sample(g,n)
  Graph *g; /* graph to be sampled and destroyed */
  int n; /* index to the sampled vertex */
@y
static void pr_vert(Vertex *,int,char *);
   /* a subroutine for printing a vertex is declared below */
static void pr_arc(Arc *,int,char *); /* likewise for arcs */
static void pr_util(util,char,int,char *); /* and for utility fields in general */
static void print_sample(@t\1\1@>
  Graph *g, /* graph to be sampled and destroyed */
  int n@t\2\2@>) /* index to the sampled vertex */
@z

@x l.191
static void pr_vert(v,l,s)
  Vertex *v; /* vertex to be printed */
  int l; /* |<=0| if the output should be terse */
  char *s; /* format for graph utility fields */
@y
static void pr_vert(@t\1\1@>
  Vertex *v, /* vertex to be printed */
  int l, /* |<=0| if the output should be terse */
  char *s@t\2\2@>) /* format for graph utility fields */
@z

@x l.216
static void pr_arc(a,l,s)
  Arc *a; /* non-null arc to be printed */
  int l; /* |<=0| if the output should be terse */
  char *s; /* format for graph utility fields */
@y
static void pr_arc(@t\1\1@>
  Arc *a, /* non-null arc to be printed */
  int l, /* |<=0| if the output should be terse */
  char *s@t\2\2@>) /* format for graph utility fields */
@z

@x l.231
static void pr_util(u,c,l,s)
  util u; /* a utility field to be printed */
  char c; /* its type code */
  int l; /* 0 if output should be terse, |-1| if pointers omitted */
  char *s; /* utility types for overall graph */
@y
static void pr_util(@t\1\1@>
  util u, /* a utility field to be printed */
  char c, /* its type code */
  int l, /* 0 if output should be terse, |-1| if pointers omitted */
  char *s@t\2\2@>) /* utility types for overall graph */
@z
