% This file is part of the Stanford GraphBase (c) Stanford University 1992
\def\title{GB\_\thinspace ROGET}
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!

\prerequisites{GB\_\thinspace GRAPH}{GB\_\thinspace IO}
@* Introduction. This GraphBase module contains the |roget| subroutine,
which creates a family of graphs based on Roget's Thesaurus. An example
of the use of this procedure can be found in the demo program
|roget_components|.

@(gb_roget.h@>=
extern Graph *roget();

@ The subroutine call `|roget(n,min_distance,prob,seed)|'
constructs a graph based on the information in \.{roget.dat}.
Each vertex of the graph corresponds to one of the 1022 categories in
the 1882 edition of Peter Mark Roget's {\sl Thesaurus of English Words
and Phrases}. An arc goes from one category to another if Roget gave a
reference to the latter among the words and phrases of the former,
or if the two categories were directly related to each other by their
positions in Roget's book. For example, the vertex for category 312
(`ascent') has arcs to the vertices for categories 224 (`obliquity'),
313 (`descent'), and 316 (`leap'), because Roget gave explicit
cross-references from 312 to 224 and~316, and because category 312
was implicitly paired with 313 in his scheme.

The constructed graph will have $\min(n,1022)$ vertices; however, the
default value |n=1022| is substituted when |n=0|. If |n| is less
than 1022, the |n| categories will be selected at random,
and all arcs to unselected categories will be omitted.
Arcs will also be omitted if they correspond to categories whose
nuumbers differ by less than |min_distance|. For example, if
|min_distance>1|, the arc between categories 312 and~313 will not
be included. (Roget sometimes formed clusters of three interrelated
categories; to avoid cross-references among these, you can set
|min_distance=3|.)

If |prob>0|, arcs that would ordinarily be included in the graph are
rejected with probability |prob/65536|. This provides a way
to obtain sparser graphs.

The vertices will appear in random order. However, all ``randomness''
in GraphBase graphs is reproducible; it depends only on the value of
a given |seed|, which can be any nonnegative integer less than~$2^{31}$.
For example, everyone who asks for |roget(1000,3,32768,50)| will
obtain exactly the same graph, regardless of their computer system.

Changing the value of |prob| will affect only the arcs of the
generated graph; it will change neither the choice of vertices
nor the vertex order.

@d MAX_N 1022 /* the number of categories in Roget's book */

@ If the |roget| routine encounters a problem, it returns |NULL|
(\.{NULL}), after putting a code number into the external variable
|panic_code|. This code number identifies the type of failure.
Otherwise |roget| returns a pointer to the newly created graph, which
will be represented with the data structures explained in |gb_graph|.
(The external variable |@!panic_code| is itself defined in |gb_graph|.)

@d panic(c) @+{@+panic_code=c;@+gb_alloc_trouble=0;@+return NULL;@+}
@#
@f Graph int /* |gb_graph| defines the |Graph| type and a few others */
@f Vertex int
@f Arc int

@ The \Cee\ file \.{gb\_roget.c} has the following general shape:

@p
#include "gb_io.h" /* we will use the |gb_io| routines for input */
#include "gb_flip.h"
 /* we will use the |gb_flip| routines for random numbers */
#include "gb_graph.h" /* and we will use the |gb_graph| data structures */
@#
@<Private variables@>@;
@#
Graph *roget(n,min_distance,prob,seed)
  unsigned n; /* number of vertices desired */
  unsigned min_distance; /* smallest inter-category distance allowed
                            in an arc */
  unsigned long prob; /* 65536 times the probability of rejecting an arc */
  long seed; /* random number seed */
{@+@<Local variables@>@;
  gb_init_rand(seed);
  if (n==0 || n>MAX_N) n=MAX_N;
  @<Set up a graph with |n| vertices@>;
  @<Determine the |n| categories to use in the graph@>;
  @<Input \.{roget.dat} and build the graph@>;
  if (gb_alloc_trouble) {
    gb_recycle(new_graph);
    panic(alloc_fault); /* oops, we ran out of memory somewhere back there */
  }
  return new_graph;
}

@ @<Local var...@>=
Graph *new_graph; /* the graph constructed by |roget| */

@* Vertices.

@<Set up a graph with |n| vertices@>=
new_graph=gb_new_graph(n);
if (new_graph==NULL)
  panic(no_room); /* out of memory before we're even started */
sprintf(new_graph->id,"roget(%u,%u,%lu,%ld)",n,min_distance,prob,seed);
strcpy(new_graph->format,"IZZZZZZZZZZZZZ");

@ The first nontrivial thing we need to do is find a random selection and
permutation of |n| vertices. We will compute a |mapping| table such that
|mapping[k]| will be non-|NULL| for exactly |n| randomly selected
category numbers~|k|, i.e., values of~|k| in the range |1<=k<=MAX_N|.
Moreover, these non-|NULL| values will be a random permutation of the
vertices of the graph.

@<Priv...@>=
Vertex *mapping[MAX_N+1]; /* the vertex corresponding to a given category */
int cats[MAX_N]; /* table of category numbers that have not yet been used */

@ In the loop on |v| below, |k| is the number of categories whose |mapping|
value is still |NULL|. The first |k| entries of |cats| will contain
those category numbers in some order.

@<Determine the |n| categories to use in the graph@>=
for (k=0; k<MAX_N; k++)
  cats[k]=k+1,@,mapping[k+1]=NULL;
for (v=new_graph->vertices+n-1; v>=new_graph->vertices; v--) {
  j=gb_unif_rand(k);
  mapping[cats[j]]=v; cats[j]=cats[--k];
}

@ @<Local...@>=
register int j,k; /* all-purpose indices */
register Vertex *v; /* current vertex */

@* Arcs. The data in \.{roget.dat} appears in 1022 lines, one for each
category. For example, the line
$$\hbox{\tt 312ascent:224 313 316}$$
specifies the arcs from category 312 as explained above. First comes the
category number, then the category name, then a colon, then zero or more
numbers specifying arcs to other categories, separated by spaces.

Some categories have too many arcs to fit on a single line; the data
for these categories can be found on two lines, the first line ending
with a backslash and the second line beginning with a space.

@<Input \.{roget.dat} and build the graph@>=
if (gb_open("roget.dat")!=0)
  panic(early_data_fault);
    /* couldn't open |"roget.dat"| using GraphBase conventions */
for (k=1; !gb_eof(); k++)
  @<Read the data for category |k|, and put it in the graph if it
    has been selected@>;
if (gb_close()!=0)
  panic(late_data_fault);
    /* something's wrong with |"roget.dat"|; see |io_errors| */
if (k!=MAX_N+1) panic(impossible);
  /* we don't have the right value of |MAX_N| */

@ We want to check that the data isn't garbled, except that we don't
bother to look at unselected categories.

The original category number is stored in vertex utility field |cat_no|,
in case anybody wants to see it.

@d cat_no u.i /* utility field |u| of each vertex holds the category number */

@<Read the data for category |k|, and put it in the graph if it
   has been selected@>=
{
  if (mapping[k]) { /* yes, this category has been selected */
    if (gb_number(10)!=k) panic(syntax_error); /* out of synch */
    (void)gb_string(str_buf,':');
    if (gb_char()!=':') panic(syntax_error+1); /* no colon found */
    v=mapping[k];
    v->name=gb_save_string(str_buf);
    v->cat_no=k;
    @<Add arcs from |v| for every category that's both listed on the line
          and selected@>;
  } else @<Skip past the data for one category@>;
}

@ @(gb_roget.h@>=
#define cat_no @t\quad@> u.i
 /* definition of |cat_no| is repeated in the header file */

@ @d iabs(x) ((x)<0? -(x): (x))

@<Add arcs from |v| for every...@>=
j=gb_number(10);
if (j==0) goto done; /* some categories lead to no arcs at all */
while (1) {@+Arc *a;
  if (j>MAX_N) panic(syntax_error+2); /* category code out of range */
  if (mapping[j] && iabs(j-k)>=min_distance &&
       (prob==0 || ((gb_next_rand()>>15)>=prob)))
    gb_new_arc(v,mapping[j],1);
  switch (gb_char()) {
  case '\\': gb_newline();
    if (gb_char()!=' ')
      panic(syntax_error+3); /* space should begin a continuation line */
    /* fall through to the space case */
  case ' ': j=gb_number(10);@+break;
  case '\n': goto done;
  default: panic(syntax_error+4);
    /* illegal character following category number */
  }
}
done: gb_newline();

@ We want to call |gb_newline()| twice if the current line ends with a
backslash; otherwise we want to call it just once. There's an obvious
way to do that, and there's also a faster and trickier way.  The
author apologizes here for succumbing to some old-fashioned impulses.
(Recall that |gb_string| returns the location just following the
|'\0'| it places at the end of a scanned string.)

@<Skip past the data for one category@>=
{
  if (*(gb_string(str_buf,'\n')-2)=='\\')
    gb_newline(); /* the first line ended with backslash */
  gb_newline();
}

@* Index. Here is a list that shows where the identifiers of this program are
defined and used.
