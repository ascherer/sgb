% This file is part of the St588anford GraphBase (c) Stanford University 1992
\def\title{GB\_\thinspace GRAPH}
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!

@* Introduction. This is |gb_graph|, the data-structure module used by all
GraphBase routines to allocate memory. The basic data types for graph
representation are also defined here.

Many examples of how to use these conventions appear in other GraphBase
modules. The best introduction to such examples can probably be found
in |gb_basic|, which contains subroutines for generating and transforming
various classical graphs.

@ The code below is believed to be system-independent; it should
produce equivalent results on all systems, assuming that the standard
|calloc| and |cfree| functions of \Cee\ are available.

However, a test program helps build confidence that everything does in fact
work as it should. To make such a test, simply compile and run |test_graph|.
This particular test is fairly rudimentary, but it should be passed before
more elaborate routines are tested.

@(test_graph.c@>=
#include "gb_graph.h"  /* all users of |gb_graph| should do this */
@<Declarations of test variables@>@;
@#
main()
{
  @<Create a small graph@>;
  @<Test some intentional errors@>;
  @<Check that the small graph is still there@>;
  printf("OK, the gb_graph routines seem to work!\n");
}

@ The \Cee\ code for |gb_graph| doesn't have a main routine; it's just a
bunch of subroutines to be incorporated into programs at a higher level,
via the system loading routine. Here is the general outline of \.{gb\_graph.c}:

@p
#include <stdio.h>
#ifdef SYSV
#include <string.h>
#else
#include <strings.h>
#endif
@<Type declarations@>@;
@<Private declarations@>@;
@<External declarations@>@;
@<External functions@>

@ The type declarations of |gb_graph| appear also in the header file
\.{gb\_graph.h}. For convenience, that header file also incorporates the
standard system headers for input/output and string manipulation.

@(gb_graph.h@>=
#include <stdio.h>
#ifdef SYSV
#include <string.h>
#else
#include <strings.h>
#endif
@<Type declarations@>@;

@ GraphBase programs often have a ``verbose'' option, which needs to
be enabled by the setting of an external variable. They also tend to have
a variable called |panic_code|, which helps identify unusual errors.
We might as well declare those variables here.

@<External d...@>=
int verbose=0; /* nonzero if ``verbose'' output is desired */
int panic_code=0; /* set nonzero if graph generator returns null pointer */

@ Every external variable should be declared twice in this \.{CWEB} file;
once for |gb_graph| itself (the ``real'' declaration for storage allocation
purposes), and once in \.{gb\_graph.h} (for cross-references by
|gb_graph| users).

@(gb_graph.h@>=
extern int verbose; /* nonzero if ``verbose'' output is desired */
extern int panic_code; /* set nonzero if graph generator panics */

@ When |panic_code| is assigned a nonzero value, one of the symbolic
names defined here is used to help pinpoint the problem.
Small values indicate memory limitations; values in the 10s and 20s
indicate input/output anomalies; values in the 30s and 40s indicate
errors in the parameters to a subroutine. Some panic codes
stand for cases the author doesn't think will ever arise, although
the program checks for them just to be extra safe. Multiple instances
of the same type of error within a single subroutine are distinguished
by adding an integer; for example, `|syntax_error+1|' and `|syntax_error+2|'
identify two different kinds of syntax error, as an aid in trouble-shooting.
The |early_data_fault| and |late_data_fault| codes are explained further
by the value of |io_errors|.

@(gb_graph.h@>=
#define alloc_fault -1 /* a previous memory request failed */
#define no_room 1 /* the current memory request failed */
#define early_data_fault 10 /* error detected at beginning of \.{.dat} file */
#define late_data_fault 11 /* error detected at end of \.{.dat} file */
#define syntax_error 20 /* error detected while reading \.{.dat} file */
#define bad_specs 30 /* parameter out of range or otherwise disallowed */
#define very_bad_specs 40 /* parameter far out of range or otherwise stupid */
#define missing_operand 50 /* graph parameter is |NULL| */
#define invalid_operand 60 /* graph parameter doesn't obey assumptions */
#define impossible 666 /* ``this can't happen'' */

@* Representation of graphs. The GraphBase programs employ a simple and flexible
set of data structures to represent and manipulate graphs in computer memory.
Vertices appear in a sequential array of \&{Vertex} records, and the arcs
emanating from each vertex appear in a linked list of \&{Arc} records. There
is also a \&{Graph} record, to provide information about the graph as a whole.

The structure layouts for \&{Vertex}, \&{Arc}, and \&{Graph} records
include a number of utility fields that can be used for any purpose by
algorithms that manipulate the graphs. Each utility field is a union
type that can be either a pointer of various kinds or a (long) integer.

Let's begin the formal definition of these data structures by declaring the
union type \&{util}. The suffixes .|v|, .|a|, .|g|, and .|s| on the name
of a utility variable will mean that it is a pointer to a vertex, arc,
graph, or string, respectively; the suffix .|i| will mean that it is
an integer. (We use one-character names because such names are easy to type
when debugging.)

@<Type dec...@>=
typedef union {
  struct vertex_struct *v; /* pointer to \&{Vertex} */
  struct arc_struct *a; /* pointer to \&{Arc} */
  struct graph_struct *g; /* pointer to \&{Graph} */
  char *s; /* pointer to string */
  long i; /* integer */
} util;

@ Each \&{Vertex} has two standard fields and six utility fields; hence it
occupies 32 bytes on most systems, not counting the memory needed for
supplementary string data. The standard fields are
$$\vcenter{\halign{#,\ \ \hfil&#\hfil\cr
|arcs|&a pointer to an \&{Arc};\cr
|name|&a pointer to a string of characters.\cr}}$$
If |v| points to a \&{Vertex} and |v->arcs| is |NULL|, there are no arcs
emanating from~|v|. But if |v->arcs| is non-|NULL|, it points to an \&{Arc}
record representing an arc from~|v|, and that record has a |next| field that
points in the same way to the representations of all other arcs from~|v|.

The utility fields are called |u|, |v|, |w|, |x|, |y|, |z|. Macros can
be used to give them syntactic sugar in particular applications. They are
typically used to record such things as the in-degree or out-degree, or
whether a vertex is `marked'; or they link the vertex to other vertices in
one or more lists.

@<Type dec...@>=
typedef struct vertex_struct {
  struct arc_struct *arcs; /* linked list of arcs coming out of this vertex */
  char *name; /* string identifying this vertex symbolically */
  util u,v,w,x,y,z; /* multipurpose fields */
} Vertex;

@ Each \&{Arc} has three standard fields and two utility fields. Thus it
occupies 20~bytes on most computer systems. The standard fields are
$$\vcenter{\halign{#,\ \ \hfil&#\hfil\cr
|tip|&a pointer to a |Vertex|;\cr
|next|&a pointer to an \&{Arc};\cr
|len|&a (long) integer.\cr}}$$
If |a| points to an \&{Arc} in the list of arcs from vertex~|v|, it represents
an arc of length |a->len| from |v| to |a->tip|, and the next arc from |v|
in the list is represented by |a->next|.

The utility fields are called |a| and |b|.

@<Type dec...@>=
typedef struct arc_struct {
  struct vertex_struct *tip; /* the arc points to this vertex */
  struct arc_struct *next; /* another arc pointing from the same vertex */
  long len; /* length of this arc */
  util a,b; /* multipurpose fields */
} Arc;

@* Storage allocation. Memory space must be set aside dynamically for
vertices, arcs, and their attributes. The GraphBase routines provided by
|gb_graph| accomplish this task with reasonable ease and efficiency
by using the concept of memory ``areas.'' The user should first declare an
\&{Area} variable by saying, for example,
$$\hbox{\&{Area} |s|;}$$
and if this variable isn't static or otherwise known to be zero, it must be
cleared initially by saying `|init_area(s)|'. Then any number of subroutine
calls of the form  `|gb_alloc(n,s)|' can be given; |gb_alloc|
will return a pointer to a block of |n| consecutive bytes, all cleared to zero.
Finally, the user can issue the statement
$$\hbox{|gb_free(s)|;}$$
this will return all memory blocks currently allocated to area~|s|, making them
available for future allocation.

The number of bytes |n| specified to |gb_alloc| must be positive, and
it should usually be 1000 or more, since this will reduce the number
of system calls. Other routines are provided below to allocate smaller
amounts of memory, such as the space needed for a single new \&{Arc}.

If no memory of the requested size is presently available, |gb_alloc|
returns the null pointer |NULL|. In such cases |gb_alloc| also sets
the external variable |gb_alloc_trouble| to a nonzero value. The user
can therefore discover whether any one of an arbitrarily long series
of allocation requests has failed by making a single test, `|if
(gb_alloc_trouble)|'. The value of |gb_alloc_trouble| should be cleared to zero
by every graph generation subroutine; therefore it need not be
initialized to zero.

A special macro |gb_alloc_type(n,t,s)| makes it convenient to allocate
the space for |n| items of type~|t| in area~|s|.

@d gb_alloc_type(n,t,s) @[(t*)@]gb_alloc((n)*@[sizeof@](t),s)

@ The implementation of this scheme is almost ridiculously easy. The
value of~|n| is increased by twice the number of bytes in a pointer,
and the resulting number is rounded upwards if necessary so that it's
a multiple of 256. Then memory is allocated using |calloc|.  The extra
bytes will contain two pointers, one to the beginning of the block and
one to the next block associated with the same area variable.

The \&{Area} type is defined to be an array of length 1. This makes it possible
for users to say just `|s|' instead of `|&s|' when using an area
variable as a parameter.

@<Type...@>=
#define init_area(s) @t\quad@> @[*s=NULL@]
struct area_pointers {
  char *first; /* address of the beginning of this block */
  struct area_pointers *next; /* address of area pointers in previously
        allocated block */
};

typedef struct area_pointers *Area[1];

@ First we round |n| up, if necessary, so that it's a multiple of the
size of a pointer variable. Then we know we can put |area_pointers| into
memory at a position |n| after any address returned by |calloc|. (This
logic should work whenever the number of bytes in a pointer variable
is a divisor of~256.)

The upper limit on |n| here is governed by old \Cee\ conventions in
which the first parameter to |calloc| must be less than~$2^{16}$.
Users who need graphs with more than half a million vertices might
want to raise this limit on their systems, but they would probably
be better off representing large graphs in a more compact way.
@^system dependencies@>

@<External fun...@>=
char *gb_alloc(n,s)
  long n; /* number of consecutive bytes desired */
  Area s; /* storage area that will contain the new block */
{@+int m=sizeof(char *); /* |m| is the size of a pointer variable */
  Area t; /* a temporary pointer */
  char *loc; /* the block address */
  if (n<=0 || n>0xffff00 -2*m) {
    gb_alloc_trouble|=2; /* illegal request */
    return NULL;
  }
  n=((n+m-1)/m)*m; /* round up to multiple of |m| */
  loc=(char*)calloc((unsigned)((n+2*m+255)/256),256);
  if (loc) {
    *t=(struct area_pointers*)(loc+n);
    (*t)->first=loc;
    (*t)->next=*s;
    *s=*t;
  } else gb_alloc_trouble|=1;
  return loc;
}

@ @<External d...@>=
int gb_alloc_trouble=0; /* did |gb_alloc| return |NULL|? */

@ @(gb_graph.h@>=
extern int gb_alloc_trouble; /* anomalies noted by |gb_alloc| */

@ Notice that |gb_free(s)| can be called twice in a row, because the list
of blocks is cleared out of the area variable~|s|.

@<External fun...@>=
void gb_free(s)
  Area s;
{@+Area t;
  while (*s) {
    *t=(*s)->next;
    cfree((*s)->first);
    *s=*t;
  }
}

@ The two external procedures we've defined above should be mentioned in
the header file, so let's do that before we forget.

@(gb_graph.h@>=
extern char *gb_alloc(); /* allocate another block for an area */
#define gb_alloc_type(n,t,s) @[@t\quad@>@[(t*)@]gb_alloc((n)*@[sizeof@](t),s)@]
extern void gb_free(); /* deallocate all blocks for an area */

@ Here we try to allocate 10 million bytes of memory. If we succeed,
fine; if not, we verify that the error was properly reported.

(An early draft of this program attempted to allocate memory until
it was exhausted. That tactic provided a more thorough test, but it
was a bad idea because it brought certain large systems to their
knees; it was terribly unfriendly to other users who were innocently
trying to do their own work on the same machine.)

@<Test some intentional errors@>=
if (gb_alloc(0,s)!=NULL || gb_alloc_trouble!=2) {
  fprintf(stderr,"Allocation error 2 wasn't reported properly!\n");
  return -2;
}
for (;g->v.i<100;g->v.i++) if (gb_alloc(100000,s)) g->u.i++;
if (g->u.i<100 && gb_alloc_trouble!=3) {
  fprintf(stderr,"Allocation error 1 wasn't reported properly!\n");
  return -1;
}
gb_free(s); /* we've exhausted memory, let's put some back */
printf("Hey, I allocated %d00000 bytes successfully. Terrific...\n",g->u.i);

gb_alloc_trouble=0;

@ @<Decl...@>=
Area s; /* temporary allocations in the test routine */

@*Growing a graph. Now we're ready to look at the \&{Graph} type. This is
a data structure that can be passed to an algorithm that operates on
graphs---to find minimum spanning trees, or strong components, or whatever.

A \&{Graph} record has seven standard fields and six utility fields. The
standard fields are
$$\vcenter{\halign{#,\ \ \hfil&#\hfil\cr
|vertices|&a pointer to an array of |Vertex| records;\cr
|n|&the total number of vertices;\cr
|m|&the total number of arcs;\cr
|id|&a symbolic identification giving parameters of the GraphBase procedure\cr
\omit& that generated this graph;\cr
|format|&a symbolic representation of the data types in utility fields;\cr
|data|&an |Area| used for |Arc| storage and string storage;\cr
|aux_data|&an |Area| used for auxiliary information that some users may\cr
\omit     &wish to discard.\cr}}$$
The utility fields are called |u|, |v|, |w|, |x|, |y|, and |z|.

As a consequence of these conventions, we can visit all arcs of a
graph~|g| by using the following program:
$$\vcenter{\halign{#\hfil\cr
|Vertex *v;|\cr
|Arc *a;|\cr
|for (v=g->vertices; v<g->vertices+g->n; v++)|\cr
\quad|for (a=v->arcs; a; a=a->next)|\cr
\qquad\\{visit}|(v,a)|;\cr}}$$

@<Type...@>=
#define ID_FIELD_SIZE 161
typedef struct graph_struct {
  Vertex *vertices; /* beginning of the vertex array */
  long n; /* total number of vertices */
  long m; /* total number of arcs */
  char id[ID_FIELD_SIZE]; /* GraphBase identification */
  char format[15]; /* usage of utility fields */
  Area data; /* the main data blocks */
  Area aux_data; /* subsidiary data blocks */
  util u,v,w,x,y,z; /* multipurpose fields */
} Graph;

@ The |format| field should always hold a string of length 14, followed
as usual by a null character to terminate that string. The first six
characters of |format| specify the usage of utility fields |u|, |v|,
|w|, |x|, |y|, and~|z| in |Vertex| records; the next two characters give the
format of the utility fields in |Arc| records; the last six give the
format of the utility fields in |Graph| records.  Each character
should be either \.I (denoting a |long| integer),
\.S (denoting a pointer to a string),
\.V (denoting a pointer to a |Vertex|), \.A (denoting a pointer to an
|Arc|), \.G (denoting a pointer to a |Graph|), or \.Z (denoting an
unused field that remains zero). The default |format| is
|"ZZZZZZZZZZZZZZ"|, when none of the utility fields is being used.

For example, suppose that a bipartite graph |g| is using field |g->u.i|
to specify the size of its first part; suppose further that it has a
string in utility field |a| of each |Arc|, and that it uses
utility field |w| of |Vertex| records to point to an |Arc|. If |g|
leaves all other utility fields untouched, its |format| should be
|"ZZAZZZSZIZZZZZ"|.

The |format| string is presently examined only by the |save_graph| and
|restore_graph| routines, which convert GraphBase graphs from internal
data structures to symbolic external files and vice versa. Therefore
users need not update the |format| when they write algorithms to
manipulate graphs, unless they are going to use |save_graph| to output
a graph in symbolic form, or unless they are using some other
GraphBase-related software that might rely on the |format|
conventions.  (Such software is not part of the ``official'' Stanford
GraphBase, but it may conceivably exist some day.)

@ Some applications of bipartite graphs require all vertices of the first
part to appear at the beginning of the |vertices| array. In such cases,
utility field |u.i| is traditionally given the symbolic name |n_1|, and
it is set equal to the size of that first part. The size of the other
part is then |g->n - g->n_1|.
@^bipartite graph@>

@d n_1 u.i /* utility field |u| may denote size of bipartite first part */

@(gb_graph.h@>=
#define n_1 @t\quad@> u.i
#define mark_bipartite(g,n1) @[g->n_1=n1,g->format[8]='I'@]

@ A new graph is created by calling |gb_new_graph(n)|, which returns a
pointer to a |Graph| record for a graph with |n| vertices and no arcs.
This function also initalizes several private variables that are used
by the |gb_new_arc|, |gb_new_edge|, |gb_virgin_arc|, and |gb_save_string|
procedures below.

We actually reserve space for |n+extra_n| vertices, although claiming only~$n$,
because several graph manipulation algorithms like to add a special vertex
or two to the graphs they deal with. 

@<External f...@>=
Graph *gb_new_graph(n)
  long n; /* desired number of vertices */
{
  cur_graph=(Graph*)calloc(1,sizeof(Graph));
  if (cur_graph) {
    cur_graph->vertices=gb_alloc_type(n+extra_n,@[Vertex@],cur_graph->data);
    if (cur_graph->vertices) {Vertex *p;
      cur_graph->n=n;
      for (p=cur_graph->vertices+n+extra_n-1; p>=cur_graph->vertices; p--)
        p->name=null_string;
      sprintf(cur_graph->id,"gb_new_graph(%ld)",n);
      strcpy(cur_graph->format,"ZZZZZZZZZZZZZZ");
    } else {
      cfree(cur_graph);
      cur_graph=NULL;
    }
  }
  next_arc=bad_arc=NULL;
  next_string=bad_string=NULL;
  gb_alloc_trouble=0;
  return cur_graph;
}

@ The value of |extra_n| is ordinarily~4, and it should probably always be at
least~4.

@<External d...@>=
int extra_n=4; /* the number of shadow vertices allocated by |gb_new_graph| */
char null_string[1]; /* a null string constant */

@ @(gb_graph.h@>=
extern int extra_n;
  /* the number of shadow vertices allocated by |gb_new_graph| */
extern char null_string[]; /* a null string constant */
extern make_compound_id(); /* routine to set one |id| field from another */
extern make_double_compound_id(); /* ditto, but from two others */

@ The |id| field of a graph is sometimes manufactured from the |id| field
of another graph. The following routine does this without allowing the
string to get too long after repeated copying.

@ @<External f...@>=
make_compound_id(g,s1,gg,s2) /* |sprintf(g->id,"%s%s%s",s1,gg->id,s2)| */
  Graph *g; /* graph whose |id| is to be set */
  char *s1; /* string for the beginning of the new |id| */
  Graph *gg; /* graph whose |id| is to be copied */
  char *s2; /* string for the end of the new |id| */
{@+int avail=ID_FIELD_SIZE-strlen(s1)-strlen(s2);
  char tmp[ID_FIELD_SIZE];
  strcpy(tmp,gg->id);
  if (strlen(tmp)<avail) sprintf(g->id,"%s%s%s",s1,tmp,s2);
  else sprintf(g->id,"%s%.*s...)%s",s1,avail-5,tmp,s2);
}
@#
make_double_compound_id(g,s1,gg,s2,ggg,s3)
              /* |sprintf(g->id,"%s%s%s%s%s",s1,gg->id,s2,ggg->id,s3)| */
  Graph *g; /* graph whose |id| is to be set */
  char *s1; /* string for the beginning of the new |id| */
  Graph *gg; /* first graph whose |id| is to be copied */
  char *s2; /* string for the middle of the new |id| */
  Graph *ggg; /* second graph whose |id| is to be copied */
  char *s3; /* string for the end of the new |id| */
{@+int avail=ID_FIELD_SIZE-strlen(s1)-strlen(s2)-strlen(s3);
  if (strlen(gg->id)+strlen(ggg->id)<avail)
    sprintf(g->id,"%s%s%s%s%s",s1,gg->id,s2,ggg->id,s3);
  else sprintf(g->id,"%s%.*s...)%s%.*s...)%s",s1,avail/2-5,gg->id,
             s2,(avail-9)/2,ggg->id,s3);
}

@ But how do the arcs get there? That's where the private variables in
|gb_new_graph| come in. If |next_arc| is unequal to |bad_arc|, it points to
an unused |Arc| record in a previously allocated block of |Arc| records.
Similarly, |next_string| and |bad_string| are addresses used to
place strings into a block of memory allocated for that purpose.

@<Private...@>=
static Arc *next_arc; /* the next |Arc| available for allocation */
static Arc *bad_arc; /* but if |next_arc=bad_arc|, that |Arc| isn't there */
static char *next_string; /* the next byte available for storing a string */
static char *bad_string; /* but if |next_string=bad_string|, don't byte */
static Arc dummy_arc[2]; /* an |Arc| record to point to in an emergency */
static Graph dummy_graph; /* a |Graph| record that's normally unused */
static Graph *cur_graph=&dummy_graph; /* the |Graph| most recently created */

@ All new |Arc| records that are created by the automatic |next_arc|/|bad_arc|
scheme originate in a procedure called |gb_virgin_arc|, which returns the
address of a new record having type |Arc|.

When a new block of |Arc| records is needed, we create 102 of them at once;
this strategy causes exactly 2048 bytes to be allocated on most
computer systems---a nice round number. The routine will work, however,
if 102 is replaced by any positive even number. The new block goes into
the |data| area of |cur_graph|.

Graph-building programs do not usually call |gb_virgin_arc| directly;
they generally invoke one of the higher-level routines |gb_new_arc|
or |gb_new_edge| described below.

If memory space has been exhausted, |gb_virgin_arc| will return a
pointer to |dummy_arc|, so that the calling procedure can safely
refer to fields of the result even though |gb_alloc_trouble| is nonzero.

@d arcs_per_block 102

@<External f...@>=
Arc *gb_virgin_arc()
{@+register Arc *cur_arc=next_arc;
  if (cur_arc==bad_arc) {
    cur_arc=gb_alloc_type(arcs_per_block,@[Arc@],cur_graph->data);
    if (cur_arc==NULL)
      cur_arc=dummy_arc;
    else {
      next_arc = cur_arc+1;
      bad_arc = cur_arc+arcs_per_block;
    }
  }
  else next_arc++;
  return cur_arc;
}

@ The routine |gb_new_arc(u,v,len)| creates a new arc of length |len|
from vertex~|u| to vertex~|v|. The arc becomes part of the graph that
was most recently created by |gb_new_graph|, i.e., of the graph
pointed to by the private variable |cur_graph|. This routine assumes
that |u| and |v| are both vertices in that graph.

The new arc will be pointed to by |u->arcs|, immediately after
|gb_new_arc(u,v,len)| has acted. If there is no room for the new arc,
|gb_alloc_trouble| is set nonzero, but |u->arcs| will point to the non-|NULL|
record |dummy_arc|
so that additional information can safely be stored in its utility fields
without risking system crashes before |gb_alloc_trouble| is tested.
However, the linking structure of arcs is apt to be fouled up in such
cases; programs should make sure that |gb_alloc_trouble==0| before doing any
extensive computation on a graph.

@<External f...@>=
void gb_new_arc(u,v,len)
  Vertex *u, *v; /* a newly created arc will go from |u| to |v| */
  long len; /* its length */
{@+register Arc *cur_arc=gb_virgin_arc();
  cur_arc->tip=v; @+cur_arc->next=u->arcs; @+cur_arc->len=len;
  u->arcs=cur_arc;
  cur_graph->m++;
}

@ An undirected graph has ``edges'' instead of arcs. We represent an edge
by two arcs, one going each way.
@^undirected graph@>

The fact that |arcs_per_block| is even means that the |gb_new_edge| routine
needs to call |gb_virgin_arc| only once instead of twice.

Caveats: This routine, like |gb_new_arc|, should be used only after
|gb_new_graph| has caused the private variable |cur_graph| to point to
the graph containing the new edge. The routine |gb_new_edge| must
not be used together with |gb_new_arc| or |gb_virgin_arc| when
building a graph, unless |gb_new_arc| and |gb_virgin_arc| have been
called an even number of times before |gb_new_edge| is invoked.

The new edge will be pointed to by |u->arcs| and by |v->arcs| immediately
after |gb_new_edge| has created it, assuming that |u!=v|. The two arcs
appear next to each other in memory; indeed, |gb_new_edge| rigs things so
that |v->arcs| is |u->arcs+1| when |u<v|.

On many computers it turns out that the first |Arc| record of every such
pair of arcs will have an address that is a multiple of~8, and the
second |Arc| record will have an address that is not a multiple of~8 (because
the first |Arc| will be 20 bytes long, and because |calloc| always returns
a multiple of~8). However, it is not safe to assume this when writing
portable code. Algorithms for undirected graphs can still make good use of
the fact that arcs for edges are paired, without needing any mod~8 assumptions,
if all edges have been created and linked into the graph by |gb_new_edge|:
The inverse of an arc~|a| from |u| to~|v| will be arc |a+1| if and only if
|u<v| or |a->next=a+1|; it will be arc |a-1| if and only if |u>=v| and
|a->next!=a+1|. The condition |a->next=a+1| can hold only if |u=v|.

@<External f...@>=
void gb_new_edge(u,v,len)
  Vertex *u, *v; /* new arcs will go from |u| to |v| and from |v| to |u| */
  long len; /* their length */
{@+register Arc *cur_arc=gb_virgin_arc();
  if (cur_arc!=dummy_arc) next_arc++;
  if (u<v) {
    cur_arc->tip=v; @+cur_arc->next=u->arcs;
    (cur_arc+1)->tip=u; @+(cur_arc+1)->next=v->arcs;
    u->arcs=cur_arc; v->arcs=cur_arc+1;
  } else {
    (cur_arc+1)->tip=v; @+(cur_arc+1)->next=u->arcs;
    u->arcs=cur_arc+1; /* do this now in case |u==v| */
    cur_arc->tip=u; @+cur_arc->next=v->arcs;
    v->arcs=cur_arc;
  }
  cur_arc->len=(cur_arc+1)->len=len;
  cur_graph->m+=2;
}

@ Sometimes (let us hope rarely) we may need to use a dirty trick
hinted at in the previous discussion. On most computers, the mate to
arc~|a| will be |a-1| if and only if |edge_trick&(unsigned long)a|
is nonzero.
@^system dependencies@>
@^pointer hacks@>

@<External d...@>=
unsigned long edge_trick=sizeof(Arc)-(sizeof(Arc)&(sizeof(Arc)-1));

@ @(gb_graph.h@>=
extern unsigned long edge_trick; /* least significant 1 bit in |sizeof(Arc)| */

@ Vertices generally have a symbolic name, and we need a place to put
such names. The |gb_save_string| function is a convenient utility
for this purpose:
Given a null-terminated string of any length, |gb_save_string| stashes
it away in a safe place and returns a pointer to that place. Memory is
conserved by combining strings from the current graph into largish blocks
of a convenient size.

Note that |gb_save_string| should be used only after |gb_new_graph| has provided
suitable initialization, because the private variable |cur_graph| must
point to the graph for which storage is currently being allocated, and
the private variables |next_string| and |bad_string| must also have
suitable values.

@d string_block_size 1016 /* $1024-8$ is usually efficient */

@<External f...@>=
char *gb_save_string(s)
  register char *s; /* the string to be copied */
{@+register char *p=s;
  register long len; /* length of the string and following null character */
  while (*p++) ; /* advance to end of string */
  len=p-s;
  p=next_string;
  if (p+len>bad_string) { /* not enough room in current block */
    long size=string_block_size;
    if (len>size)
      size=len;
    p=gb_alloc(size,cur_graph->data);
    if (p==NULL)
      return null_string; /* return a pointer to |""| if memory ran out */
    bad_string=p+size;
  }
  while (*s) *p++=*s++; /* copy the non-null bytes of the string */
  *p++='\0'; /* and append a null character */
  next_string=p;
  return p-len;
}

@ The test routine illustrates some of these basic maneuvers.

@<Create a small graph@>=
g=gb_new_graph(2);
if (g==NULL) {
  fprintf(stderr,"Oops, I couldn't even create a trivial graph!\n");
  return -3;
}
u=g->vertices;@+ v=u+1;
u->name=gb_save_string("vertex 0");
v->name=gb_save_string("vertex 1");

@ @<Decl...@>=
Graph *g;
Vertex *u,*v;

@ If the ``edge trick'' fails, the standard GraphBase routines are
unaffected except for the demonstration program |miles_span|. (And
that program uses |edge_trick| only when printing verbose comments.)
@^edge trick failure@>

@<Check that the small graph is still there@>=
if (strncmp(u->name,v->name,7)) {
  fprintf(stderr,"Something is fouled up in the string storage machinery!\n");
  return -4;
}
gb_new_edge(v,u,-1);
gb_new_edge(u,u,1);
gb_new_arc(v,u,-1);
if ((edge_trick&(unsigned long)(u->arcs))||
    (edge_trick&(unsigned long)(u->arcs->next->next))||
    !(edge_trick&(unsigned long)(v->arcs->next)))
  printf("Warning: The \"edge trick\" failed!\n");
if (v->name[7]+g->n!=v->arcs->next->tip->name[7]+g->m-2) {
     /* |'1'+2!='0'+5-2| */
  fprintf(stderr,"Sorry, the graph data structures aren't working yet.\n");
  return -5;
}

@ Some applications may need to add arcs to several graphs at a time,
violating the assumptions stated above about |cur_graph| and the other
private variables. The |switch_to_graph| function gets around that
restriction, by using the utility slots |w|, |x|, |y|, and
|z| of |Graph| records to save and restore the private variables.

Just say |switch_to_graph(g)| in order to make |cur_graph| be~|g| and
to restore the other private variables that are needed by
|gb_new_arc|, |gb_virgin_arc|, |gb_new_edge|, and |gb_save_string|.
Restriction: The graph |g| being switched to must have previously been
switched from; i.e., it must have been |cur_graph| when |switch_to_graph|
was called previously. Otherwise its private allocation variables will
not have been saved. To meet this restriction, you should say
|switch_to_graph(NULL)| just before calling |gb_new_graph|, if you
intend to switch back to the current graph later.

(The swap-in-swap-out nature of these conventions may seem inelegant, but
convenience and efficiency are more important than elegance when most
applications do not need the ability to switch between graphs.)

@<External f...@>=
void switch_to_graph(g)
  Graph *g;
{
  cur_graph->w.a=next_arc; @+cur_graph->x.a=bad_arc;
  cur_graph->y.s=next_string; @+cur_graph->z.s=bad_string;
  cur_graph=(g? g: &dummy_graph);
  next_arc=cur_graph->w.a; @+bad_arc=cur_graph->x.a;
  next_string=cur_graph->y.s; @+bad_string=cur_graph->z.s;
  cur_graph->w.a=NULL;
  cur_graph->x.a=NULL;
  cur_graph->y.s=NULL;
  cur_graph->z.s=NULL;
}

@ Finally,
here's a routine that obliterates an entire graph when it is no longer needed:

@<External fun...@>=
void gb_recycle(g)
  Graph *g;
{
  if (g) {
    gb_free(g->data);
    gb_free(g->aux_data);
    cfree(g); /* the user must not refer to |g| again */
  }
}

@ @(gb_graph.h@>=
extern Graph*gb_new_graph(); /* create a new graph structure */
extern void gb_new_arc(); /* append an arc to the current graph */
extern Arc*gb_virgin_arc(); /* allocate a new |Arc| record */
extern void gb_new_edge(); /* append an edge (two arcs) to the current graph */
extern char*gb_save_string(); /* store a string in the current graph */
extern void switch_to_graph(); /* save allocation variables, swap in others */
extern void gb_recycle(); /* delete a graph structure */

@* Searching for vertices. We sometimes want to be able to find a vertex, given
its name, and it is nice to do this in a standard way. The following simple
subroutines can be used:

{\narrower
\smallskip|hash_in(v)| puts the name of vertex |v| into the hash table;
\smallskip|hash_out(s)| finds a vertex named |s|, if present in the hash table;
\smallskip|hash_setup(g)| prepares a hash table for all vertices of graph~|g|;
\smallskip|hash_lookup(s,g)| looks up the name |s| in the hash table of |g|.
\smallskip}

\noindent Routines |hash_in| and |hash_out| apply to the current graph being
created, while |hash_setup| and |hash_lookup| apply to arbitrary graphs.

Important: Utility fields |u| and |v| of each vertex are reserved for use by
the search routine when hashing is active. You can crash the system
if you try to fool around with these values yourself, or if you use any
subroutines that change those fields. The first two characters in the
current graph's |format| field should be \.{VV} if the hash table information
is to be saved by |gb_save|.

Warning: Users of this hash scheme must preserve the number of
vertices |g->n| in the current graph~|g|. If |g->n| is changed,
the hash table will be worthless, unless |hash_setup| is used to
rehash everything.

@<gb_graph.h@>=
extern void hash_in(); /* input a name to the hash table of current graph */
extern Vertex* hash_out(); /* find a name in hash table of current graph */
extern void hash_setup(); /* create a hash table for a given graph */
extern Vertex* hash_lookup(); /* find a name in a given graph */

@ The lookup scheme is quite simple: We compute a more-or-less random
value |h| based on the vertex name, where |0<=h<n|, assuming that
the graph has |n|~vertices. There is a list of all vertices whose hash
address is~|h|, starting at |(g->vertices+h)->hash_head| and linked
together in the |hash_link| fields, where |hash_head| and |hash_link| are
utility fields |u.v| and |v.v|.

@d hash_link u.v
@d hash_head v.v

@ @<External fun...@>=
void hash_in(v)
  Vertex *v;
{@+  register char *t=v->name;
  register Vertex *u;
  @<Find vertex |u|, whose location is the hash code for string |t|@>;
  v->hash_link=u->hash_head;
  u->hash_head=v;
}

@ The hash code for a string $c_1c_2\ldots c_l$ of length $l$ is
a nonlinear function of the characters that appears to produce reasonably
random results between 0 and the number of vertices in the current graph.

Caution: This hash coding scheme is system-dependent, because it
uses the system's character codes. If you create a graph on
a machine with ASCII code and save it with |gb_save|, and if you ship the
resulting text file to some friend whose machine does not use ASCII code,
your friend will have to rebuild the hash structure with |hash_setup|
before being able to use |hash_lookup| successfully.
@^character-set dependencies@>

@d HASH_MULT 314159 /* random multiplier */
@d HASH_PRIME 516595003 /* the 27182818th prime; it's less than $2^{29}$ */

@<Find vertex |u|...@>=
{@+register int h;
  for (h=0;*t;t++) {
    h+=(h^(h>>1))+HASH_MULT*(unsigned char)*t;
    while (h>=HASH_PRIME) h-=HASH_PRIME;
  }
  u=cur_graph->vertices+(h % cur_graph->n);
}

@ If the hash function were truly random, the average number of
string comparisons made would be less than $(e^2+7)/8\approx 1.80$ on
a successful search, and less than $(e^2+1)/4\approx2.10$ on an
unsuccessful search [{\sl Sorting and Searching}, Section 6.4,
Eqs.~(15) and~(16)].

@<External fun...@>=
Vertex* hash_out(s)
  char* s;
{@+register char *t=s;
  register Vertex *u;
  @<Find vertex |u|...@>;
  for (u=u->hash_head;u;u=u->hash_link)
    if (strcmp(s,u->name)==0) return u;
  return NULL; /* not found */
}

@ @<External fun...@>=
void hash_setup(g)
  Graph *g;
{@+Graph *save_cur_graph;
  if (g && g->n>0) {@+register Vertex *v;
    save_cur_graph=cur_graph;
    cur_graph=g;
    for (v=g->vertices;v<g->vertices+g->n;v++) v->hash_head=NULL;
    for (v=g->vertices;v<g->vertices+g->n;v++) hash_in(v);
    *(g->format)=*(g->format+1)='V';
         /* indicate usage of |hash_head| and |hash_link| */
    cur_graph=save_cur_graph;
  }
}

@ @<External fun...@>=
Vertex* hash_lookup(s,g)
  char *s;
  Graph *g;
{@+Graph *save_cur_graph;
  if (g && g->n>0) {@+register Vertex *v;
    save_cur_graph=cur_graph;
    cur_graph=g;
    v=hash_out(s);
    cur_graph=save_cur_graph;
    return v;
  }
  else return NULL;
}

@* Index. Here is a list that shows where the identifiers of this program are
defined and used.
