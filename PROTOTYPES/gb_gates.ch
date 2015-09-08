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

@x
register long k,r; /* all-purpose indices */
@y
register long k; /* all-purpose indices */
register unsigned long r; /* all-purpose indices */
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

@x
@ @d first_of(n,t) new_vert(t);@+for (k=1;k<n;k++)@+new_vert(t);
@y
@ @d first_of(n,t) new_vert(t);@+for (k=1;k<(long)n;k++)@+new_vert(t);
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

@x
  for (;k<n;k++) {
@y
  for (;k<(long)n;k++) {
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

@x
  register long k,r; /* general-purpose indices */
@y
  register long k; /* general-purpose indices */
  register unsigned long r; /* general-purpose indices */
@z

@x
  r=gate_eval(g,"0",NULL); /* reset the RISC by turning off the \.{RUN} bit */
  if (r<0) return r; /* not a valid gate graph! */
@y
  k=gate_eval(g,"0",NULL); /* reset the RISC by turning off the \.{RUN} bit */
  if (k<0) return k; /* not a valid gate graph! */
@z

@x
  for (r=0;r<trace_regs;r++) printf(" r%-2ld ",r); /* register names */
@y
  for (r=0;r<trace_regs;r++) printf(" r%-2lu ",r); /* register names */
@z

@x l.1097
static void pr_gate(v)
  Vertex *v;
@y
static void pr_gate(Vertex *v)
@z

@x l.1112
    printf(a->tip->name);
@y
    fputs(a->tip->name,stdout);
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

@x
while (k<m_plus_n) {
@y
while (k<(long)m_plus_n) {
@z

@x
for (j=0; j<m; j++) {
@y
for (j=0; j<(long)m; j++) {
@z

@x
  for (k=0; k<n; k++)
@y
  for (k=0; k<(long)n; k++)
@z

@x
  for (k=j+n; k<m_plus_n; k++) {
@y
  for (k=j+n; k<(long)m_plus_n; k++) {
@z

@x
@d a_pos(j) (j<m? j+1: m+5*((j-m)>>1)+3+(((j-m)&1)<<1))
@y
@d a_pos(j) ((unsigned long)(j)<m? (unsigned long)(j+1): m+5*((j-m)>>1)+3+(((j-m)&1)<<1))
@z

@x
for (j=0; j<m-2; j++) {
@y
for (j=0; j<(long)m-2; j++) {
@z

@x
  for (k=0; k<m_plus_n; k++)
@y
  for (k=0; k<(long)m_plus_n; k++)
@z

@x
  for (k=0; k<m_plus_n; k++)
@y
  for (k=0; k<(long)m_plus_n; k++)
@z

@x
  for (k=0; k<m_plus_n; k++)
@y
  for (k=0; k<(long)m_plus_n; k++)
@z

@x
  for (k=0; k<m_plus_n; k++)
@y
  for (k=0; k<(long)m_plus_n; k++)
@z

@x
  for (k=0; k<m_plus_n-1; k++)
@y
  for (k=0; k<(long)m_plus_n-1; k++)
@z

@x
for (k=0; k<m_plus_n; k++)
@y
for (k=0; k<(long)m_plus_n; k++)
@z

@x
for (k=0; k<m_plus_n; k++)
@y
for (k=0; k<(long)m_plus_n; k++)
@z

@x
for (i=3,j=2,k=3,l=3; l<=m_plus_n; l++) {
@y
for (i=3,j=2,k=3,l=3; l<=(long)m_plus_n; l++) {
@z

@x
for (k=2;k<m_plus_n;k++) {
@y
for (k=2;k<(long)m_plus_n;k++) {
@z

@x
for (k=0;k<m_plus_n;k++) {@+register Arc *a=gb_virgin_arc();
@y
for (k=0;k<(long)m_plus_n;k++) {@+register Arc *a=gb_virgin_arc();
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

@x
    case 'I': if ((gb_next_rand()>>15)>=prob) {
@y
    case 'I': if ((gb_next_rand()>>15)>=(long)prob) {
@z
