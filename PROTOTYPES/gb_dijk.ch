@x l.68
extern long dijkstra(); /* procedure to calculate shortest paths */
#define print_dijkstra_result p_dijkstra_result /* shorthand for linker */
extern void print_dijkstra_result(); /* procedure to display the answer */
@y
extern long dijkstra(Vertex *,Vertex *,Graph *,long (*)(Vertex *));
   /* procedure to calculate shortest paths */
#define print_dijkstra_result p_dijkstra_result /* shorthand for linker */
extern void print_dijkstra_result(Vertex *);
   /* procedure to display the answer */
@z

@x l.143
extern void @[@] (*init_queue)();
 /* create an empty priority queue for |dijkstra| */
extern void @[@] (*enqueue)(); /* insert a new element in the priority queue */
extern void @[@] (*requeue)(); /* decrease the key of an element in the queue */
extern Vertex *(*del_min)(); /* remove an element with smallest key */
@y
extern void @[@] (*init_queue)(long);
   /* create an empty priority queue for |dijkstra| */
extern void @[@] (*enqueue)(Vertex *,long);
   /* insert a new element in the priority queue */
extern void @[@] (*requeue)(Vertex *,long);
   /* decrease the key of an element in the queue */
extern Vertex *(*del_min)(void);
   /* remove an element with smallest key */
@z

@x l.162
static long dummy(v)
  Vertex *v;
@y
static long dummy(Vertex *v)
@z

@x l.169
long dijkstra(uu,vv,gg,hh)
  Vertex *uu; /* the starting point */
  Vertex *vv; /* the ending point */
  Graph *gg; /* the graph they belong to */
  long @[@] (*hh)(); /* heuristic function */
@y
long dijkstra(@t\1\1@>
  Vertex *uu, /* the starting point */
  Vertex *vv, /* the ending point */
  Graph *gg, /* the graph they belong to */
  long (*hh)(Vertex *)@t\2\2@>) /* heuristic function */
@z

@x l.257
void print_dijkstra_result(vv)
  Vertex *vv; /* ending vertex */
@y
void print_dijkstra_result(Vertex *vv) /* ending vertex */
@z

@x l.295
void @[@] (*init_queue)() = init_dlist; /* create an empty dlist */
void @[@] (*enqueue)() = enlist; /* insert a new element in dlist */
void @[@] (*requeue)() = reenlist ;
  /* decrease the key of an element in dlist */
Vertex *(*del_min)() = del_first; /* remove element with smallest key */
@y
void @[@] (*init_queue)(long) = init_dlist; /* create an empty dlist */
void @[@] (*enqueue)(Vertex *,long) = enlist; /* insert a new element in dlist */
void @[@] (*requeue)(Vertex *,long) = reenlist ;
  /* decrease the key of an element in dlist */
Vertex *(*del_min)(void) = del_first; /* remove element with smallest key */
@z

@x l.311
void init_dlist(d)
  long d;
@y
void init_dlist(long d)
@z

@x l.328
void enlist(v,d)
  Vertex *v;
  long d;
@y
void enlist(Vertex *v,long d)
@z

@x l.340
void reenlist(v,d)
  Vertex *v;
  long d;
@y
void reenlist(Vertex *v,long d)
@z

@x l.353
Vertex *del_first()
@y
Vertex *del_first(void)
@z

@x l.374
void init_128(d)
  long d;
@y
void init_128(long d)
@z

@x l.386
Vertex *del_128()
@y
Vertex *del_128(void)
@z

@x l.402
void enq_128(v,d)
  Vertex *v; /* new vertex for the queue */
  long d; /* its |dist| */
@y
void enq_128(@t\1\1@>
  Vertex *v, /* new vertex for the queue */
  long d@t\2\2@>) /* its |dist| */
@z

@x l.425
void req_128(v,d)
  Vertex *v; /* vertex to be moved to another list */
  long d; /* its new |dist| */
@y
void req_128(@t\1\1@>
  Vertex *v, /* vertex to be moved to another list */
  long d@t\2\2@>) /* its new |dist| */
@z

@x l.442
extern void init_dlist();
extern void enlist();
extern void reenlist();
extern Vertex *del_first();
extern void init_128();
extern Vertex *del_128();
extern void enq_128();
extern void req_128();
@y
extern void init_dlist(long);
extern void enlist(Vertex *,long);
extern void reenlist(Vertex *,long);
extern Vertex *del_first(void);
extern void init_128(long);
extern Vertex *del_128(void);
extern void enq_128(Vertex *,long);
extern void req_128(Vertex *,long);
@z
