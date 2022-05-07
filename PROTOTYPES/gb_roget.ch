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

@x l.176
    if (gb_number(10)!=k) panic(syntax_error); /* out of synch */
@y
    if ((long)gb_number(10)!=k) panic(syntax_error); /* out of synch */
@z

@x l.198
  if (mapping[j] && iabs(j-k)>=min_distance &&
       (prob==0 || ((gb_next_rand()>>15)>=prob)))
@y
  if (mapping[j] && (unsigned long)iabs(j-k)>=min_distance &&
       (prob==0 || ((unsigned long)(gb_next_rand()>>15)>=prob)))
@z
