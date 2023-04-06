@x l.16
extern Graph *board(); /* moves on generalized chessboards */
extern Graph *simplex(); /* generalized triangular configurations */
extern Graph *subsets(); /* patterns of subset intersection */
extern Graph *perms(); /* permutations of a multiset */
extern Graph *parts(); /* partitions of an integer */
extern Graph *binary(); /* binary trees */
@#
extern Graph *complement(); /* the complement of a graph */
extern Graph *gunion(); /* the union of two graphs */
extern Graph *intersection(); /* the intersection of two graphs */
extern Graph *lines(); /* the line graph of a graph */
extern Graph *product(); /* the product of two graphs */
extern Graph *induced(); /* a graph induced from another */
@y
#ifndef GB_BASIC_H
#define GB_BASIC_H
@#
#include "gb_graph.h" /* we use the {\sc GB\_\,GRAPH} data structures */
@#
extern Graph *board(long,long,long,long,long,long,long);
   /* moves on generalized chessboards */
extern Graph *simplex(unsigned long,long,long,long,long,long,long);
   /* generalized triangular configurations */
extern Graph *subsets(unsigned long,long,long,long,long,long,unsigned long,long);
   /* patterns of subset intersection */
extern Graph *perms(long,long,long,long,long,unsigned long,long);
   /* permutations of a multiset */
extern Graph *parts(unsigned long,unsigned long,unsigned long,long);
   /* partitions of an integer */
extern Graph *binary(unsigned long,unsigned long,long);
   /* binary trees */
@#
extern Graph *complement(Graph *,long,long,long);
   /* the complement of a graph */
extern Graph *gunion(Graph *,Graph *,long,long);
   /* the union of two graphs */
extern Graph *intersection(Graph *,Graph *,long,long);
   /* the intersection of two graphs */
extern Graph *lines(Graph *,long);
   /* the line graph of a graph */
extern Graph *product(Graph *,Graph *,long,long);
   /* the product of two graphs */
extern Graph *induced(Graph *,char *,long,long,long);
   /* a graph induced from another */
@z

@x l.33
#include "gb_graph.h" /* we use the {\sc GB\_\,GRAPH} data structures */
@y
#include "gb_basic.h" /* we use our own interface first */
@z

@x l.176
Graph *board(n1,n2,n3,n4,piece,wrap,directed)
  long n1,n2,n3,n4; /* size of board desired */
  long piece; /* type of moves desired */
  long wrap; /* mask for coordinate positions that wrap around */
  long directed; /* should the graph be directed? */
@y
Graph *board(
  long n1,long n2,long n3,long n4, /* size of board desired */
  long piece, /* type of moves desired */
  long wrap, /* mask for coordinate positions that wrap around */
  long directed) /* should the graph be directed? */
@z

@x l.185
  @<Normalize the board-size parameters@>;
  @<Set up a graph with |n| vertices@>;
  @<Insert arcs or edges for all legal moves@>;
@y
  (void) s; (void) i;
  @<Normalize the board-size parameters@>@;
  @<Set up a graph with |n| vertices@>@;
  @<Insert arcs or edges for all legal moves@>@;
@z

@x l.410
    do yy[k]+=nn[k];@+ while (yy[k]<0);
@y
    do yy[k]+=nn[k]; while (yy[k]<0);
@z

@x l.413
    do yy[k]-=nn[k];@+ while (yy[k]>=nn[k]);
@y
    do yy[k]-=nn[k]; while (yy[k]>=nn[k]);
@z

@x l.493
Graph *simplex(n,n0,n1,n2,n3,n4,directed)
  unsigned long n; /* the constant sum of all coordinates */
  long n0,n1,n2,n3,n4; /* constraints on coordinates */
  long directed; /* should the graph be directed? */
@y
Graph *simplex(
  unsigned long n, /* the constant sum of all coordinates */
  long n0,long n1,long n2,long n3,long n4, /* constraints on coordinates */
  long directed) /* should the graph be directed? */
@z

@x l.512
  if (n0>n) n0=n;
@y
  if (n0>(long)n) n0=n;
@z

@x l.516
    if (n1>n) n1=n;
@y
    if (n1>(long)n) n1=n;
@z

@x l.520
      if (n2>n) n2=n;
@y
      if (n2>(long)n) n2=n;
@z

@x l.524
        if (n3>n) n3=n;
@y
        if (n3>(long)n) n3=n;
@z

@x l.527
        else {@+if (n4>n) n4=n;
@y
        else {@+if (n4>(long)n) n4=n;
@z

@x l.575
  for (k=1;k<=n;k++) {
@y
  for (k=1;k<=(long)n;k++) {
@z

@x l.603
if (yy[0]>=n) {
  k=0;@+xx[0]=(yy[1]>=n? 0: n-yy[1]);
@y
if (yy[0]>=(long)n) {
  k=0;@+xx[0]=(yy[1]>=(long)n? 0: n-yy[1]);
@z

@x l.732
Graph *subsets(n,n0,n1,n2,n3,n4,size_bits,directed)
  unsigned long n; /* the number of elements in the multiset */
  long n0,n1,n2,n3,n4; /* multiplicities of elements */
  unsigned long size_bits; /* intersection sizes that trigger arcs */
  long directed; /* should the graph be directed? */
@y
Graph *subsets(
  unsigned long n, /* the number of elements in the multiset */
  long n0,long n1,long n2,long n3,long n4, /* multiplicities of elements */
  unsigned long size_bits, /* intersection sizes that trigger arcs */
  long directed) /* should the graph be directed? */
@z

@x l.763
if (yy[0]>=n) {
  k=0;@+xx[0]=(yy[1]>=n? 0: n-yy[1]);
@y
if (yy[0]>=(long)n) {
  k=0;@+xx[0]=(yy[1]>=(long)n? 0: n-yy[1]);
@z

@x l.790
    long ss=0; /* the number of elements common to |u| and |v| */
@y
    unsigned long ss=0; /* the number of elements common to |u| and |v| */
@z

@x l.886
Graph *perms(n0,n1,n2,n3,n4,max_inv,directed)
  long n0,n1,n2,n3,n4; /* composition of the multiset */
  unsigned long max_inv; /* maximum number of inversions */
  long directed; /* should the graph be directed? */
@y
Graph *perms(
  long n0,long n1,long n2,long n3,long n4, /* composition of the multiset */
  unsigned long max_inv, /* maximum number of inversions */
  long directed) /* should the graph be directed? */
@z

@x l.915
{@+register long ss; /* max inversions known to be possible */
@y
{@+register unsigned long ss; /* max inversions known to be possible */
@z

@x l.940
  for (k=1,nverts=1;k<=max_inv;k++) {
@y
  for (k=1,nverts=1;k<=(long)max_inv;k++) {
@z

@x l.961
  for (i=k,ii=0;i<=max_inv;i++,ii++) {
@y
  for (i=k,ii=0;i<=(long)max_inv;i++,ii++) {
@z

@x l.1017
  if (m<max_inv && ytab[k]<k-1)
@y
  if (m<(long)max_inv && ytab[k]<k-1)
@z

@x l.1037
static char *short_imap="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\
abcdefghijklmnopqrstuvwxyz_^~&@@,;.:?!%#$+-*/|<=>()[]{}`'";
@y
static char *short_imap=
  "0123456789"@|
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"@|
  "abcdefghijklmnopqrstuvwxyz"@|
  "_^~&@@,;.:?!%#$+-*/|<=>()[]{}`'";
@z

@x l.1098
Graph *parts(n,max_parts,max_size,directed)
  unsigned long n; /* the number being partitioned */
  unsigned long max_parts; /* maximum number of parts */
  unsigned long max_size; /* maximum size of each part */ 
  long directed; /* should the graph be directed? */
@y
Graph *parts(
  unsigned long n, /* the number being partitioned */
  unsigned long max_parts, /* maximum number of parts */
  unsigned long max_size, /* maximum size of each part */ 
  long directed) /* should the graph be directed? */
@z

@x l.1127
  for (k=1;k<=max_parts;k++) {
@y
  for (k=1;k<=(long)max_parts;k++) {
@z

@x l.1129
    for (j=k,i=0;j<=n;i++,j++) {
@y
    for (j=k,i=0;j<=(long)n;i++,j++) {
@z

@x l.1207
if (d<max_parts) {
@y
if (d<(long)max_parts) {
@z

@x l.1290
Graph *binary(n,max_height,directed)
  unsigned long n; /* the number of internal nodes */
  unsigned long max_height; /* maximum height of a leaf */
  long directed; /* should the graph be directed? */
@y
Graph *binary(
  unsigned long n, /* the number of internal nodes */
  unsigned long max_height, /* maximum height of a leaf */
  long directed) /* should the graph be directed? */
@z

@x l.1328
    for (k=2;k<=n;k++) nn[k]=0;
    for (j=2;j<=max_height;j++)
@y
    for (k=2;k<=(long)n;k++) nn[k]=0;
    for (j=2;j<=(long)max_height;j++)
@z

@x l.1356
    for (j=2;j<=max_height;j++) {
@y
    for (j=2;j<=(long)max_height;j++) {
@z

@x l.1413
  if (ltab[0]>n) {
@y
  if (ltab[0]>(long)n) {
@z

@x l.1545
Graph *complement(g,copy,self,directed)
  Graph *g; /* graph to be complemented */
  long copy; /* should we double-complement? */
  long self; /* should we produce self-loops? */
  long directed; /* should the graph be directed? */
@y
Graph *complement(
  Graph *g, /* graph to be complemented */
  long copy, /* should we double-complement? */
  long self, /* should we produce self-loops? */
  long directed) /* should the graph be directed? */
@z

@x l.1555
  if (g==NULL) panic(missing_operand); /* where's |g|? */
@y
  (void) s; (void) d; (void) k; (void) j; (void) i;
  if (g==NULL) panic(missing_operand); /* where's |g|? */
@z

@x l.1642
Graph *gunion(g,gg,multi,directed)
  Graph *g,*gg; /* graphs to be united */
  long multi; /* should we reproduce multiple arcs? */
  long directed; /* should the graph be directed? */
@y
Graph *gunion(
  Graph *g,Graph *gg, /* graphs to be united */
  long multi, /* should we reproduce multiple arcs? */
  long directed) /* should the graph be directed? */
@z

@x l.1651
  if (g==NULL || gg==NULL) panic(missing_operand);
    /* where are |g| and |gg|? */
@y
  (void) s; (void) d; (void) k; (void) j; (void) i;
  if (g==NULL || gg==NULL) panic(missing_operand);
    /* where are |g| and |gg|? */
@z

@x l.1723
Graph *intersection(g,gg,multi,directed)
  Graph *g,*gg; /* graphs to be intersected */
  long multi; /* should we reproduce multiple arcs? */
  long directed; /* should the graph be directed? */
@y
Graph *intersection(
  Graph *g,Graph *gg, /* graphs to be intersected */
  long multi, /* should we reproduce multiple arcs? */
  long directed) /* should the graph be directed? */
@z

@x l.1732
  if (g==NULL || gg==NULL) panic(missing_operand); /* where are |g| and |gg|? */
@y
  (void) s; (void) d; (void) k; (void) j; (void) i;
  if (g==NULL || gg==NULL) panic(missing_operand); /* where are |g| and |gg|? */
@z

@x l.1836
Graph *lines(g,directed)
  Graph *g; /* graph whose lines will become vertices */
  long directed; /* should the graph be directed? */
@y
Graph *lines(
  Graph *g, /* graph whose lines will become vertices */
  long directed) /* should the graph be directed? */
@z

@x l.1843
  if (g==NULL) panic(missing_operand); /* where is |g|? */
@y
  (void) s; (void) d; (void) k; (void) j; (void) i;
  if (g==NULL) panic(missing_operand); /* where is |g|? */
@z

@x l.1948
    do@+{gb_new_arc(u,v,1L);
@y
    do {gb_new_arc(u,v,1L);
@z

@x l.1950
    }@+while (v->u.V==u->v.V);
@y
    } while (v->u.V==u->v.V);
@z

@x l.2005
@(gb_basic.h@>=
#define cartesian 0
#define direct 1
#define strong 2
@y
@d cartesian 0
@d direct 1
@d strong 2
@z

@x l.2010
Graph *product(g,gg,type,directed)
  Graph *g,*gg; /* graphs to be multiplied */
  long type; /* |cartesian|, |direct|, or |strong| */
  long directed; /* should the graph be directed? */
@y
Graph *product(
  Graph *g,Graph *gg, /* graphs to be multiplied */
  long type, /* |cartesian|, |direct|, or |strong| */
  long directed) /* should the graph be directed? */
@z

@x l.2018
  if (g==NULL || gg==NULL) panic(missing_operand); /* where are |g| and |gg|? */
@y
  (void) s; (void) d; (void) k; (void) j; (void) i;
  if (g==NULL || gg==NULL) panic(missing_operand); /* where are |g| and |gg|? */
@z

@x l.2161
@d ind z.I

@(gb_basic.h@>=
#define ind @[z.I /* utility field |z| when used to induce a graph */@]
@y
@d ind z.I /* utility field |z| when used to induce a graph */@]
@z

@x l.2170
Graph *bi_complete(n1,n2,directed)
  unsigned long n1; /* size of first part */
  unsigned long n2; /* size of second part */
  long directed; /* should all arcs go from first part to second? */
@y
Graph *bi_complete(
  unsigned long n1, /* size of first part */
  unsigned long n2, /* size of second part */
  long directed) /* should all arcs go from first part to second? */
@z

@x l.2213
@(gb_basic.h@>=
#define IND_GRAPH 1000000000
#define subst @[y.G@]

@y
@z

@x l.2223
Graph *wheel(n,n1,directed)
  unsigned long n; /* size of the rim */
  unsigned long n1; /* number of center points */
  long directed; /* should all arcs go from center to rim and around? */
@y
Graph *wheel(
  unsigned long n, /* size of the rim */
  unsigned long n1, /* number of center points */
  long directed) /* should all arcs go from center to rim and around? */
@z

@x l.2244
extern Graph *bi_complete();
extern Graph *wheel(); /* standard applications of |induced| */
@y
extern Graph *bi_complete(unsigned long,unsigned long,long);
extern Graph *wheel(unsigned long,unsigned long,long);
   /* standard applications of |induced| */
@#
#endif /* |GB_BASIC_H| */
@z

@x l.2248
Graph *induced(g,description,self,multi,directed)
  Graph *g; /* graph marked for induction in its |ind| fields */
  char *description; /* string to be mentioned in |new_graph->id| */
  long self; /* should self-loops be permitted? */
  long multi; /* should multiple arcs be permitted? */
  long directed; /* should the graph be directed? */
@y
Graph *induced(
  Graph *g, /* graph marked for induction in its |ind| fields */
  char *description, /* string to be mentioned in |new_graph->id| */
  long self, /* should self-loops be permitted? */
  long multi, /* should multiple arcs be permitted? */
  long directed) /* should the graph be directed? */
@z

@x l.2259
  if (g==NULL) panic(missing_operand); /* where is |g|? */
@y
  (void) s; (void) d; (void) i;
  if (g==NULL) panic(missing_operand); /* where is |g|? */
@z
