@x l.75
#include "gb_graph.h" /* the GraphBase data structures */
#include "gb_flip.h" /* the random number generator */
#include "gb_econ.h" /* the |econ| routine */
@y
#include "gb_econ.h" /* the |econ| routine */
#include "gb_flip.h" /* the random number generator */
@z

@x l.80
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
{@+unsigned long n=79; /* the desired number of sectors */
@y
int main(
  int argc, /* the number of command-line arguments */
  char *argv[]) /* an array of strings containing those arguments */
{@+long n=79; /* the desired number of sectors */
@z

@x l.109
@d INF 0x7fffffff /* infinity (or darn near) */
@y
@d INF (long)(((unsigned long)-1)>>1) /* infinity (or darn near) */
@z

@x l.120
  if (sscanf(argv[argc],"-n%lu",&n)==1) ;
@y
  if (sscanf(argv[argc],"-n%ld",&n)==1) ;
@z

@x l.274
do@+{
@y
do {
@z

@x l.280
}@+while(j!=best_j);
@y
} while(j!=best_j);
@z
