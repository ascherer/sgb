@x l.35
int main()
@y
int main(void)
@z

@x l.123
static void fill_buf()
@y
static void fill_buf(void)
@z

@x l.185
static char *imap="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\
abcdefghijklmnopqrstuvwxyz_^~&@@,;.:?!%#$+-*/|\\<=>()[]{}`'\" \n";
@y
static char *imap=
   "0123456789"@|
   "ABCDEFGHIJKLMNOPQRSTUVWXYZ"@|
   "abcdefghijklmnopqrstuvwxyz"@|
   "_^~&@@,;.:?!%#$+-*/|\\<=>()[]{}`'\" \n";
@z

@x l.191
char imap_chr(d)
  long d;
{
  return d<0 || d>strlen(imap)? '\0': imap[d];
}
@y
char imap_chr(long d)
{
  return((char)(d<0 || d>strlen(imap)? '\0': imap[d]));
}
@z

@x l.197
long imap_ord(c)
  char c;
@y
long imap_ord(char c)
@z

@x l.206
extern char imap_chr(); /* the character that maps to a given character */
extern long imap_ord(); /* the ordinal number of a given character */
@y
extern char imap_chr(long); /* the character that maps to a given character */
extern long imap_ord(char); /* the ordinal number of a given character */
@z

@x l.213
static void icode_setup()
@y
static void icode_setup(void)
@z

@x l.225
extern void gb_newline(); /* advance to next line of the data file */
extern long new_checksum(); /* compute change in magic number */
@y
extern void gb_newline(void); /* advance to next line of the data file */
extern long new_checksum(char *,long); /* compute change in magic number */
@z

@x l.232
long new_checksum(s,old_checksum)
  char *s; /* a string */
  long old_checksum;
@y
long new_checksum(@t\1\1@>
  char *s, /* a string */
  long old_checksum@t\2\2@>)
@z

@x l.245
void gb_newline()
@y
void gb_newline(void)
@z

@x l.259
extern long gb_eof(); /* has the data all been read? */
@y
extern long gb_eof(void); /* has the data all been read? */
@z

@x l.260
long gb_eof() { return !more_data; }
@y
long gb_eof(void) { return !more_data; }
@z

@x l.276
extern char gb_char(); /* get next character of current line, or |'\n'| */
extern void gb_backup(); /* move back ready to scan a character again */
@y
extern char gb_char(void); /* get next character of current line, or |'\n'| */
extern void gb_backup(void); /* move back ready to scan a character again */
@z

@x l.280
char gb_char()
@y
char gb_char(void)
@z

@x l.286
void gb_backup()
@y
void gb_backup(void)
@z

@x l.307
extern long gb_digit(); /* |gb_digit(d)| reads a digit between 0 and |d-1| */
extern unsigned long gb_number(); /* |gb_number(d)| reads a radix-|d| number */
@y
extern long gb_digit(char); /* |gb_digit(d)| reads a digit between 0 and |d-1| */
extern unsigned long gb_number(char); /* |gb_number(d)| reads a radix-|d| number */
@z

@x l.315
long gb_digit(d)
    char d;
@y
long gb_digit(char d)
@z

@x l.322
unsigned long gb_number(d)
    char d;
@y
unsigned long gb_number(char d)
@z

@x l.353
extern char *gb_string(); /* |gb_string(p,c)| reads a string delimited by |c|
@y
extern char *gb_string(char *,char);
  /* |gb_string(p,c)| reads a string delimited by |c|
@z

@x l.360
char *gb_string(p,c)
    char *p; /* where to put the result */
    char c; /* character following the string */
@y
char *gb_string(@t\1\1@>
  char *p, /*  where to put the result */
  char c@t\2\2@>) /* character following the string */
@z

@x l.427
extern void gb_raw_open(); /* open a file for GraphBase input */
extern long gb_open(); /* open a GraphBase data file; return 0 if OK */
@y
extern void gb_raw_open(char *); /* open a file for GraphBase input */
extern long gb_open(char *); /* open a GraphBase data file; return 0 if OK */
@z

@x l.431
void gb_raw_open(f)
    char *f;
@y
void gb_raw_open(char *f)
@z

@x l.463
long gb_open(f)
    char *f;
@y
long gb_open(char *f)
@z

@x l.534
long gb_close()
@y
long gb_close(void)
@z

@x l.567
extern long gb_close(); /* close a GraphBase data file; return 0 if OK */
extern long gb_raw_close(); /* close file and return the checksum */
@y
extern long gb_close(void); /* close a GraphBase data file; return 0 if OK */
extern long gb_raw_close(void); /* close file and return the checksum */
@z

@x l.571
long gb_raw_close()
@y
long gb_raw_close(void)
@z
