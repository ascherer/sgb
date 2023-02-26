@x l.47
extern long save_graph();
extern Graph *restore_graph();
@y
extern long save_graph(Graph *,char *);
extern Graph *restore_graph(char *);
@z

@x l.149
Graph *restore_graph(f)
  char *f; /* the file name */
@y
Graph *restore_graph(char *f)
  /* the file name */
@z

@x l.225
static long fill_field(l,t)
  util *l; /* location of field to be filled in */
  char t; /* its type code */
@y
static long fill_field(@t\1\1@>
  util *l, /* location of field to be filled in */
  char t@t\2\2@>) /* its type code */
@z

@x l.308
static long finish_record()
@y
static long finish_record(void)
@z

@x l.410
long save_graph(g,f)
  Graph *g; /* graph to be saved */
  char *f; /* name of the file to be created */
@y
long save_graph(@t\1\1@>
  Graph *g, /* graph to be saved */
  char *f@t\2\2@>) /* name of the file to be created */
@z

@x l.518
static void classify(l,t)
  util *l; /* location of field to be classified */
  char t; /* its type code, from the set $\{\.Z,\.I,\.V,\.S,\.A\}$ */
@y
static void classify(@t\1\1@>
  util *l, /* location of field to be classified */
  char t@t\2\2@>) /* its type code, from the set $\{\.Z,\.I,\.V,\.S,\.A\}$ */
@z

@x l.672
static void flushout() /* output the buffer to |save_file| */
@y
static void flushout(void) /* output the buffer to |save_file| */
@z

@x l.686
static void prepare_string(s)
  char *s; /* string that is moved to |item_buf| */
@y
static void prepare_string(char *s)
  /* string that is moved to |item_buf| */
@z

@x l.709
static void move_item()
@y
static void move_item(void)
@z

@x l.747
static void translate_field(l,t)
  util *l; /* address of field to be output in symbolic form */
  char t; /* type of formatting desired */
@y
static void translate_field(@t\1\1@>
  util *l, /* address of field to be output in symbolic form */
  char t@t\2\2@>) /* type of formatting desired */
@z
