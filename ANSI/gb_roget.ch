Change file for gb_roget.w

@x	lines 128-130
for (v=new_graph->vertices+n-1; v>=new_graph->vertices; v--) {
  j=gb_unif_rand(k);
  mapping[cats[j]]=v; cats[j]=cats[--k];
@y
for (v=new_graph->vertices+n; v>new_graph->vertices; ) {
  j=gb_unif_rand(k);
  mapping[cats[j]]=--v; cats[j]=cats[--k];
@z

