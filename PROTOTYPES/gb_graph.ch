@x l.28
int main()
@y
int main(void)
@z

@x l.266
char *gb_alloc(n,s)
  long n; /* number of consecutive bytes desired */
  Area s; /* storage area that will contain the new block */
@y
char *gb_alloc(@t\1\1@>
  long n, /* number of consecutive bytes desired */
  Area s@t\2\2@>) /* storage area that will contain the new block */
@z

@x l.297
void gb_free(s)
  Area s;
@y
void gb_free(Area s)
@z

@x l.311
extern char *gb_alloc(); /* allocate another block for an area */
#define gb_typed_alloc(n,t,s) @[@t\quad@>\
               @[(t*)@]gb_alloc((long)((n)*@[sizeof@](t)),s)@]
extern void gb_free(); /* deallocate all blocks for an area */
@y
extern char *gb_alloc(long,Area); /* allocate another block for an area */
#define gb_typed_alloc(n,t,s) @[@t\quad@>\
               @[(t*)@]gb_alloc((long)((n)*@[sizeof@](t)),s)@]
extern void gb_free(Area); /* deallocate all blocks for an area */
@z

@x l.442
Graph *gb_new_graph(n)
  long n; /* desired number of vertices */
@y
Graph *gb_new_graph(long n)
  /* desired number of vertices */
@z

@x l.476
extern void make_compound_id();
  /* routine to set one |id| field from another */
extern void make_double_compound_id(); /* ditto, but from two others */
@y
extern void make_compound_id(Graph *,char *,Graph *,char *);
  /* routine to set one |id| field from another */
extern void make_double_compound_id(Graph *,char *,Graph *,char *,@|
  Graph *,char *); /* ditto, but from two others */
@z

@x l.485
void make_compound_id(g,s1,gg,s2) /* |sprintf(g->id,"%s%s%s",s1,gg->id,s2)| */
  Graph *g; /* graph whose |id| is to be set */
  char *s1; /* string for the beginning of the new |id| */
  Graph *gg; /* graph whose |id| is to be copied */
  char *s2; /* string for the end of the new |id| */
@y
void make_compound_id(@t\1\1@> /* |sprintf(g->id,"%s%s%s",s1,gg->id,s2)| */
  Graph *g, /* graph whose |id| is to be set */
  char *s1, /* string for the beginning of the new |id| */
  Graph *gg, /* graph whose |id| is to be copied */
  char *s2@t\2\2@>) /* string for the end of the new |id| */
@z

@x l.498
void make_double_compound_id(g,s1,gg,s2,ggg,s3)
              /* |sprintf(g->id,"%s%s%s%s%s",s1,gg->id,s2,ggg->id,s3)| */
  Graph *g; /* graph whose |id| is to be set */
  char *s1; /* string for the beginning of the new |id| */
  Graph *gg; /* first graph whose |id| is to be copied */
  char *s2; /* string for the middle of the new |id| */
  Graph *ggg; /* second graph whose |id| is to be copied */
  char *s3; /* string for the end of the new |id| */
@y
void make_double_compound_id(@t\1\1@>
    /* |sprintf(g->id,"%s%s%s%s%s",s1,gg->id,s2,ggg->id,s3)| */
  Graph *g, /* graph whose |id| is to be set */
  char *s1, /* string for the beginning of the new |id| */
  Graph *gg, /* first graph whose |id| is to be copied */
  char *s2, /* string for the middle of the new |id| */
  Graph *ggg, /* second graph whose |id| is to be copied */
  char *s3@t\2\2@>) /* string for the end of the new |id| */
@z

@x l.549
Arc *gb_virgin_arc()
@y
Arc *gb_virgin_arc(void)
@z

@x l.581
void gb_new_arc(u,v,len)
  Vertex *u, *v; /* a newly created arc will go from |u| to |v| */
  long len; /* its length */
@y
void gb_new_arc(@t\1\1@>
  Vertex *u,Vertex *v, /* a newly created arc will go from |u| to |v| */
  long len@t\2\2@>) /* its length */
@z

@x l.626
void gb_new_edge(u,v,len)
  Vertex *u, *v; /* new arcs will go from |u| to |v| and from |v| to |u| */
  long len; /* their length */
@y
void gb_new_edge(@t\1\1@>
  Vertex *u,Vertex *v, /* new arcs will go from |u| to |v| and from |v| to |u| */
  long len@t\2\2@>) /* their length */
@z

@x l.689
char *gb_save_string(s)
  register char *s; /* the string to be copied */
@y
char *gb_save_string(register char *s)
  /* the string to be copied */
@z

@x l.772
void switch_to_graph(g)
  Graph *g;
@y
void switch_to_graph(Graph *g)
@z

@x l.790
void gb_recycle(g)
  Graph *g;
@y
void gb_recycle(Graph *g)
@z

@x l.804
extern Graph*gb_new_graph(); /* create a new graph structure */
extern void gb_new_arc(); /* append an arc to the current graph */
extern Arc*gb_virgin_arc(); /* allocate a new |Arc| record */
extern void gb_new_edge(); /* append an edge (two arcs) to the current graph */
extern char*gb_save_string(); /* store a string in the current graph */
extern void switch_to_graph(); /* save allocation variables, swap in others */
extern void gb_recycle(); /* delete a graph structure */
@y
extern Graph*gb_new_graph(long);
   /* create a new graph structure */
extern void gb_new_arc(Vertex *,Vertex *,long);
   /* append an arc to the current graph */
extern Arc*gb_virgin_arc(void);
   /* allocate a new |Arc| record */
extern void gb_new_edge(Vertex *,Vertex *,long);
   /* append an edge (two arcs) to the current graph */
extern char*gb_save_string(register char *);
   /* store a string in the current graph */
extern void switch_to_graph(Graph *);
   /* save allocation variables, swap in others */
extern void gb_recycle(Graph *);
   /* delete a graph structure */
@z

@x l.839
extern void hash_in(); /* input a name to the hash table of current graph */
extern Vertex* hash_out(); /* find a name in hash table of current graph */
extern void hash_setup(); /* create a hash table for a given graph */
extern Vertex* hash_lookup(); /* find a name in a given graph */
@y
extern void hash_in(Vertex *); /* input a name to the hash table of current graph */
extern Vertex* hash_out(char *); /* find a name in hash table of current graph */
extern void hash_setup(Graph *); /* create a hash table for a given graph */
extern Vertex* hash_lookup(char *,Graph *); /* find a name in a given graph */
@z

@x l.855
void hash_in(v)
  Vertex *v;
@y
void hash_in(Vertex *v)
@z

@x l.898
Vertex* hash_out(s)
  char* s;
@y
Vertex* hash_out(char *s)
@z

@x l.909
void hash_setup(g)
  Graph *g;
@y
void hash_setup(Graph *g)
@z

@x l.924
Vertex* hash_lookup(s,g)
  char *s;
  Graph *g;
@y
Vertex* hash_lookup(char *s,Graph *g)
@z
