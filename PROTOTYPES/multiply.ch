@x l.38
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
@y
int main(@t\1\1@>
  int argc, /* the number of command-line arguments */
  char *argv[]@t\2\2@>) /* an array of strings containing those arguments */
@z

@x l.200
decimal_to_binary(x,s,n)
  char *x; /* decimal string */
  char *s; /* binary string */
  long n; /* length of |s| */
@y
void decimal_to_binary(@t\1\1@>
  char *x, /* decimal string */
  char *s, /* binary string */
  long n@t\2\2@>) /* length of |s| */
@z

@x l.282
long depth(g)
  Graph *g; /* graph with gates as vertices */
@y
long depth(Graph *g)
  /* graph with gates as vertices */
@z
