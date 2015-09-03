@x l.58
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
@y
int main(@t\1\1@>
  int argc, /* the number of command-line arguments */
  char *argv[]@t\2\2@>) /* an array of strings containing those arguments */
@z

@x l.111
char *vertex_name(v,i) /* return (as a string) the name of vertex |v| */
  Vertex *v;
  char i; /* |i| should be 0, 1, or 2 to avoid clash in |code_name| array */
@y
char *vertex_name(@t\1\1@> /* return (as a string) the name of vertex |v| */
  Vertex *v,
  char i@t\2\2@>) /* |i| should be 0, 1, or 2 to avoid clash in |code_name| array */
@z

@x
  code_name[i][0]=imap_chr(v->short_code/36);
  code_name[i][1]=imap_chr(v->short_code%36);
  return code_name[i];
@y
  code_name[(unsigned char)i][0]=imap_chr(v->short_code/36);
  code_name[(unsigned char)i][1]=imap_chr(v->short_code%36);
  return code_name[(unsigned char)i];
@z
