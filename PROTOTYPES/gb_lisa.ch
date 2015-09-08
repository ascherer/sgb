@x l.21
extern long* lisa();
extern Graph *plane_lisa();
extern Graph *bi_lisa();
@y
extern long* lisa(unsigned long,unsigned long,unsigned long,@|
   unsigned long,unsigned long,unsigned long,unsigned long,@|
   unsigned long,unsigned long,Area);@/
extern Graph *plane_lisa(unsigned long,unsigned long,unsigned long,@|
   unsigned long,unsigned long,unsigned long,@|
   unsigned long,unsigned long,unsigned long);
extern Graph *bi_lisa(unsigned long,unsigned long,@|
   unsigned long,unsigned long,unsigned long,unsigned long,@|
   unsigned long,long);
@z

@x l.149
long *lisa(m,n,d,m0,m1,n0,n1,d0,d1,area)
  unsigned long m,n; /* number of rows and columns desired */
  unsigned long d; /* maximum pixel value desired */
  unsigned long m0,m1; /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,n1; /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,d1; /* lower and upper threshold of raw pixel scores */
  Area area; /* where to allocate the matrix that will be output */
@y
long *lisa(@t\1\1@>
  unsigned long m,unsigned long n,
    /* number of rows and columns desired */
  unsigned long d,
    /* maximum pixel value desired */
  unsigned long m0,unsigned long m1,
    /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,unsigned long n1,
    /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,unsigned long d1,
    /* lower and upper threshold of raw pixel scores */
  Area area@t\2\2@>)
    /* where to allocate the matrix that will be output */
@z

@x
for (l=lam=0; l<n; l++) {@+register long sum=0;
@y
for (l=lam=0; l<(long)n; l++) {@+register long sum=0;
@z

@x
for (k=kap=0; k<m;k++) {
  for (l=0;l<n;l++) *(out_row+l)=0; /* clear the vector of sums */
@y
for (k=kap=0; k<(long)m;k++) {
  for (l=0;l<(long)n;l++) *(out_row+l)=0; /* clear the vector of sums */
@z

@x
  for (l=0; l<n; l++,out_row++) /* note that |out_row| will advance by~|n| */
@y
  for (l=0; l<(long)n; l++,out_row++) /* note that |out_row| will advance by~|n| */
@z

@x l.286
static long na_over_b(n,a,b)
  long n,a,b;
@y
static long na_over_b(long n,long a,long b)
@z

@x
if (*out_row<=d0) *out_row=0;
else if (*out_row>=d1) *out_row=d;
@y
if (*out_row<=(long)d0) *out_row=0;
else if (*out_row>=(long)d1) *out_row=d;
@z

@x
for (i=0;i<m0;i++)
@y
for (i=0;i<(long)m0;i++)
@z

@x l.405
@p Graph *plane_lisa(m,n,d,m0,m1,n0,n1,d0,d1)
  unsigned long m,n; /* number of rows and columns desired */
  unsigned long d; /* maximum value desired */
  unsigned long m0,m1; /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,n1; /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,d1; /* lower and upper threshold of raw pixel scores */
@y
@p Graph *plane_lisa(@t\1\1@>
  unsigned long m,unsigned long n,
    /* number of rows and columns desired */
  unsigned long d,
    /* maximum value desired */
  unsigned long m0,unsigned long m1,
    /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,unsigned long n1,
    /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,unsigned long d1@t\2\2@>)
    /* lower and upper threshold of raw pixel scores */
@z

@x
    if (k<m) {
@y
    if (k<(long)m) {
@z

@x
        for (j=l; f[j]!=j; j=f[j]) ; /* find the first element */
@y
        for (j=l; f[j]!=(unsigned long)j; j=f[j]) ; /* find the first element */
@z

@x
      }@+else if (f[l]==l) *apos=-1-*apos,regs++; /* new region found */
@y
      }@+else if (f[l]==(unsigned long)l) *apos=-1-*apos,regs++; /* new region found */
@z

@x
    if (k>0&&l<n-1&&*(apos-n)==*(apos-n+1)) f[l+1]=l;
@y
    if (k>0&&l<(long)n-1&&*(apos-n)==*(apos-n+1)) f[l+1]=l;
@z

@x
for (l=0;l<n;l++) u[l]=NULL;
for (k=0,apos=a,aloc=0;k<m;k++)
  for (l=0;l<n;l++,apos++,aloc++) {
@y
for (l=0;l<(long)n;l++) u[l]=NULL;
for (k=0,apos=a,aloc=0;k<(long)m;k++)
  for (l=0;l<(long)n;l++,apos++,aloc++) {
@z

@x l.562
static void adjac(u,v)
  Vertex *u,*v;
@y
static void adjac(Vertex *u,Vertex *v)
@z

@x l.591
@p Graph *bi_lisa(m,n,m0,m1,n0,n1,thresh,c)
  unsigned long m,n; /* number of rows and columns desired */
  unsigned long m0,m1; /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,n1; /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long thresh; /* threshold defining adjacency */
  long c; /* should we prefer dark pixels to light pixels? */
@y
@p Graph *bi_lisa(@t\1\1@>
  unsigned long m,unsigned long n,
    /* number of rows and columns desired */
  unsigned long m0,unsigned long m1,
    /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,unsigned long n1,
    /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long thresh,
    /* threshold defining adjacency */
  long c@t\2\2@>)
    /* should we prefer dark pixels to light pixels? */
@z

@x
for (k=0,v=new_graph->vertices;k<m;k++,v++) {
@y
for (k=0,v=new_graph->vertices;k<(long)m;k++,v++) {
@z

@x
for (l=0;l<n;l++,v++) {
@y
for (l=0;l<(long)n;l++,v++) {
@z

@x
    if (c?*apos<thresh:*apos>=thresh) {
@y
    if (c?*apos<(long)thresh:*apos>=(long)thresh) {
@z
