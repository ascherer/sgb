% This file is part of the Stanford GraphBase (c) Stanford University 1992
\def\title{WORD\_\thinspace COMPONENTS}
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!

\prerequisite{GB\_WORDS}
@* Components. \kern-.7pt
This simple demonstration program computes the connected
components of the GraphBase graph of five-letter words. It prints the
words in order of decreasing weight, showing the number of edges,
components, and isolated vertices present in the graph defined by the
first $n$ words for all~$n$.

@f Vertex int
@f Arc int
@f Graph int

@p
#include "gb_graph.h" /* the GraphBase data structures */
#include "gb_words.h" /* the |words| routine */
@#
main()
{@+Graph *g=words(0,0,0,0); /* the graph we love */
  Vertex *v; /* the current vertex being added to the component structure */
  Arc *a; /* the current arc of interest */
  int n=0; /* the number of vertices in the component structure */
  int isol=0; /* the number of isolated vertices in the component structure */
  int comp=0; /* the current number of components */
  int m=0; /* the current number of edges */
  printf("Component analysis of %s\n",g->id);
  for (v=g->vertices; v<g->vertices+g->n; v++) {
    n++, printf("%4d: %5d %s",n,v->weight,v->name);
    @<Add vertex |v| to the component structure, printing out any
          components it joins@>;
    printf("; c=%d,i=%d,m=%d\n", comp, isol, m);
  }
  @<Display all unusual components@>;
}

@ The arcs from |v| to previous vertices all appear on the list |v->arcs|
after the arcs from |v| to future vertices. In this program, we aren't
interested in the future, only the past; so we skip the initial arcs.

@<Add vertex |v| to the component structure, printing out...@>=
@<Make |v| a component all by itself@>;
a=v->arcs;
while (a && a->tip>v) a=a->next;
if (!a) printf("[1]"); /* indicate that this word is isolated */
else {@+int c=0; /* the number of merge steps performed because of |v| */
  for (; a; a=a->next) {@+register Vertex *u=a->tip;
    m++;
    @<Merge the components of |u| and |v|, if they differ@>;
  }
  printf(" in %s[%d]", v->master->name, v->master->size);
   /* show final component */
}

@ We keep track of connected components by using circular lists, a
procedure that is known to take average time $O(n)$ on truly
random graphs [Knuth and Sch\"onhage, {\sl Theoretical Computer Science\/
\bf 6}  (1978), 281--315].

Namely, if |v| is a vertex, all the vertices in its component will be
in the list
$$\hbox{|v|, \ |v->link|, \ |v->link->link|, \ \dots,}$$
eventually returning to |v| again. There is also a master vertex in
each component, |v->master|; if |v| is the master vertex, |v->size| will
be the number of vertices in its component.

@d link z.v /* link to next vertex in component (occupies utility field |z|) */
@d master y.v /* pointer to master vertex in component */
@d size x.i /* size of component, kept up to date for master vertices only */

@<Make |v| a component all by itself@>=
v->link=v;
v->master=v;
v->size=1;
isol++;
comp++;

@ When two components merge together, we change the identity of the master
vertex in the smaller component. The master vertex representing |v| itself
will change if |v| is adjacent to any prior vertex.

@<Merge the components of |u| and |v|, if they differ@>=
u=u->master;
if (u!=v->master) {@+register Vertex *w=v->master, *t;
  if (u->size<w->size) {
    if (c++>0) printf("%s %s[%d]", (c==2? " with": ","), u->name, u->size);
    w->size += u->size;
    if (u->size==1) isol--;
    for (t=u->link; t!=u; t=t->link) t->master=w;
    u->master=w;
  } else {
    if (c++>0) printf("%s %s[%d]", (c==2? " with": ","), w->name, w->size);
    if (u->size==1) isol--;
    u->size += w->size;
    if (w->size==1) isol--;
    for (t=w->link; t!=w; t=t->link) t->master=u;
    w->master=u;
  }
  t=u->link;
  u->link=w->link;
  w->link=t;
  comp--;
}

@ The |words| graph has one giant component and lots of isolated vertices.
We consider all other components unusual, so we print them out when the
other computation is done.

@<Display all unusual components@>=
printf("\nThe following non-isolated words didn't join the giant component:\n");
for (v=g->vertices; v<g->vertices+g->n; v++)
  if (v->master==v && v->size>1 && v->size <4000) {@+register Vertex *u;
     int c=1; /* count of number printed on current line */
     printf("%s", v->name);
     for (u=v->link; u!=v; u=u->link) {
       if (c++==12) putchar('\n'),c=1;
       printf(" %s",u->name);
     }
     putchar('\n');
  }

@* Index. We close with a list that shows where the identifiers of this
program are defined and used.

