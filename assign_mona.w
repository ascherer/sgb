% This file is part of the Stanford GraphBase (c) Stanford University 1992
\def\title{ASSIGN\_\thinspace MONA}
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!
\def\<#1>{$\langle${\rm#1}$\rangle$}
\def\dash{\mathrel-\joinrel\joinrel\mathrel-} % adjacent vertices
\def\ddash{=\joinrel\joinrel=} % matched vertices

\prerequisite{GB\_\thinspace MONA}
@* The assignment problem.
This demonstration program takes a matrix
constructed by the |gb_mona| module and chooses at most one number from
each row and column in such a way as to maximize the sum of the numbers
chosen. It also reports the number of ``mems'' (memory references)
expended during its computations, so that the algorithm it uses
can be compared with alternative procedures.

The matrix has $m$ rows and $n$ columns. If $m\le n$, one number will
be chosen in each row; if $m\ge n$, one number will be chosen in each column.
The numbers in the matrix are brightness levels (i.e., pixel values) in
a digitized version of the Mona Lisa.

Of course the author does not pretend that the location of ``highlights'' in
da Vinci's painting, one per row and one per column, has any application
to art appreciation. However, this program does seem to have pedagogic value,
because the relation between pixel values and shades of gray allows us
to visualize the data underlying this special case of the
assignment problem; ordinary matrices of numeric data are much harder
to perceive. The non-random nature of pixels
in a work of art may also have similarities to the ``organic'' properties
of data in real-world applications.

This program is optionally able to produce an encapsulated PostScript file
from which the solution can be displayed graphically, with halftone shading.

@ As explained in |gb_mona|, the subroutine call |mona(m,n,d,m0,m1,n0,n1,d0,d1,
area)| constructs an $m\times n$ matrix of integers between $0$ and~$d$,
inclusive, based on the brightness levels in a rectangular region of
a digitized Mona Lisa, where |m0|, |m1|, |n0|, and |n1| define that
region. The raw data is obtained as a sum of |(m1-m0)(n1-n0)| pixel
values between $0$ and~$255$, then scaled in such a way that sums |<=d0|
are mapped to zero, sums |>=d1| are mapped to~$d$, and intermediate sums are
mapped linearly to intermediate values. Default values |m1=360|, |n1=250|,
|m=m1-m0|, |n=n1-n0|, |d=255|, and |d1=255(m1-m0)(n1-n0)| are substituted if
any of the parameters |m|, |n|, |d|, |m1|, |n1|, or |d1| are zero.

The user can specify the nine parameters |(m,n,d,m0,m1,n0,n1,d0,d1)|
on the command line, at least in a \UNIX\ implementation, thereby
obtaining a variety of special effects; the relevant
command-line options are \.{m=}\<number>, \.{m0=}\<number>, and so on,
with no spaces before or after the \.= signs that separate parameter
names from parameter values. Additional options are also provided:
\.{-s} (use only Mona's $16\times32$ ``smile'');
\.{-c} (complement black/white); \.{-p} (print the matrix and solution);
\.{-P} (produce a PostScript file \.{mona.eps} for graphic output);
\.{-h} (use a heuristic that applies only when $m=n$); and
\.{-v} or \.{-V} (print verbose or Very verbose commentary about the
 algorithm's performance).
@^UNIX dependencies@>

Here is the overall layout of this \Cee\ program:

@p
#include "gb_graph.h" /* the GraphBase data structures */
#include "gb_mona.h" /* the |mona| routine */
@#
@<Global variables@>@;
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
{@+@<Local variables@>;
  @<Scan the command line options@>;
  mtx=mona(m,n,d,m0,m1,n0,n1,d0,d1,working_storage);
  if (mtx==NULL) {
    fprintf(stderr,"Sorry, can't create the matrix! (error code %d)\n",
             panic_code);
    return -1;
  }
  printf("Assignment problem for %s%s\n",mona_id,(compl?", complemented":""));
  sscanf(mona_id,"mona(%u,%u,%lu",&m,&n,&d); /* adjust for defaults */
  if (m!=n) heur=0;
  if (printing) @<Display the input matrix@>;
  if (PostScript) @<Output the input matrix in PostScript format@>;
  mems=0;
  @<Solve the assignment problem@>;
  if (printing) @<Display the solution@>;
  if (PostScript) @<Output the solution in PostScript format@>;
  printf("Solved in %d mems%s.\n",mems,
   (heur?" with square-matrix heuristic":""));
}

@ @f Vertex int /* |gb_graph| defines these data types */
@f Arc int
@f Graph int
@f Area int

@<Glob...@>=
Area working_storage; /* where to put the input data and auxiliary arrays */
long *mtx; /* input data for the assignment problem */
long mems; /* the number of memory references counted
                    while solving the problem */

@ The following local variables are related to the command-line options:

@<Local v...@>=
unsigned m=0,n=0; /* number of rows and columns desired */
unsigned long d=0; /* number of pixel values desired, minus~1 */
unsigned m0=0,m1=0; /* input will be from rows $[|m0|\,.\,.\,|m1|)$ */
unsigned n0=0,n1=0; /* and from columns $[|n0|\,.\,.\,|n1|)$ */
unsigned long d0=0,d1=0; /* lower and upper threshold of raw pixel scores */
int compl=0; /* should the input values be complemented? */
int heur=0; /* should the square-matrix heuristic be used? */
int printing=0; /* should the input matrix and solution be printed? */
int PostScript=0; /* should an encapsulated PostScript file be produced? */

@ @<Scan the command line options@>=
while (--argc) {
@^UNIX dependencies@>
  if (sscanf(argv[argc],"m=%u",&m)==1) ;
  else if (sscanf(argv[argc],"n=%u",&n)==1) ;
  else if (sscanf(argv[argc],"d=%lu",&d)==1) ;
  else if (sscanf(argv[argc],"m0=%u",&m0)==1) ;
  else if (sscanf(argv[argc],"m1=%u",&m1)==1) ;
  else if (sscanf(argv[argc],"n0=%u",&n0)==1) ;
  else if (sscanf(argv[argc],"n1=%u",&n1)==1) ;
  else if (sscanf(argv[argc],"d0=%u",&d0)==1) ;
  else if (sscanf(argv[argc],"d1=%u",&d1)==1) ;
  else if (strcmp(argv[argc],"-s")==0) smile; /* sets |m0|, |m1|, |n0|, |n1| */
  else if (strcmp(argv[argc],"-c")==0) compl=1;
  else if (strcmp(argv[argc],"-h")==0) heur=1;
  else if (strcmp(argv[argc],"-v")==0) verbose=1;
  else if (strcmp(argv[argc],"-V")==0) verbose=2; /* terrifically verbose */
  else if (strcmp(argv[argc],"-p")==0) printing=1;
  else if (strcmp(argv[argc],"-P")==0) PostScript=1;
  else {
    fprintf(stderr,
       "Usage: %s [param=value] [-s] [-c] [-h] [-v] [-p] [-P]\n",argv[0]);
    return -2;
  }
}

@ @<Display the input matrix@>=
for (k=0;k<m;k++) {
  for (l=0;l<n;l++) printf("% 4d",compl?d-*(mtx+k*n+l):*(mtx+k*n+l));
  printf("\n");
}

@ We obtain a crude but useful estimate of the computation time
by counting mem units, as explained in the |miles_span| program.

@d o mems++
@d oo mems+=2
@d ooo mems+=3

@* Algorithmic overview. The {\it assignment problem\/} is the classical
problem of weighted bipartite matching, the problem of choosing
a maximum-weight set of disjoint edges in a bipartite graph. We will consider
only the case of complete bipartite graphs, when the weights are
specified by an $m\times n$ matrix.

An algorithm is most easily developed if we begin with the assumption
that the matrix is square (i.e., that $m=n$), and if we change from
maximization to minimization. Then the assignment problem is the task
of finding a permutation $\pi[0]\ldots\pi[n-1]$ of $\{0,\ldots,n-1\}$
such that $\sum_{k=0}^{n-1} a_{k\pi[k]}$ is minimized, where
$A=(a_{kl})$ is a given matrix of numbers $a_{kl}$ for $0\le k,l<n$.
The algorithm below works for arbitrary real numbers $a_{kl}$, but we
will assume in our implementation that the matrix entries are integers.

One way to approach the assignment problem is to make three simple
observations: (a)~Adding a constant to any row of the matrix does not
change the solution $\pi[0]\ldots\pi[n-1]$. (b)~Adding a constant to
any column of the matrix does not change the solution. (c)~If $a_{kl}\ge0$
for all $k$ and~$l$, and if $\pi[0]\ldots\pi[n-1]$ is a permutation
with the property that $a_{k\pi[k]}=0$ for all~$k$, then $\pi[0]\ldots\pi[n-1]$
solves the assignment problem.

The remarkable fact is that these three observations actually suffice. In
other words, there is always a sequence of constants $(\sigma_0,\ldots,\sigma_
{n-1})$ and $(\tau_0,\ldots,\tau_{n-1})$ and a permutation $\pi[0]\ldots
\pi[n-1]$ such that
$$\vbox{\halign{$#$,\hfil&\quad for #\hfil\cr
a_{kl}-\sigma_k+\tau_{\,l}\ge0& $0\le k<n$ and $0\le l<n$;\cr
a_{k\pi[k]}-\sigma_k+\tau_{\pi[k]}=0& $0\le k<n$.\cr}}$$

@ To prove the remarkable fact just stated, we start by reviewing the
theory of {\it unweighted\/} bipartite matching. Any $m\times n$ matrix
$A=(a_{kl})$ befines a bipartite graph on the vertices $(r_0,\ldots,r_{m-1})$
and $(c_0,\ldots,c_{n-1})$ if we say that $r_k\dash c_l$ whenever
$a_{kl}=0$; in other words, the edges of the bipartite graph are the zeroes
of the matrix. Two zeroes of~$A$ are called {\it independent\/} if they appear
in different rows and columns; this means that the corresponding edges have
no vertices in common. A set of mutually independent zeroes of the matrix
therefore corresponds to a set of mutually disjoint edges, also called a
{\it matching\/} between rows and columns.

The Hungarian mathematicians Egerv\'ary and K\"onig proved
[{\sl Matematikai \'es Fizikai Lapok\/ \bf38} (1931), 16--28, 116--119]
that the maximum number of independent zeroes in a matrix is equal to
the minimum number of rows and/or columns that are needed to ``cover''
every zero. In other words, if we can find $p$ independent zeroes but
not~$p+1$, then there is a way to choose $p$ lines in such a way that
every zero of the matrix is included in at least one of the chosen lines,
where a ``line'' is either a row or a column.

Their proof was constructive, and it leads to a useful computer algorithm.
Given a set of $p$ independent zeroes of a matrix, let us write
$r_k\ddash c_l$ or $c_l\ddash r_k$ and say that $r_k$ is matched with $c_l$
if $a_{kl}$ is one of these $p$ special
zeroes, while we continue to write $r_k\dash c_l$ or $c_l\dash r_k$
if $a_{kl}$ is one of the nonspecial zeroes. A given set of $p$
special zeroes defines a choice of $p$ lines in the following way: Column~$c$
is chosen if and only if it is reachable by a path of the form
$$r_0\dash c_1\ddash r_1\dash c_2\ddash\cdots\dash c_q\ddash r_q\,,\eqno(*)$$
where $r_0$ is unmatched, $q\ge1$, and $c=c_q$. Row~$r$ is chosen if
and only if it is matched with a column that is not chosen. Thus exactly
$p$ lines are chosen. We can now prove that the chosen lines cover
all the zeroes, unless there is a way to find $p+1$ independent zeroes.

For if $c\ddash r$, either $c$ or $r$ has been chosen. And
if $c\dash r$, one of the following cases must arise. (1)~If $r$ and~$c$
are both unmatched, we can increase~$p$ by matching them to each other.
(2)~If $r$ is unmatched and $c\ddash r'$, then $c$ has been chosen, so
the zero has been covered. (3)~If $r$ is matched to $c'\ne c$, then
either $r$ has been chosen or $c'$ has been chosen. In the latter case
there is a path of the form
$$r_0\dash c_1\ddash r_1\dash c_2\ddash\cdots\ddash
       r_{q-1}\dash c'\ddash r\dash c\,,$$
where $r_0$ is unmatched and $q\ge1$.
If $c$ is matched, it has therefore been chosen; otherwise we can increase $p$
by redefining the matching to include
$$r_0\ddash c_1\dash r_1\ddash c_2\dash\cdots\dash
     r_{q-1}\ddash c'\dash r\ddash c\,.$$

@ Now suppose $A$ is a {\it nonnegative\/} matrix.
Cover the zeroes of~$A$ with a minimum number of lines, $p$, using the
algorithm of Egerv\'ary and K\"onig. If $p<n$, some elements are still
uncovered, so those elements are positive; suppose the minimum uncovered
value is $\delta>0$. We can subtract $\delta$ from each unchosen row
and add $\delta$ to each chosen column; the net effect is to subtract~$\delta$
from all uncovered elements and to add~$\delta$ to all doubly-covered
elements, while leaving all singly-covered elements unchanged. This
transformation causes a new zero to appear, while preserving
$p$ independent zeroes of the previous matrix (since they were each
covered only once). If we repeat the Egerv\'ary-K\"onig construction
with the same $p$ independent zeroes, we find that either $p$~is no
longer maximum or at least one more column has been chosen.
(The new zero $r\dash c$ occurs in a row~$r$ that was either unmatched
or matched to a previously chosen column, because row~$r$ was not
chosen.) Therefore if we repeat the process, we must eventually
be able to increase $p$ until finally $p=n$. This will solve the
assignment problem, proving the remarkable claim made earlier.

@ If the given matrix $A$ has $m$ rows and $n>m$ columns,
we can extend it artificially
until it is square, by setting $a_{kl}=0$ for all $m\le k<n$ and
$0\le l<n$. The construction above will then apply. But we need not
waste time making such an extension, because it suffices to run the
algorithm on the original $m\times n$ matrix until $m$ independent zeroes
have been found. The reason is that the set of matched vertices always
grows monotonically in the Egerv\'ary-K\"onig construction: If a
column is matched at some stage, it will remain matched from that time on,
although it may well change partners. The $n-m$ dummy rows at the bottom
of~$A$ are always chosen to be part of the covering; so the dummy entries
become nonzero only in the columns that are part of some covering.
Such columns are part of some matching, so they are part of the
final matching. Therefore at most $m$ columns of the dummy entries
become nonzero during the procedure. We can always find $n-m$ independent
zeroes in the $n-m$ dummy rows of the matrix, so we need not deal with the
dummy elements explicitly.

@ It has been convenient to describe the algorithm by saying that
we add and subtract constants to and from the colums and rows of~$A$.
But all those additions and subtractions can take a lot of time. So we will
merely pretend to make the adjustments that the method calls for; we will
represent them implicitly by two vectors $(\sigma_0,\ldots,\sigma_{m-1})$
and $(\tau_0,\ldots,\tau_{n-1})$. Then the current value of each matrix
entry will be $a_{kl}-\sigma_k+\tau_{\,l}$, instead of $a_{kl}$. The
``zeroes'' will be positions such that $a_{kl}=\sigma_k-\tau_{\,l}$.

Initially we will set $\tau_{\,l}=0$ for $0\le l<n$ and $\sigma_k=
\min\{a_{k0},\ldots,a_{k(n-1)}\}$ for $0\le k<m$. If $m=n$ we can also
make sure that there's a zero in every column by subtracting
$\min\{a_{0l},\ldots,a_{(n-1)l}\}$ from $a_{kl}$ for all $k$ and~$l$.
(This initial adjustment can conveniently be made to the original
matrix entries, instead of indirectly via the $\tau$'s.) Users can
discover if such a transformation is worthwhile by trying the program
both with and without the \.{-h} option.

We have been saying a lot of things and proving a bunch of theorems,
without writing any code. Let's get back into programming mode
by writing the routine that is called into
action when the \.{-h} option has been specified:

@d aa(k,l) *(mtx+k*n+l) /* a macro to access the matrix elements */

@<Subtract column minima in order to start with lots of zeroes@>=
{
  for (l=0; l<n; l++) {
    o,s=aa(0,l); /* the |o| macro counts one mem */
    for (k=1;k<n;k++) 
      if (o,aa(k,l)<s) s=aa(k,l);
    if (s>0)
      for (k=0;k<n;k++)
        oo,aa(k,l)-=s; /* |oo| counts two mems */
  }
  if (verbose) printf(" The heuristic has cost %d mems.\n",mems);
}

@ @<Local var...@>=
register int k; /* the current row of interest */
register int l; /* the current column of interest */
register int j; /* another interesting column */
register long s; /* the current matrix element of interest */

@* Algorithmic details.
The algorithm sketched above is quite simple, except that we did not
discuss how to determine the chosen columns~$c_q$ that
are reachable by paths of the stated form $(*)$. It is easy to find
all such columns by constructing an unordered forest whose nodes are rows,
beginning with all unmatched rows~$r_0$ and adding a row~$r$
for which $c\ddash r$ when $c$ is adjacent to a row already in the forest.

Our data structure, which is based on suggestions of Papadimitriou and
Steiglitz [{\sl Combinatorial Optimization\/} (Prentice-Hall, 1982),
$\mathchar"278$11.1], will use several arrays. If row~$r$ is matched
with column~$c$ we will have |matching_col[r]=c| and |matching_row[c]=r|;
if row~$r$ is unmatched, |matching_col[r]| will be |-1|, and
if column~$c$ is unmatched, |matching_row[c]| will be |-1|.
If column~$c$ has a mate and is also reachable in a path of the form $(*)$,
we will have $|parent_row|[c]=r'$ for some $r'$ in the forest. Otherwise
column~$c$ is not chosen, and we will have |parent_row[c]=-1|. The rows
in the current forest will be called |unchosen_row[0]| through
|unchosen_row[t-1]|, where |t| is the current total number of nodes.

The amount $\sigma_k$ subtracted from row $k$ is called |row_dec[k]|; the
amount $\tau_{\,l}$ added to row~$l$ is called |col_inc[l]|. In order to
compute the minimum uncovered element efficiently, we maintain a
quantity called |slack[l]| representing the minimum uncovered element
in each column. More precisely, if column~$l$ is not chosen,
|slack[l]| is the minimum of $a_{kl}
-\sigma_k+\tau_{\,l}$ for $k\in\{|unchosen_row|[0],\ldots,
|unchosen_row|[q-1]\}$, where $q\le t$ is the number of rows in the
forest that we have explored so far. We also remember |slack_row[l]|,
the number of a row where the stated minimum occurs.

Column $l$ is chosen if and only if |parent_row[l]>=0|. We will arrange
things so that we also have |slack[l]=0| in every chosen column.

@<Local var...@>=
int* matching_col; /* the column matching a given row, or $-1$ */
int* matching_row; /* the row matching a given column, or $-1$ */
int* parent_row; /* ancestor of a given column's mate, or $-1$ */
int* unchosen_row; /* node in the forest */
int t; /* total number of nodes in the forest */
int q; /* total number of explored nodes in the forest */
long* row_dec; /* $\sigma_k$, the amount subtracted from a given row */
long* col_inc; /* $\tau_{\,l}$, the amount added to a given column */
long* slack; /* minimum uncovered entry seen in a given column */
int* slack_row; /* where the |slack| in a given column can be found */
int unmatched; /* this many rows have yet to be matched */

@ @<Allocate the intermediate data structures@>=
matching_col=gb_alloc_type(m,@[int@],working_storage);
matching_row=gb_alloc_type(n,@[int@],working_storage);
parent_row=gb_alloc_type(n,@[int@],working_storage);
unchosen_row=gb_alloc_type(m,@[int@],working_storage);
row_dec=gb_alloc_type(m,@[long@],working_storage);
col_inc=gb_alloc_type(n,@[long@],working_storage);
slack=gb_alloc_type(n,@[long@],working_storage);
slack_row=gb_alloc_type(n,@[int@],working_storage);
if (gb_alloc_trouble) {
  fprintf(stderr,"Sorry, out of memory!\n"); return -3;
}

@ The algorithm operates in stages, where each stage terminates
when we are able to increase the number of matched elements.

The first stage is different from the others; it simply goes through
the matrix and looks for zeroes, matching as many rows and columns
as it can. This stage also initializes table entries that will be
useful in later stages.

@d INF 0x7fffffff /* infinity (or darn near) */

@<Do the initial stage@>=
t=0; /* the forest starts out empty */
for (l=0; l<n; l++) {
  o,matching_row[l]=-1;
  o,parent_row[l]=-1;
  o,col_inc[l]=0;
  o,slack[l]=INF;
}
for (k=0; k<m; k++) {
  o,s=aa(k,0); /* get ready to calculate the minimum entry of row $k$ */
  for (l=1; l<n; l++) if (o,aa(k,l)<s) s=aa(k,l);
  o,row_dec[k]=s;
  for (l=0; l<n; l++)
    if ((o,s==aa(k,l)) && (o,matching_row[l]<0)) {
      o,matching_col[k]=l;
      o,matching_row[l]=k;
      if (verbose>1) printf(" matching col %d==row %d\n",l,k);
      goto row_done;
    }
  o,matching_col[k]=-1;
  if (verbose>1) printf("  node %d: unmatched row %d\n",t,k);
  o,unchosen_row[t++]=k;
row_done:;
}

@ If a subsequent stage has not succeeded in matching every row,
we prepare for a new stage by reinitializing the forest as follows.

@<Get ready for another stage@>=
t=0;
for (l=0; l<n; l++) {
  o,parent_row[l]=-1;
  o,slack[l]=INF;
}
for (k=0; k<m; k++)
  if (o,matching_col[k]<0) {
    if (verbose>1) printf("  node %d: unmatched row %d\n",t,k);
    o,unchosen_row[t++]=k;
  }

@ Here, then, is the algorithm's overall control structure.
There are at most $m$ stages, and each stage does $O(mn)$ operations,
so the total running time is $O(m^2n)$.

@<Do the Hungarian algorithm@>=
@<Do the initial stage@>;
if (t==0) goto done;
unmatched=t;
while(1) {
  if (verbose) printf(" After %d mems I've matched %d rows.\n",mems,m-t);
  q=0;
  while(1) {
    while (q<t) {
      @<Explore node |q| of the forest;
        if the matching can be increased, |goto breakthru|@>;
      q++;
    }
    @<Introduce a new zero into the matrix by modifying |row_dec| and |col_inc|;
        if the matching can be increased, |goto breakthru|@>;
  }
breakthru: @<Update the matching by pairing row $k$ with column $l$@>;
  if(--unmatched==0) goto done;
  @<Get ready for another stage@>;
}
done: @<Doublecheck the solution@>;

@ @<Explore node |q| of the forest;
      if the matching can be increased, |goto breakthru|@>=
{
  o,k=unchosen_row[q];
  o,s=row_dec[k];
  for (l=0; l<n; l++)
    if (o,slack[l]) {@+register long del;
      oo,del=aa(k,l)-s+col_inc[l];
      if (del<slack[l]) {
        if (del==0) { /* we found a new zero */
          if (o,matching_row[l]<0) goto breakthru;
          o,slack[l]=0; /* this column will now be chosen */
          o,parent_row[l]=k;
          if (verbose>1) printf("  node %d: row %d==col %d--row %d\n",
                                    t,matching_row[l],l,k);
          oo,unchosen_row[t++]=matching_row[l];
        } else {
          o,slack[l]=del;
          o,slack_row[l]=k;
        }
      }
    }
}

@ At this point, column $l$ is unmatched, and row $k$ is in
the forest. By following parent links in the forest,
we can rematch rows and columns so that a previously unmatched row~$r_0$
gets a mate.

@<Update the matching by pairing row $k$ with column $l$@>=
if (verbose) printf(" Breakthrough at node %d of %d!\n",q,t);
while (1) {
  o,j=matching_col[k];
  o,matching_col[k]=l;
  o,matching_row[l]=k;
  if (verbose>1) printf(" rematching col %d==row %d\n",l,k);
  if (j<0) break;
  o,k=parent_row[j];
  l=j;
}

@ If we get to this point, we have explored the entire forest; none of
the unchosen rows has led to a breakthrough. An unchosen column with
smallest |slack| will allow us to make further progress.

@<Introduce a new zero into the matrix by modifying |row_dec| and |col_inc|;
        if the matching can be increased, |goto breakthru|@>=
s=INF;
for (l=0; l<n; l++)
  if (o,slack[l] && slack[l]<s)
    s=slack[l];
for (q=0; q<t; q++)
  ooo,row_dec[unchosen_row[q]]+=s;
for (l=0; l<n; l++)
  if (o,slack[l])  { /* column $l$ is not chosen */
    o,slack[l]-=s;
    if (slack[l]==0) @<Look at a new zero, and |goto breakthru| with
                         |col_inc| up to date if there's a breakthrough@>;
  } else oo,col_inc[l]+=s;

@ There may be several columns tied for smallest slack. If any of them
leads to a breakthough, we are very happy; but we must finish the loop on~|l|
before going to |breakthru|, because the |col_inc| variables
need to be maintained for the next stage.

Within column |l|, there may be several rows that produce the same slack;
we have remembered only one of them, |slack_row[l]|. Fortunately, one is
sufficient for our purposes. We either have a breakthrough, or we choose
column~|l|, regardless of which row or rows led us to consider that column.

@<Look at a new zero, and |goto breakthru| with
                         |col_inc| up to date if there's a breakthrough@>=
{
  o,k=slack_row[l];
  if (verbose>1)
    printf(" Decreasing uncovered elements by %d produces zero at [%d,%d]\n",
      s,k,l);
  if (o,matching_row[l]<0) {
    for (j=l+1; j<n; j++)
      if (o,slack[j]==0) oo,col_inc[j]+=s;
    goto breakthru;
  } else { /* not a breakthrough, but the forest continues to grow */
    o,parent_row[l]=k;
    if (verbose>1) printf("  node %d: row %d==col %d--row %d\n",
                                  t,matching_row[l],l,k);
    oo,unchosen_row[t++]=matching_row[l];
  }
}

@ The code in the present section is redundant, unless cosmic
radiation has cause the hardware to malfunction. But there is some
reassurance whenever we find that mathematics still appears to be
consistent, so the author could not resist writing these few unnecessary lines,
which verify that the assignment problem has indeed been solved optimally.
(We don't count the mems.)

@<Doublecheck...@>=
for (k=0;k<m;k++)
  for (l=0;l<n;l++)
    if (aa(k,l)<row_dec[k]-col_inc[l]) {
      fprintf(stderr,"Oops, I made a mistake!\n");
      return -6; /* can't happen */
    }
for (k=0;k<m;k++) {
  l=matching_col[k];
  if (l<0 || aa(k,l)!=row_dec[k]-col_inc[l]) {
    fprintf(stderr,"Oops, I blew it!\n"); return-66; /* can't happen */
  }
}
k=0;
for (l=0;l<n;l++) if (col_inc[l]) k++;
if (k>m) {
  fprintf(stderr,"Oops, I adjusted too many columns!\n");
  return-666; /* can't happen */
}

@* Interfacing.
A few nitty-gritty details still need to be handled: Our algorithm
is not symmetric between rows and columns, and it works only for $m\le n$;
so we will transpose the matrix when
$m>n$. Furthermore, our algorithm minimizes, but we actually want
it to maximize (except when |compl| is nonzero).

Hence, we want to make the following transformations to the data before
processing it with the algorithm developed above.

@<Solve the assignment problem@>=
if (m>n) @<Transpose the matrix@>@;
else transposed=0;
@<Allocate the intermediate data structures@>;
if (compl==0)
  for (k=0; k<m; k++) for (l=0; l<n; l++)
    aa(k,l)=d-aa(k,l);
if (heur) @<Subtract column minima...@>;
@<Do the Hungarian algorithm@>;

@ @<Transpose...@>=
{
  if (verbose>1) printf("Temporarily transposing rows and columns...\n");
  tmtx=gb_alloc_type(m*n,@[long@],working_storage);
  if (tmtx==NULL) {
    fprintf(stderr,"Sorry, out of memory!\n"); return -4;
  }
  for (k=0; k<m; k++) for (l=0; l<n; l++)
    *(tmtx+l*m+k)=*(mtx+k*n+l);
  m=n;@+n=k; /* |k| holds the former value of |m| */
  mtx=tmtx;
  transposed=1;
}

@ @<Local v...@>=
long* tmtx; /* the transpose of |mtx| */
int transposed; /* has the data been transposed? */

@ @<Display the solution@>=
{
  printf("The following entries produce an optimum assignment:\n");
  for (k=0; k<m; k++)
    printf(" [%d,%d]\n",@|
     transposed? matching_col[k]:k,@|
     transposed? k:matching_col[k]);
}

@* Encapsulated PostScript.
A special output file called \.{mona.eps} is written if the user has
selected the \.{-P} option. This file will contain a sequence of
PostScript commands that can be used to generate an illustration
within many kinds of documents. For example, if \TeX\ is being used
with the \.{dvips} output driver from Radical Eye Software and the
@.dvips@>
associated \.{epsf.tex} macros, one can say
$$\.{\\epsfxsize=10cm \\epsfbox\{mona.eps\}}$$
within a \TeX\ document and the illustration will be typeset in
a box that is 10 centimeters wide.

The conventions of PostScript allow the illustration to be scaled to
any size. Best results are probably obtained if each pixel is at
least one millimeter wide (about 1/25 inch) when printed.

The illustration is formed by first
``painting'' the input data as a rectangle of pixels,
with up to 256 shades of gray. Then the solution pixels are
framed in black, with a white trim just inside the black edges
to help make the frame visible in already-dark places. The frames are
created by painting over the original image; the
center of each solution pixel retains its original color.

Encapsulated PostScript files have a simple format that is recognized
by many software packages and printing devices. We use a subset of
PostScript that should be easy to convert to other languages if necessary.

@<Output the input matrix in PostScript format@>=
{
  eps_file=fopen("mona.eps","w");
  if (!eps_file) {
    fprintf("Sorry, I can't open the file `mona.eps'!\n");
    PostScript=0;
  } else {
    fprintf(eps_file,"%%!PS-Adobe-3.0 EPSF-3.0\n"); /* 1.0 and 2.0 also OK */
    fprintf(eps_file,"%%%%BoundingBox: -1 -1 %d %d\n",n+1,m+1);
    fprintf(eps_file,"/buffer %d string def\n",n);
    fprintf(eps_file,"%d %d 8 [%d 0 0 -%d 0 %d]\n",n,m,n,m,m);
    fprintf(eps_file,"{currentfile buffer readhexstring pop} bind\n");
    fprintf(eps_file,"gsave %d %d scale image\n",n,m);
    for (k=0;k<m;k++) @<Output row |k| as a hexadecimal string@>;
    fprintf(eps_file,"grestore\n");
  }
}

@ @<Glob...@>=
FILE *eps_file; /* file for encapsulated PostScript output */

@ This program need not produce machine-independent output, so we may
safely use floating-point arithmetic here. At most 64 characters
(32 pixel-bytes) are output on each line.

@<Output row |k|...@>=
{@+register float conv=255.0/(float)d; register int x;
  for (l=0; l<n; l++) {
    x=(int)(conv*(float)(compl?d-aa(k,l):aa(k,l)));
    fprintf(eps_file,"%02x",x>255?255:x);
    if ((l&0x1f)==0x1f) fprintf(eps_file,"\n");
  }
  if (n&0x1f) fprintf(eps_file,"\n");
}

@ @<Output the solution in PostScript format@>=
{
  fprintf(eps_file,
    "/bx {moveto 0 1 rlineto 1 0 rlineto 0 -1 rlineto closepath\n");
  fprintf(eps_file," gsave .3 setlinewidth 1 setgray clip stroke");
  fprintf(eps_file," grestore stroke} bind def\n");
  fprintf(eps_file," .1 setlinewidth\n");
  for (k=0; k<m; k++)
    fprintf(eps_file," %d %d bx\n",@|
     transposed? k:matching_col[k],@|
     transposed? n-1-matching_col[k]:m-1-k);
  fclose(eps_file);
}

@* Index. As usual, we close with a list of identifier definitions and uses.

