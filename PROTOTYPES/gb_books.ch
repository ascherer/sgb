@x l.17
extern Graph *book();
extern Graph *bi_book();
@y
#ifndef GB_BOOKS_H
#define GB_BOOKS_H
typedef struct graph_struct Graph;
extern Graph *book(char *,unsigned long,unsigned long,@|
   unsigned long,unsigned long,long,long,long);
extern Graph *bi_book(char *,unsigned long,unsigned long,@|
  unsigned long,unsigned long,long,long,long);
@z

@x l.148
#include "gb_io.h" /* we will use the {\sc GB\_\,IO} routines for input */
@y
#include "gb_books.h" /* we use our own interface |@(gb_books.h@>| first */
@z

@x l.158
static Graph *bgraph(bipartite,
    title,n,x,first_chapter,last_chapter,in_weight,out_weight,seed)
  long bipartite; /* should we make the graph bipartite? */
  char *title; /* identification of the selected book */
  unsigned long n; /* number of vertices desired before exclusion */
  unsigned long x; /* number of vertices to exclude */
  unsigned long first_chapter, last_chapter;
    /* interval of chapters leading to edges */
  long in_weight; /* weight coefficient pertaining to chapters
                          in that interval */
  long out_weight; /* weight coefficient pertaining to chapters
                          not in that interval */
  long seed; /* random number seed */
@y
static Graph *bgraph(
  long bipartite, /* should we make the graph bipartite? */
  char *title, /* identification of the selected book */
  unsigned long n, /* number of vertices desired before exclusion */
  unsigned long x, /* number of vertices to exclude */
  unsigned long first_chapter, unsigned long last_chapter,
    /* interval of chapters leading to edges */
  long in_weight, /* weight coefficient pertaining to chapters in that interval */
  long out_weight, /* weight coefficient pertaining to chapters not in that interval */
  long seed) /* random number seed */
@z

@x l.185
Graph *book(title,n,x,first_chapter,last_chapter,in_weight,out_weight,seed)
  char *title;
  unsigned long n, x, first_chapter, last_chapter;
  long in_weight,out_weight,seed;
@y
Graph *book(char *title,unsigned long n,unsigned long x,@|
  unsigned long first_chapter,unsigned long last_chapter,@|
  long in_weight,long out_weight,long seed)
@z

@x l.191
Graph *bi_book(title,n,x,first_chapter,last_chapter,in_weight,out_weight,seed)
  char *title;
  unsigned long n, x, first_chapter, last_chapter;
  long in_weight,out_weight,seed;
@y
Graph *bi_book(char *title,unsigned long n,unsigned long x,@|
  unsigned long first_chapter,unsigned long last_chapter,@|
  long in_weight,long out_weight,long seed)
@z

@x l.201
register long j,k; /* all-purpose indices */
@y
register long j; /* all-purpose indices */
register unsigned long k; /* all-purpose indices */
@z

@x l.306
@d desc z.S /* utility field |z| points to the \<description> string */
@d in_count y.I /* utility field |y| counts appearances in selected chapters */
@d out_count x.I /* utility field |x| counts appearances in other chapters */
@d short_code u.I /* utility field |u| contains a radix-36 number */

@y
@z

@x l.335
#define desc @t\quad@> z.S /* utility field definitions for the header file */
#define in_count @t\quad@> y.I
#define out_count @t\quad@> x.I
#define short_code @t\quad@> u.I
@y
#define desc @t\quad@> z.S /* utility field |z| points to the \<description> string */
#define in_count @t\quad@> y.I /* utility field |y| counts appearances in selected chapters */
#define out_count @t\quad@> x.I /* utility field |x| counts appearances in other chapters */
#define short_code @t\quad@> u.I /* utility field |u| contains a radix-36 number */
#endif /* |GB_BOOKS_H| */
@z

@x l.377
    if (p->chap!=k) {
@y
    if (p->chap!=(long)k) {
@z

@x l.420
        if (p->chap!=k) {@+register Vertex *v=p->vert;
@y
        if (p->chap!=(long)k) {@+register Vertex *v=p->vert;
@z

@x l.434
Vertex *chap_base;
@y
Vertex *chap_base=0;
@z

@x l.455
      do@+{@+
@y
      do {@+
@z

@x l.461
      }@+while (c==','); /* repeat until end of the clique */
@y
      } while (c==','); /* repeat until end of the clique */
@z

@x l.471
@ @(gb_books.h@>=
#define chap_no @[a.I@] /* utility field definition in the header file */
@y
@ (This section remains empty for historic reasons.)
@z

@x l.499
if (n>characters) n=characters;
if (x>n) x=n;
if (last_chapter>chapters) last_chapter=chapters;
@y
if ((long)n>characters) n=characters;
if (x>n) x=n;
if ((long)last_chapter>chapters) last_chapter=chapters;
@z
