@x l.17
@d plane_lisa p_lisa /* abbreviation for Procrustean external linkage */

@(gb_lisa.h@>=
#define plane_lisa p_lisa
extern long* lisa();
extern Graph *plane_lisa();
extern Graph *bi_lisa();
@y
@(gb_lisa.h@>=
#ifndef GB_LISA_H
#define GB_LISA_H
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
#define plane_lisa p_lisa
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

@x l.124
extern char lisa_id[];
@y
extern char lisa_id[];
@#
#endif /* |GB_LISA_H| */
@z

@x l.142
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
#include "gb_graph.h" /* we will use the {\sc GB\_\,GRAPH} data structures */
@y
#include "gb_lisa.h" /* we use our own interface |@(gb_lisa.h@>| first */
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
long *lisa(
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
  Area area)
    /* where to allocate the matrix that will be output */
@z

@x l.183
sprintf(lisa_id,"lisa(%lu,%lu,%lu,%lu,%lu,%lu,%lu,%lu,%lu)",
   m,n,d,m0,m1,n0,n1,d0,d1);
@y
sprintf(lisa_id,"lisa(%lu,%lu,%lu,%lu,%lu,%lu,%lu,%lu,%lu)",
   m&0x1ff,n&0x1ff,d&0xffffffff,m0&0x1ff,m1&0x1ff,n0&0x1ff,n1&0x1ff,
   d0&0xffffffff,d1&0xffffffff);
@z

@x l.229
for (l=lam=0; l<n; l++) {@+register long sum=0;
@y
for (l=lam=0; l<(long)n; l++) {@+register long sum=0;
@z

@x l.231
  do@+{@+register long nl; /* giant column where something new might happen */
@y
  do {@+register long nl; /* giant column where something new might happen */
@z

@x l.237
  }@+while (lam<next_lam);
@y
  } while (lam<next_lam);
@z

@x l.250
for (k=kap=0; k<m;k++) {
  for (l=0;l<n;l++) *(out_row+l)=0; /* clear the vector of sums */
@y
for (k=kap=0; k<(long)m;k++) {
  for (l=0;l<(long)n;l++) *(out_row+l)=0; /* clear the vector of sums */
@z

@x l.253
  do@+{@+register long nk; /* giant row where something new might happen */
@y
  do {@+register long nk; /* giant row where something new might happen */
@z

@x l.263
  }@+while (kap<next_kap);
@y
  } while (kap<next_kap);
@z

@x l.264
  for (l=0; l<n; l++,out_row++) /* note that |out_row| will advance by~|n| */
@y
  for (l=0; l<(long)n; l++,out_row++) /* note that |out_row| will advance by~|n| */
@z

@x l.283
@d el_gordo 0x7fffffff /* $2^{31}-1$, the largest single-precision |long| */
@y
@d el_gordo (long)(((unsigned long)-1)>>1) /* the largest single-precision |long| */
@z

@x l.286
static long na_over_b(n,a,b)
  long n,a,b;
@y
static long na_over_b(long n,long a,long b)
@z

@x l.295
  do@+{@+bit[k]=n&1; /* save the least significant bit of $n$ */
@y
  do {@+bit[k]=n&1; /* save the least significant bit of $n$ */
@z

@x l.298
  }@+while (n>nmax);
@y
  } while (n>nmax);
@z

@x l.309
do@+{@+k--;@+ q<<=1;
@y
do {@+k--;@+ q<<=1;
@z

@x l.316
}@+while (k);
@y
} while (k);
@z

@x l.319
if (*out_row<=d0) *out_row=0;
else if (*out_row>=d1) *out_row=d;
@y
if (*out_row<=(long)d0) *out_row=0;
else if (*out_row>=(long)d1) *out_row=d;
@z

@x l.334
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
@p Graph *plane_lisa(
  unsigned long m,unsigned long n,
    /* number of rows and columns desired */
  unsigned long d,
    /* maximum value desired */
  unsigned long m0,unsigned long m1,
    /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,unsigned long n1,
    /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long d0,unsigned long d1)
    /* lower and upper threshold of raw pixel scores */
@z

@x l.431
@ @<gb_lisa.h@>=
#define pixel_value @t\quad@> x.I /* definitions for the header file */
#define first_pixel @t\quad@> y.I
#define last_pixel @t\quad@> z.I
#define matrix_rows @t\quad@> uu.I
#define matrix_cols @t\quad@> vv.I
@y
@ (This section remains empty for historic reasons.)
@z

@x l.496
    if (k<m) {
@y
    if (k<(long)m) {
@z

@x l.498
        for (j=l; f[j]!=j; j=f[j]) ; /* find the first element */
@y
        for (j=l; f[j]!=(unsigned long)j; j=f[j]) ; /* find the first element */
@z

@x l.501
      }@+else if (f[l]==l) *apos=-1-*apos,regs++; /* new region found */
@y
      }@+else if (f[l]==(unsigned long)l) *apos=-1-*apos,regs++; /* new region found */
@z

@x l.504
    if (k>0&&l<n-1&&*(apos-n)==*(apos-n+1)) f[l+1]=l;
@y
    if (k>0&&l<(long)n-1&&*(apos-n)==*(apos-n+1)) f[l+1]=l;
@z

@x l.533
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
@p Graph *bi_lisa(
  unsigned long m,unsigned long n,
    /* number of rows and columns desired */
  unsigned long m0,unsigned long m1,
    /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
  unsigned long n0,unsigned long n1,
    /* and from columns $[|n0|\,.\,.\,|n1|)$ */
  unsigned long thresh,
    /* threshold defining adjacency */
  long c)
    /* should we prefer dark pixels to light pixels? */
@z

@x l.628
for (k=0,v=new_graph->vertices;k<m;k++,v++) {
@y
for (k=0,v=new_graph->vertices;k<(long)m;k++,v++) {
@z

@x l.632
for (l=0;l<n;l++,v++) {
@y
for (l=0;l<(long)n;l++,v++) {
@z

@x l.644
    if (c?*apos<thresh:*apos>=thresh) {
@y
    if (c?*apos<(long)thresh:*apos>=(long)thresh) {
@z
