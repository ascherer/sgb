@x l.14
extern Graph *games();
@y
extern Graph *games(unsigned long,long,long,long,long,long,long,long);
@z

@x l.174
Graph *games(n,ap0_weight,upi0_weight,ap1_weight,upi1_weight,
     first_day,last_day,seed)
  unsigned long n; /* number of vertices desired */
  long ap0_weight; /* coefficient of |ap0| in the weight function */
  long ap1_weight; /* coefficient of |ap1| in the weight function */
  long upi0_weight; /* coefficient of |upi0| in the weight function */
  long upi1_weight; /* coefficient of |upi1| in the weight function */
  long first_day; /* lower cutoff for games to be considered */
  long last_day; /* upper cutoff for games to be considered */
  long seed; /* random number seed */
@y
Graph *games(@t\1\1@>
  unsigned long n, /* number of vertices desired */
  long ap0_weight, /* coefficient of |ap0| in the weight function */
  long upi0_weight, /* coefficient of |ap1| in the weight function */
  long ap1_weight, /* coefficient of |upi0| in the weight function */
  long upi1_weight, /* coefficient of |upi1| in the weight function */
  long first_day, /* lower cutoff for games to be considered */
  long last_day, /* upper cutoff for games to be considered */
  long seed@t\2\2@>) /* random number seed */
@z

@x l.440
static Vertex *team_lookup() /* read and decode an abbreviation */
@y
static Vertex *team_lookup(void) /* read and decode an abbreviation */
@z
