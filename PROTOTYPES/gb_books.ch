@x l.17
extern Graph *book();
extern Graph *bi_book();
@y
extern Graph *book(char *,unsigned long,unsigned long,@|
   unsigned long,unsigned long,long,long,long);
extern Graph *bi_book(char *,unsigned long,unsigned long,@|
  unsigned long,unsigned long,long,long,long);
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
static Graph *bgraph(@t\1\1@>
  long bipartite, /* should we make the graph bipartite? */
  char *title, /* identification of the selected book */
  unsigned long n, /* number of vertices desired before exclusion */
  unsigned long x, /* number of vertices to exclude */
  unsigned long first_chapter, unsigned long last_chapter,
    /* interval of chapters leading to edges */
  long in_weight, /* weight coefficient pertaining to chapters in that interval */
  long out_weight, /* weight coefficient pertaining to chapters not in that interval */
  long seed@t\2\2@>) /* random number seed */
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
