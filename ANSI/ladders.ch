Change file for ladders.w

@x	lines 184-185
  for (u=g->vertices+g->n-1; u>=g->vertices; u--) {@+register Arc *a;
    register char *p=u->name;
@y
  for (u=g->vertices+g->n; u>g->vertices; ) {@+register Arc *a;
    register char *p=(--u)->name;
@z

@x	lines 191-192
  for (u=g->vertices+g->n-1; u>=g->vertices; u--) {@+register Arc *a;
    for (a=u->arcs; a; a=a->next)
@y
  for (u=g->vertices+g->n; u>g->vertices; u) {@+register Arc *a;
    for (a=(--u)->arcs; a; a=a->next)
@z

@x
for (uu=g->vertices+gg->n-1; uu>=g->vertices+g->n; uu--) {@+register Arc *a;
  for (a=uu->arcs; a; a=a->next) {
@y
for (uu=g->vertices+gg->n; uu>g->vertices+g->n; ) {@+register Arc *a;
  for (a=(--uu)->arcs; a; a=a->next) {
@z

