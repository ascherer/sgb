@x l.99
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
@y
int main(@t\1\1@>
  int argc, /* the number of command-line arguments */
  char *argv[]@t\2\2@>) /* an array of strings containing those arguments */
@z

@x l.197
report(u,v,l)
  Vertex *u,*v; /* adjacent vertices in the minimum spanning tree */
  long l; /* the length of the edge between them */
@y
void report(@t\1\1@>
  Vertex *u,Vertex *v, /* adjacent vertices in the minimum spanning tree */
  long l@t\2\2@>) /* the length of the edge between them */
@z

@x l.378
unsigned long krusk(g)
  Graph *g;
@y
unsigned long krusk(Graph *g)
@z

@x l.498
void @[@] (*init_queue)(); /* create an empty priority queue */
void @[@] (*enqueue)(); /* insert a new element in the priority queue */
void @[@] (*requeue)(); /* decrease the key of an element in the queue */
Vertex *(*del_min)(); /* remove an element with smallest key */
@y
void @[@] (*init_queue)(long);
   /* create an empty priority queue */
void @[@] (*enqueue)(Vertex *,long);
   /* insert a new element in the priority queue */
void @[@] (*requeue)(Vertex *,long);
   /* decrease the key of an element in the queue */
Vertex *(*del_min)(void);
   /* remove an element with smallest key */
@z

@x l.513
unsigned long jar_pr(g)
  Graph *g;
@y
unsigned long jar_pr(Graph *g)
@z

@x l.610
void init_heap(d) /* makes the heap empty */
  long d;
@y
void init_heap(long d) /* makes the heap empty */
@z

@x l.624
void enq_heap(v,d)
  Vertex *v; /* vertex that is entering the queue */
  long d; /* its key (aka |dist|) */
@y
void enq_heap(@t\1\1@>
  Vertex *v, /* vertex that is entering the queue */
  long d@t\2\2@>) /* its key (aka |dist|) */
@z

@x l.651
void req_heap(v,d)
  Vertex *v; /* vertex whose key is being reduced */
  long d; /* its new |dist| */
@y
void req_heap(@t\1\1@>
  Vertex *v, /* vertex whose key is being reduced */
  long d@t\2\2@>) /* its new |dist| */
@z

@x l.682
Vertex *del_heap()
@y
Vertex *del_heap(void)
@z

@x l.797
void init_F_heap(d)
  long d;
@y
void init_F_heap(long d)
@z

@x l.860
void enq_F_heap(v,d)
  Vertex *v; /* vertex that is entering the queue */
  long d; /* its key (aka |dist|) */
@y
void enq_F_heap(@t\1\1@>
  Vertex *v, /* vertex that is entering the queue */
  long d@t\2\2@>) /* its key (aka |dist|) */
@z

@x l.901
void req_F_heap(v,d)
  Vertex *v; /* vertex whose key is being reduced */
  long d; /* its new |dist| */
@y
void req_F_heap(@t\1\1@>
  Vertex *v, /* vertex whose key is being reduced */
  long d@t\2\2@>) /* its new |dist| */
@z

@x l.970
Vertex *del_F_heap()
@y
Vertex *del_F_heap(void)
@z

@x l.1155
qunite(m,q,mm,qq,h)
  register long m,mm; /* number of nodes in the forests */
  register Arc *q,*qq; /* binomial trees in the forests, linked by |qsib| */
  Arc *h; /* |h->qsib| will get the result */
@y
void qunite(@t\1\1@>
  register long m, /* number of nodes in the forests */
  register Arc *q, /* binomial trees in the forests, linked by |qsib| */
  register long mm, /* number of nodes in the forests */
  register Arc *qq, /* binomial trees in the forests, linked by |qsib| */
  Arc *h@t\2\2@>) /* |h->qsib| will get the result */
@z

@x l.1257
qenque(h,a)
  Arc *h; /* header of a binomial queue */
  Arc *a; /* new element for that queue */
@y
void qenque(@t\1\1@>
  Arc *h, /* header of a binomial queue */
  Arc *a@t\2\2@>) /* new element for that queue */
@z

@x l.1272
qmerge(h,hh)
  Arc *h; /* header of binomial queue that will receive the result */
  Arc *hh; /* header of binomial queue that will be absorbed */
@y
void qmerge(@t\1\1@>
  Arc *h, /* header of binomial queue that will receive the result */
  Arc *hh@t\2\2@>) /* header of binomial queue that will be absorbed */
@z

@x l.1291
Arc *qdel_min(h)
  Arc *h; /* header of binomial queue */
@y
Arc *qdel_min(Arc *h)
  /* header of binomial queue */
@z

@x l.1339
qtraverse(h,visit)
  Arc *h; /* head of binomial queue to be unraveled */
  void @[@] (*visit)(); /* procedure to be invoked on each node */
@y
void qtraverse(@t\1\1@>
  Arc *h, /* head of binomial queue to be unraveled */
  void (*visit)(register Arc *)@t\2\2@>)
    /* procedure to be invoked on each node */
@z

@x l.1392
unsigned long cher_tar_kar(g)
  Graph *g;
@y
unsigned long cher_tar_kar(Graph *g)
@z

@x l.1614
void note_edge(a)
  Arc *a;
@y
void note_edge(Arc *a)
@z
