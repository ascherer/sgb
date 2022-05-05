@x l.14
extern Graph *roget();
@y
extern Graph *roget(unsigned long,unsigned long,unsigned long,long);
@z

@x l.78
Graph *roget(n,min_distance,prob,seed)
  unsigned long n; /* number of vertices desired */
  unsigned long min_distance; /* smallest inter-category distance allowed
                            in an arc */
  unsigned long prob; /* 65536 times the probability of rejecting an arc */
  long seed; /* random number seed */
@y
Graph *roget(
  unsigned long n, /* number of vertices desired */
  unsigned long min_distance,
    /* smallest inter-category distance allowed in an arc */
  unsigned long prob, /* 65536 times the probability of rejecting an arc */
  long seed) /* random number seed */
@z
