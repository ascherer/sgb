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
Graph *roget(@t\1\1@>
  unsigned long n, /* number of vertices desired */
  unsigned long min_distance,
    /* smallest inter-category distance allowed in an arc */
  unsigned long prob, /* 65536 times the probability of rejecting an arc */
  long seed@t\2\2@>) /* random number seed */
@z
