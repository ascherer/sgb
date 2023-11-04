@x l.52
#include "gb_books.h" /* the |book| routine */
#include "gb_io.h" /* the |imap_chr| routine */
@y
#include "gb_books.h" /* the |book| routine */
@z

@x l.58
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
@y
int main(
  int argc, /* the number of command-line arguments */
  char *argv[]) /* an array of strings containing those arguments */
@z

@x l.111
char *vertex_name(v,i) /* return (as a string) the name of vertex |v| */
  Vertex *v;
  char i; /* |i| should be 0, 1, or 2 to avoid clash in |code_name| array */
@y
char *vertex_name( /* return (as a string) the name of vertex |v| */
  Vertex *v,
  unsigned char i) /* |i| should be 0, 1, or 2 to avoid clash in |code_name| array */
@z
