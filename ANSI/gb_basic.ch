Change file for gb_basic.w

@x	lines 1897-1899
for (v=g->vertices+g->n-1;v>=g->vertices;v--) {@+register Arc *a;
  register long mapped=0; /* has |v->map| been set? */
  for (a=v->arcs;a;a=a->next) {@+register Vertex *vv=a->tip;
@y
for (v=g->vertices+g->n;v>g->vertices; ) {@+register Arc *a;
  register long mapped=0; /* has |v->map| been set? */
  for (a=(--v)->arcs;a;a=a->next) {@+register Vertex *vv=a->tip;
@z
