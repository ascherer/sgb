Change file for gb_dijk.w

@x	line 195
for (t=gg->vertices+gg->n-1; t>=gg->vertices; t--) t->backlink=NULL;
@y
for (t=gg->vertices+gg->n; t>gg->vertices; ) (--t)->backlink=NULL;
@z
