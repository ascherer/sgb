@x l.38
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
@y
int main(
  int argc, /* the number of command-line arguments */
  char *argv[]) /* an array of strings containing those arguments */
@z

@x l.117
@d retry(s,t)
    {@+printf(s);@+goto t;@+}
@y
@d retry(s,t)
    {@+fputs(s,stdout);@+goto t;@+}
@z

@x l.134
strcpy(x,p);
@y
strcpy(x,p);@+strcpy(z,x);
decimal_to_binary(z,buffer,m);
if (*z) {
  sprintf(buffer,"(Sorry, %s has more than %ld bits.)\n",x,m);
  retry(buffer,step1);
}
@z

@x l.153
strcpy(y,p);
@y
strcpy(y,p);@+strcpy(z,y);
decimal_to_binary(z,buffer+m,n);
if (*z) {
  sprintf(buffer+m,"(Sorry, %s has more than %ld bits.)\n\n",y,n);
  retry(buffer+m,step2);
}
@z

@x l.183
  printf("Please try another seed value; %d makes the answer zero!\n",seed);
@y
  printf("Please try another seed value; %ld makes the answer zero!\n",seed);
@z

@x l.200
decimal_to_binary(x,s,n)
  char *x; /* decimal string */
  char *s; /* binary string */
  long n; /* length of |s| */
@y
void decimal_to_binary(
  char *x, /* decimal string */
  char *s, /* binary string */
  long n) /* length of |s| */
@z

@x l.227
if (*z) {
  printf("(Sorry, %s has more than %ld bits.)\n",x,m);
  continue;
}
@y
@z

@x l.234
  if (*z) {
    printf("(Sorry, %s has more than %ld bits.)\n",y,n);
    continue;
  }
@y
@z

@x l.282
long depth(g)
  Graph *g; /* graph with gates as vertices */
@y
long depth(
  Graph *g) /* graph with gates as vertices */
@z
