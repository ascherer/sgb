% This file is part of the Stanford GraphBase (c) Stanford University 1993
It's a demonstration "change file", which modifies the demonstration program
word_components. To use it on a UNIX system, say
  ctangle word_components word_giant word_giant
  make word_giant
  word_giant
and you should find a file word_giant.gb that contains a useful graph.
(Try testing this graph with "miles_span -gword_giant.gb".)

See queen_wrap.ch for comments on the general form of change files.

@x replace the copyright notice by a change notice
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!
@y
\let\maybe=\iffalse % print only sections that change
\def\prerequisite#1{} \def\prerequisites#1#2{} % disable boilerplate macros
\def\botofcontents{\vskip 0pt plus 1filll \parskip=0pt
  This program was obtained by modifying {\sc WORD\_\,COMPONENTS} in the
  Stanford GraphBase.\par
  Only sections that have changed are listed here.\par}
@z
@x change the program title
\def\title{WORD\_\,COMPONENTS}
@y
\def\title{WORD\_\,GIANT}
@z

@x here we modify the introductory remarks of section 1
@* Components. \kern-.7pt
This simple demonstration program computes the connected
components of the GraphBase graph of five-letter words. It prints the
words in order of decreasing weight, showing the number of edges,
components, and isolated vertices present in the graph defined by the
first $n$ words for all~$n$.
@y
@* Components.
This simple demonstration program computes the largest connected
component of the GraphBase graph of five-letter words, and saves it
in file \.{word\_giant.gb}. It modifies the edge lengths so that
alphabetic distances are used (as in the \.{-a} option of {\sc LADDERS}).
@z

@x include additional header files in section 1
#include "gb_graph.h" /* the GraphBase data structures */
@y
#include "gb_graph.h" /* the GraphBase data structures */
#include "gb_save.h" /* the |save_graph| routine */
#include "gb_basic.h" /* the |induced| routine */
@z

@x changes to the code of section 1
  printf("Component analysis of %s\n",g->id);
  for (v=g->vertices; v<g->vertices+g->n; v++) {
    n++, printf("%4ld: %5ld %s",n,v->weight,v->name);
    @<Add vertex |v| to the component structure, printing out any
          components it joins@>;
    printf("; c=%ld,i=%ld,m=%ld\n", comp, isol, m);
  }
  @<Display all unusual components@>;
@y we suppress printing
  for (v=g->vertices; v<g->vertices+g->n; v++) {
    n++;
    @<Add vertex |v| to the component structure, and change the lengths
          of edges that connect it to previous vertices@>;
  }
  @<Mark all vertices of the giant component@>;
  save_graph(induced(g,"giant",0,0,0),"word_giant.gb");
@z

@x change to the code of section 2
if (!a) printf("[1]"); /* indicate that this word is isolated */
else {@+long c=0; /* the number of merge steps performed because of |v| */
  for (; a; a=a->next) {@+register Vertex *u=a->tip;
    m++;
    @<Merge the components of |u| and |v|, if they differ@>;
  }
  printf(" in %s[%ld]", v->master->name, v->master->size);
   /* show final component */
}
@y
for (; a; a=a->next) {@+register Vertex *u=a->tip;
  register int k=a->loc; /* where the words differ */
  register char *p=v->name+k,*q=u->name+k;
  if (*p<*q) a->len=(a-1)->len=*q-*p;
  else a->len=(a-1)->len=*p-*q; /* alphabetic distance */
  m++;
  @<Merge the components of |u| and |v|, if they differ@>;
}
@z

@x delete printing in section 4
    if (c++>0) printf("%s %s[%ld]", (c==2? " with": ","), u->name, u->size);
@y
@z
@x delete more printing in section 4
    if (c++>0) printf("%s %s[%ld]", (c==2? " with": ","), w->name, w->size);
@y
@z

@x replace section 5
We consider all other components unusual, so we print them out when the
other computation is done.

@<Display all unusual components@>=
printf(
  "\nThe following non-isolated words didn't join the giant component:\n");
for (v=g->vertices; v<g->vertices+g->n; v++)
  if (v->master==v && v->size>1 && v->size+v->size<g->n) {@+register Vertex *u;
     long c=1; /* count of number printed on current line */
     printf("%s", v->name);
     for (u=v->link; u!=v; u=u->link) {
       if (c++==12) putchar('\n'),c=1;
       printf(" %s",u->name);
     }
     putchar('\n');
  }
@y
We set the |ind| field to 1 in the giant component, so that the
|induced| routine will retain those vertices.

@<Mark...@>=
for (v=g->vertices; v<g->vertices+g->n; v++)
  if (v->master->size+v->master->size<g->n) v->ind=0;
  else v->ind=1;
@z
