@x l.26
#define print_gates p_gates /* abbreviation for Procrustean linkers */
extern Graph *risc(); /* make a network for a microprocessor */
extern Graph *prod(); /* make a network for high-speed multiplication */
extern void print_gates(); /* write a network to standard output file */
extern long gate_eval(); /* evaluate a network */
extern Graph *partial_gates(); /* reduce network size */
extern long run_risc(); /* simulate the microprocessor */
@y
#ifndef GB_GATES_H
#define GB_GATES_H
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
#define print_gates p_gates /* abbreviation for Procrustean linkers */
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

@x l.87
@d val x.I /* the field containing a boolean value */
@d typ y.I /* the field containing the gate type */
@d alt z.V /* the field pointing to another related gate */
@d outs zz.A /* the field pointing to the list of output gates */
@d is_boolean(v) ((unsigned long)(v)<=1) /* is a |tip| field constant? */
@d the_boolean(v) ((long)(v)) /* if so, this is its value */
@d tip_value(v) (is_boolean(v)? the_boolean(v): (v)->val)
@d AND '&'
@d OR '|'
@d NOT '~'
@d XOR '^'

@y
@z

@x l.100
#define val @t\quad@> x.I /* the definitions are repeated in the header file */
#define typ @t\quad@> y.I
#define alt @t\quad@> z.V
#define outs @t\quad@> zz.A
#define is_boolean(v) @t\quad@> ((unsigned long)(v)<=1)
#define the_boolean(v) @t\quad@> ((long)(v))
#define tip_value(v) @t\quad@> (is_boolean(v)? the_boolean(v): (v)->val)
#define AND @t\quad@> '&'
#define OR @t\quad@> '|'
#define NOT @t\quad@> '~'
#define XOR @t\quad@> '^'
@y
#define val @t\quad@> x.I /* the field containing a boolean value */
#define typ @t\quad@> y.I /* the field containing the gate type */
#define alt @t\quad@> z.V /* the field pointing to another related gate */
#define outs @t\quad@> zz.A /* the field pointing to the list of output gates */
#define is_boolean(v) @t\quad@> ((unsigned long)(v)<=1) /* is a |tip| field constant? */
#define the_boolean(v) @t\quad@> ((long)(v)) /* if so, this is its value */
#define tip_value(v) @t\quad@> (is_boolean(v)? the_boolean(v): (v)->val)
#define AND @t\quad@> '&'
#define OR @t\quad@> '|'
#define NOT @t\quad@> '~'
#define XOR @t\quad@> '^'
@#
#endif /* |GB_GATES_H| */
@z

@x l.130
long gate_eval(g,in_vec,out_vec)
  Graph *g; /* graph with gates as vertices */
  char *in_vec; /* string for input values, or |NULL| */
  char *out_vec; /* string for output values, or |NULL| */
@y
long gate_eval(
  Graph *g, /* graph with gates as vertices */
  char *in_vec, /* string for input values, or |NULL| */
  char *out_vec) /* string for output values, or |NULL| */
@z

@x l.184
#include "gb_flip.h"
 /* we will use the {\sc GB\_\,FLIP} routines for random numbers */
#include "gb_graph.h"
 /* and we will use the {\sc GB\_\,GRAPH} data structures */
@y
#include "gb_gates.h" /* we use our own interface first */
#include "gb_flip.h"
 /* we will use the {\sc GB\_\,FLIP} routines for random numbers */
@z

@x l.215
Graph *risc(regs)
  unsigned long regs; /* number of registers supported */
@y
Graph *risc(
  unsigned long regs) /* number of registers supported */
@z

@x l.230
register long k,r; /* all-purpose indices */
@y
register long k; /* all-purpose indices */
register unsigned long r; /* all-purpose indices */
@z

@x l.412
static Vertex* new_vert(t)
  char t; /* the type of the new gate */
@y
static Vertex* new_vert(
  char t) /* the type of the new gate */
@z

@x l.427
@d numeric_prefix(a,b) sprintf(prefix,"%c%ld:",a,b);@+count=0;
@y
@d numeric_prefix(a,b) sprintf(prefix,"%c%ld:",a,(b)&0xffff);@+count=0;
@z

@x l.445
static Vertex* make2(t,v1,v2)
  char t; /* the type of the new gate */
  Vertex *v1,*v2;
@y
static Vertex* make2(
  char t, /* the type of the new gate */
  Vertex *v1,Vertex *v2)
@z

@x l.454
static Vertex* make3(t,v1,v2,v3)
  char t; /* the type of the new gate */
  Vertex *v1,*v2,*v3;
@y
static Vertex* make3(
  char t, /* the type of the new gate */
  Vertex *v1,Vertex *v2,Vertex *v3)
@z

@x l.464
static Vertex* make4(t,v1,v2,v3,v4)
  char t; /* the type of the new gate */
  Vertex *v1,*v2,*v3,*v4;
@y
static Vertex* make4(
  char t, /* the type of the new gate */
  Vertex *v1,Vertex *v2,Vertex *v3,Vertex *v4)
@z

@x l.475
static Vertex* make5(t,v1,v2,v3,v4,v5)
  char t; /* the type of the new gate */
  Vertex *v1,*v2,*v3,*v4,*v5;
@y
static Vertex* make5(
  char t, /* the type of the new gate */
  Vertex *v1,Vertex *v2,Vertex *v3,Vertex *v4,Vertex *v5)
@z

@x l.496
static Vertex* comp(v)
  Vertex *v;
@y
static Vertex* comp(
  Vertex *v)
@z

@x l.514
static Vertex* make_xor(u,v)
  Vertex *u,*v;
@y
static Vertex* make_xor(
  Vertex *u,Vertex *v)
@z

@x l.558
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
static void make_adder(
  unsigned long n, /* number of bits */
  Vertex *x[],Vertex *y[], /* input gates */
  Vertex *z[], /* output gates */
  Vertex *carry, /* add this to |y|, unless it's null */
  char add) /* should we add or subtract? */
@z

@x l.889
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
long run_risc(
  Graph *g, /* graph output by |risc| */
  unsigned long rom[], /* contents of read-only memory */
  unsigned long size, /* length of |rom| vector */
  unsigned long trace_regs)
    /* if nonzero, this many registers will be traced */
@z

@x l.1001
  register long k,r; /* general-purpose indices */
@y
  register long k; /* general-purpose indices */
  register unsigned long r; /* general-purpose indices */
@z

@x l.1004
  r=gate_eval(g,"0",NULL); /* reset the RISC by turning off the \.{RUN} bit */
  if (r<0) return r; /* not a valid gate graph! */
@y
  k=gate_eval(g,"0",NULL); /* reset the RISC by turning off the \.{RUN} bit */
  if (k<0) return k; /* not a valid gate graph! */
@z

@x l.1025
  for (r=0;r<trace_regs;r++) printf(" r%-2ld ",r); /* register names */
@y
  for (r=0;r<trace_regs;r++) printf(" r%-2lu ",r); /* register names */
@z

@x l.1094
@d print_gates p_gates /* abbreviation makes chopped-off name unique */
@y
@z

@x l.1097
static void pr_gate(v)
  Vertex *v;
@y
static void pr_gate(
  Vertex *v)
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
void print_gates(
  Graph *g)
@z

@x l.1127
@ @(gb_gates.h@>=
#define bit @t\quad@> z.I
@y
@ (This section remains empty for historic reasons.)
@z

@x l.1146
static Graph* reduce(g)
  Graph *g;
@y
static Graph* reduce(
  Graph *g)
@z

@x l.1365
  do@+{
@y
  do {
@z

@x l.1383
  }@+while (v!=sentinel);
@y
  } while (v!=sentinel);
@z

@x l.1487
Graph* prod(m,n)
  unsigned long m,n; /* lengths of the binary numbers to be multiplied */
@y
Graph* prod(unsigned long m,unsigned long n)
  /* lengths of the binary numbers to be multiplied */
@z

@x l.1545
while (k<m_plus_n) {
@y
while (k<(long)m_plus_n) {
@z

@x l.1614
for (j=0; j<m; j++) {
@y
for (j=0; j<(long)m; j++) {
@z

@x l.1619
  for (k=0; k<n; k++)
@y
  for (k=0; k<(long)n; k++)
@z

@x l.1621
  for (k=j+n; k<m_plus_n; k++) {
@y
  for (k=j+n; k<(long)m_plus_n; k++) {
@z

@x l.1629
@d a_pos(j) (j<m? j+1: m+5*((j-m)>>1)+3+(((j-m)&1)<<1))
@y
@d a_pos(j) ((unsigned long)(j)<m? (unsigned long)(j+1): m+5*((j-m)>>1)+3+(((j-m)&1)<<1))
@z

@x l.1632
for (j=0; j<m-2; j++) {
@y
for (j=0; j<(long)m-2; j++) {
@z

@x l.1636
  for (k=0; k<m_plus_n; k++)
@y
  for (k=0; k<(long)m_plus_n; k++)
@z

@x l.1639
  for (k=0; k<m_plus_n; k++)
@y
  for (k=0; k<(long)m_plus_n; k++)
@z

@x l.1644
  for (k=0; k<m_plus_n; k++)
@y
  for (k=0; k<(long)m_plus_n; k++)
@z

@x l.1647
  for (k=0; k<m_plus_n; k++)
@y
  for (k=0; k<(long)m_plus_n; k++)
@z

@x l.1653
  for (k=0; k<m_plus_n-1; k++)
@y
  for (k=0; k<(long)m_plus_n-1; k++)
@z

@x l.1665
for (k=0; k<m_plus_n; k++)
@y
for (k=0; k<(long)m_plus_n; k++)
@z

@x l.1668
for (k=0; k<m_plus_n; k++)
@y
for (k=0; k<(long)m_plus_n; k++)
@z

@x l.1756
for (i=3,j=2,k=3,l=3; l<=m_plus_n; l++) {
@y
for (i=3,j=2,k=3,l=3; l<=(long)m_plus_n; l++) {
@z

@x l.1782
for (k=2;k<m_plus_n;k++) {
@y
for (k=2;k<(long)m_plus_n;k++) {
@z

@x l.1846
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
Graph *partial_gates(
  Graph *g, /* generalized gate graph */
  unsigned long r, /* the number of initial gates to leave untouched */
  unsigned long prob,
    /* scaled probability of not touching subsequent input gates */
  long seed, /* seed value for random number generation */
  char *buf)
    /* optional parameter for information about partial assignment */
@z

@x l.1910
    case 'I': if ((gb_next_rand()>>15)>=prob) {
@y
    case 'I': if ((gb_next_rand()>>15)>=(long)prob) {
@z
