@x l.61
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
@y
int main(@t\1\1@>
  int argc, /* the number of command-line arguments */
  char *argv[]@t\2\2@>) /* an array of strings containing those arguments */
@z

@x l.140
Vertex *prompt_for_team(s)
  char *s; /* string used in prompt message */
@y
Vertex *prompt_for_team(char *s)
  /* string used in prompt message */
@z

@x l.207
node *new_node(x,d)
  node *x; /* an old node that the new node will call |prev| */
  long d; /* incremental change to |tot_len| */
@y
node *new_node(@t\1\1@>
  node *x, /* an old node that the new node will call |prev| */
  long d@t\2\2@>) /* incremental change to |tot_len| */
@z

@x l.237
do@+{@+register node*t;
@y
do {@+register node*t;
@z

@x l.242
}@+while (cur_node);
@y
} while (cur_node);
@z

@x l.312
do@+{
@y
do {
@z

@x l.320
}@+while (u);
@y
} while (u);
@z

@x l.355
  do@+{
@y
  do {
@z

@x l.363
  }@+while (m>0); /* exactly one node should be in |list[0]| (see below) */
@y
  } while (m>0); /* exactly one node should be in |list[0]| (see below) */
@z
