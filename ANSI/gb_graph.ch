Change file for gb_graph.w
@x	lines 450-451
      for (p=cur_graph->vertices+n+extra_n-1; p>=cur_graph->vertices; p--)
        p->name=null_string;
@y
      for (p=cur_graph->vertices+n+extra_n; p>cur_graph->vertices; )
        (--p)->name=null_string;
@z
