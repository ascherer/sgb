@x l.80
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
{@+unsigned long n=79; /* the desired number of sectors */
@y
int main(@t\1\1@>
  int argc, /* the number of command-line arguments */
  char *argv[]@t\2\2@>) /* an array of strings containing those arguments */
{@+long n=79; /* the desired number of sectors */
@z

@x
  if (sscanf(argv[argc],"-n%lu",&n)==1) ;
@y
  if (sscanf(argv[argc],"-n%ld",&n)==1) ;
@z
