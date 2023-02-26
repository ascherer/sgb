@x l.27
extern Graph *risc(); /* make a network for a microprocessor */
extern Graph *prod(); /* make a network for high-speed multiplication */
extern void print_gates(); /* write a network to standard output file */
extern long gate_eval(); /* evaluate a network */
extern Graph *partial_gates(); /* reduce network size */
extern long run_risc(); /* simulate the microprocessor */
@y
extern Graph *risc(unsigned long);
   /* make a network for a microprocessor */
extern Graph *prod(unsigned long,unsigned long);
   /* make a network for high-speed multiplication */
extern void print_gates(Graph *);
   /* write a network to standard output file */
extern long gate_eval(Graph *,char *,char *);
   /* evaluate a network */
extern Graph *partial_gates(Graph *,unsigned long,unsigned long,long,char *);
   /* reduce network size */
extern long run_risc(Graph *,unsigned long [],unsigned long,unsigned long);
   /* simulate the microprocessor */
@z

@x l.130
long gate_eval(g,in_vec,out_vec)
  Graph *g; /* graph with gates as vertices */
  char *in_vec; /* string for input values, or |NULL| */
  char *out_vec; /* string for output values, or |NULL| */
@y
long gate_eval(@t\1\1@>
  Graph *g, /* graph with gates as vertices */
  char *in_vec, /* string for input values, or |NULL| */
  char *out_vec@t\2\2@>) /* string for output values, or |NULL| */
@z

@x l.215
Graph *risc(regs)
  unsigned long regs; /* number of registers supported */
@y
Graph *risc(unsigned long regs)
  /* number of registers supported */
@z

@x l.412
static Vertex* new_vert(t)
  char t; /* the type of the new gate */
@y
static Vertex* new_vert(char t)
  /* the type of the new gate */
@z

@x l.445
static Vertex* make2(t,v1,v2)
  char t; /* the type of the new gate */
  Vertex *v1,*v2;
@y
static Vertex* make2(@t\1\1@>
  char t, /* the type of the new gate */
  Vertex *v1,Vertex *v2@t\2\2@>)
@z

@x l.454
static Vertex* make3(t,v1,v2,v3)
  char t; /* the type of the new gate */
  Vertex *v1,*v2,*v3;
@y
static Vertex* make3(@t\1\1@>
  char t, /* the type of the new gate */
  Vertex *v1,Vertex *v2,Vertex *v3@t\2\2@>)
@z

@x l.464
static Vertex* make4(t,v1,v2,v3,v4)
  char t; /* the type of the new gate */
  Vertex *v1,*v2,*v3,*v4;
@y
static Vertex* make4(@t\1\1@>
  char t, /* the type of the new gate */
  Vertex *v1,Vertex *v2,Vertex *v3,Vertex *v4@t\2\2@>)
@z

@x l.475
static Vertex* make5(t,v1,v2,v3,v4,v5)
  char t; /* the type of the new gate */
  Vertex *v1,*v2,*v3,*v4,*v5;
@y
static Vertex* make5(@t\1\1@>
  char t, /* the type of the new gate */
  Vertex *v1,Vertex *v2,Vertex *v3,Vertex *v4,Vertex *v5@t\2\2@>)
@z

@x l.496
static Vertex* comp(v)
  Vertex *v;
@y
static Vertex* comp(Vertex *v)
@z

@x l.514
static Vertex* make_xor(u,v)
  Vertex *u,*v;
@y
static Vertex* make_xor(Vertex *u,Vertex *v)
@z

@x l.876
static void make_adder(n,x,y,z,carry,add)
  unsigned long n; /* number of bits */
  Vertex *x[],*y[]; /* input gates */
  Vertex *z[]; /* output gates */
  Vertex *carry; /* add this to |y|, unless it's null */
  char add; /* should we add or subtract? */
@y
static void make_adder(@t\1\1@>
  unsigned long n, /* number of bits */
  Vertex *x[],Vertex *y[], /* input gates */
  Vertex *z[], /* output gates */
  Vertex *carry, /* add this to |y|, unless it's null */
  char add@t\2\2@>) /* should we add or subtract? */
@z

@x l.992
long run_risc(g,rom,size,trace_regs)
  Graph *g; /* graph output by |risc| */
  unsigned long rom[]; /* contents of read-only memory */
  unsigned long size; /* length of |rom| vector */
  unsigned long trace_regs; /* if nonzero, this many registers will be traced */
@y
long run_risc(@t\1\1@>
  Graph *g, /* graph output by |risc| */
  unsigned long rom[], /* contents of read-only memory */
  unsigned long size, /* length of |rom| vector */
  unsigned long trace_regs@t\2\2@>)
    /* if nonzero, this many registers will be traced */
@z

@x l.1097
static void pr_gate(v)
  Vertex *v;
@y
static void pr_gate(Vertex *v)
@z

@x l.1117
void print_gates(g)
  Graph *g;
@y
void print_gates(Graph *g)
@z

@x l.1146
static Graph* reduce(g)
  Graph *g;
@y
static Graph* reduce(Graph *g)
@z

@x l.1487
Graph* prod(m,n)
  unsigned long m,n; /* lengths of the binary numbers to be multiplied */
@y
Graph* prod(unsigned long m,unsigned long n)
  /* lengths of the binary numbers to be multiplied */
@z

@x l.1897
Graph *partial_gates(g,r,prob,seed,buf)
  Graph *g; /* generalized gate graph */
  unsigned long r; /* the number of initial gates to leave untouched */
  unsigned long prob;
   /* scaled probability of not touching subsequent input gates */
  long seed; /* seed value for random number generation */
  char *buf; /* optional parameter for information about partial assignment */
@y
Graph *partial_gates(@t\1\1@>
  Graph *g, /* generalized gate graph */
  unsigned long r, /* the number of initial gates to leave untouched */
  unsigned long prob,
    /* scaled probability of not touching subsequent input gates */
  long seed, /* seed value for random number generation */
  char *buf@t\2\2@>)
    /* optional parameter for information about partial assignment */
@z
