Change file for roget_components.w
@x	lines 244-245
for (v=g->vertices+g->n-1; v>=g->vertices; v--) {
  v->rank=0;
@y
for (v=g->vertices+g->n; v>g->vertices; ) {
  (--v)->rank=0;
@z
