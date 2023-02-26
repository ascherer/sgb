@x l.14
extern Graph *miles();
@y
extern Graph *miles(unsigned long,long,long,long,@|
  unsigned long,unsigned long,long);
@z

@x l.116
Graph *miles(n,north_weight,west_weight,pop_weight,
    max_distance,max_degree,seed)
  unsigned long n; /* number of vertices desired */
  long north_weight; /* coefficient of latitude in the weight function */
  long west_weight; /* coefficient of longitude in the weight function */
  long pop_weight; /* coefficient of population in the weight function */
  unsigned long max_distance; /* maximum distance in an edge, if nonzero */
  unsigned long max_degree;
       /* maximum number of edges per vertex, if nonzero */
  long seed; /* random number seed */
@y
Graph *miles(@t\1\1@>
  unsigned long n, /* number of vertices desired */
  long north_weight, /* coefficient of latitude in the weight function */
  long west_weight, /* coefficient of longitude in the weight function */
  long pop_weight, /* coefficient of population in the weight function */
  unsigned long max_distance, /* maximum distance in an edge, if nonzero */
  unsigned long max_degree, /* maximum number of edges per vertex, if nonzero */
  long seed@t\2\2@>) /* random number seed */
@z

@x l.394
@p long miles_distance(u,v)
  Vertex *u,*v;
@y
@p long miles_distance(Vertex *u,Vertex *v)
@z

@x l.401
extern long miles_distance();
@y
extern long miles_distance(Vertex *,Vertex *);
@z
