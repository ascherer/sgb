% This file is part of the Stanford GraphBase (c) Stanford University 1992
\def\title{QUEEN}
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!

@* Introduction. This is a short demonstration of how to generate and
traverse graphs with the Stanford GraphBase. It creates a graph
with 12 vertices, representing the positions on a $3\times4$ rectangular
board; two positions are considered adjacent if you can get
from one to another by a queen move. Then it prints a description
of the vertices and their neighbors, on the standard output file.

An ASCII file called \.{queen.gb} is also produced. Other programs
can make a copy of the queen graph by calling |restore_graph("queen.gb")|.
You may find it interesting to compare the output of |queen| with
the contents of \.{queen.gb}; the former is intended to be readable
by human beings, the latter by computers.

@f Graph int /* |gb_graph| defines the |Graph| type and a few others */
@f Vertex int
@f Arc int

@p
#include "gb_graph.h" /* we use the |gb_graph| data structures */
#include "gb_basic.h" /* we test the basic graph operations */
#include "gb_save.h" /* and we save our results in ASCII format */
@#
main()
{@+Graph *g,*gg,*ggg;
  g=board(3,4,0,0,-1,0,0); /* a graph with rook moves */
  gg=board(3,4,0,0,-2,0,0); /* a graph with bishop moves */
  ggg=gunion(g,gg,0,0); /* a graph with queen moves */
  save_graph(ggg,"queen.gb"); /* generate an ASCII file for |ggg| */
  @<Print the vertices and edges of |ggg|@>;
}

@ @<Print the vertices and edges of |ggg|@>=
if (ggg==NULL) printf("Something went wrong (panic code %d)!\n",panic_code);
else {
  register Vertex *v; /* current vertex being visited */
  printf("Queen Moves on a 3x4 Board\n\n");
  printf("  The graph whose official name is\n%s\n", ggg->id);
  printf("  has %d vertices and %d arcs:\n\n", ggg->n, ggg->m);
  for (v=ggg->vertices; v<ggg->vertices+ggg->n; v++) {
    register Arc *a; /* current arc from |v| */
    printf("%s\n", v->name);
    for (a=v->arcs; a; a=a->next)
      printf("  -> %s, length %d\n", a->tip->name, a->len);
  }
}

@* Index.
