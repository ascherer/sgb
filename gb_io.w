% This file is part of the Stanford GraphBase (c) Stanford University 1992
\def\title{GB\_\thinspace IO}
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!

@* Introduction. This is |gb_io|, the input/output module used by all GraphBase
routines to access data~files. It doesn't actually do any output; but somehow
`input/output' sounds like a more useful title than just `input'.

All files of GraphBase data are designed to produce identical results on
almost all existing computers and operating systems. Each line of each file
contains at most 79 characters. Each character is either a blank or a
digit or an uppercase letter or a lowercase letter or a standard punctuation
mark. Blank characters at the end of each line are ``invisible''; they
have no perceivable effect, hence identical results will be obtained on
record-oriented systems that pad every line with blanks.

The data is carefully sum-checked so that defective input files have little
chance of being accepted.

@ Changes might be needed when these routines are ported to different
systems. Sections of the program that are most likely to require such changes
are listed under `system dependencies' in the index.

A validation program is provided so that installers can tell if |gb_io|
is working properly. To make the test, simply run |test_io|.

@(test_io.c@>=
#include <stdio.h>
#ifdef SYSV
#include <string.h>
#else
#include <strings.h>
#endif
#include "gb_io.h"   /* all users of |gb_io| should include this header file */
#define exit_test(m) /* we invoke this macro if something goes wrong */@+@=\@>
 {@+fprintf(stderr,"%s!\n(Error code = %ld)\n",m,io_errors);@+return -1;@+}
@t\2@>@/
main()
{
  @<Test the |gb_open| routine; exit if there's trouble@>;
  @<Test the sample data lines; exit if there's trouble@>;
  @<Test the |gb_close| routine; exit if there's trouble@>;
  printf("OK, the gb_io routines seem to work!\n");
}

@ The external variable |io_errors| mentioned in the previous section
will be set nonzero if any anomalies are detected. Errors won't occur
in normal use of GraphBase programs, so no attempt has been made to
provide a user-friendly way to decode the nonzero values that
|io_errors| may assume.  Information is simply gathered in binary
form; system wizards who may need to do a bit of troubleshooting
should be able to decode |io_errors| without great pain.

@d cant_open_file 0x1 /* bit set in |io_errors| if |fopen| fails */
@d cant_close_file 0x2 /* bit set if |fclose| fails */
@d bad_first_line 0x4 /* bit set if the data file's first line isn't legit */
@d bad_second_line 0x8 /* bit set if the second line doesn't pass muster */
@d bad_third_line 0x10 /* bit set if the third line is awry */
@d bad_fourth_line 0x20 /* guess when this bit is set */
@d file_ended_prematurely 0x40 /* bit set if |fgets| fails */
@d missing_newline 0x80 /* bit set if line is too long or |'\n'| is missing */
@d wrong_number_of_lines 0x100 /* bit set if the line count is wrong */
@d wrong_checksum 0x200 /* bit set if the check sum is wrong */
@d no_file_open 0x400 /* bit set if user tries to close an unopened file */
@d bad_last_line 0x800 /* bit set if final line has incorrect form */

@ The \Cee\ code for |gb_io| doesn't have a main routine; it's just a
bunch of subroutines to be incorporated into programs at a higher level,
via the system loading routine. Here is the general outline of \.{gb\_io.c}:

@p
@<Header files to include@>@;
@<External declarations@>@;
@<Private declarations@>@;
@<Internal functions@>@;
@<External functions@>

@ Every external variable is declared twice in this \.{CWEB} file:
once for |gb_io| itself (the ``real'' declaration for storage allocation
purposes), and once in \.{gb\_io.h} (for cross-references by |gb_io| users).

@<External declarations@>=
long io_errors; /* record of anomalies noted by |gb_io| routines */

@ @(gb_io.h@>=
extern long io_errors; /* record of anomalies noted by |gb_io| routines */

@ We will stick to standard \Cee-type input conventions. We'll also have
occasion to use some of the standard string operations.

@<Header...@>=
#include <stdio.h>
#ifdef SYSV
#include <string.h>
#else
#include <strings.h>
#endif

@* Inputting a line. The |gb_io| routines get their input from an array called
|buffer|. This array is internal to |gb_io|---its contents are hidden from
user programs. We make it 81 characters long, since the data is supposed to have
at most 79 characters per line, followed by newline and null.

@<Private...@>=
static char buffer[81]; /* the current line of input */
static char *cur_pos=buffer; /* the current character of interest */
static FILE *cur_file; /* current file, or |NULL| is none is open */

@ Here's a basic subroutine to fill the |buffer|. The main feature of interest
is the removal of trailing blanks. We assume that |cur_file| is open.

Notice that a line of 79 characters (followed by |'\n'|) will just fit into
the buffer, and will cause no errors. A line of 80 characters will also
fit; but it will be split into two lines and the |missing_newline|
message will occur, because of the way |fgets| is defined. A |missing_newline|
error will also occur if the file ends in the middle of a line, or if
a null character (|'\0'|) occurs within a line.

@<Internal...@>=
static fill_buf()
{@+register char *p;
  if (!fgets(buffer,81,cur_file)) {
    io_errors |= file_ended_prematurely; buffer[0]=more_data=0;
  }
  for (p=buffer; *p; p++) ; /* advance to first null character */
  if (p--==buffer || *p!='\n') {
    io_errors |= missing_newline; p++;
  }
  while (--p>=buffer && *p==' ') ; /* move back over trailing blanks */
  *++p='\n'; *++p=0; /* newline and null are always present at end of line */
  cur_pos=buffer; /* get ready to read |buffer[0]| */
}

@* Checksums. Each data file has a ``magic number,'' which is defined to be
$$\biggl(\sum_l 2^l c_l\biggr) \bmod p\,;$$
here $p$ is a large prime number, and $c_l$ denotes the internal code
corresponding to the $l$th-from-last
data character read (including newlines but not nulls).

The ``internal codes'' $c_l$ are computed in a system-independent way:
Each character |c| in the actual encoding scheme being used has a
corresponding |icode| which is the same on all systems. For example,
the |icode| of |'0'| is zero, regardless of whether |'0'| is actually
represented in ASCII or EBCDIC or some other scheme. (We assume that
every modern computer system is capable of printing at least 95
different characters, including a blank space.)

We will accept a data file as error-free if it has the correct number of
lines and ends with the proper magic number.

@<Private...@>=
static char icode[256]; /* mapping of characters to internal codes */
static long checksum_prime=(1<<30)-83;
  /* large prime such that $2p+100$ won't overflow */
static long magic; /* current checksum value */
static int line_no; /* current line number in file */
static long final_magic; /* desired final magic number */
static long tot_lines; /* total number of data lines */
static char more_data; /* is there data still waiting to be read? */

@ The |icode| mapping is defined by a single string, |imap|, such that
character |imap[k]| has |icode| value~|k|. There are 96 characters
in |imap|, namely the 94 standard visible ASCII codes plus space
and newline. If EBCDIC code is used instead of ASCII, the
cents sign \rlap{\.{\kern.05em/}}\.c should take the place of single-left-quote
\.{\char`\`}, and \.{\char5}~should take the place of\/~\.{\char`\~}.

Characters that do not appear in |imap| all are given the same |icode|
value, called |unexpected_char|. Such characters should be avoided in
GraphBase files whenever possible. (If they do appear, they can still
get into a user's data, but we don't distinguish them from each other
for checksumming purposes.)

The |icode| table actually plays a dual role, because we've rigged it so that
codes 0--15 come from the characters |"0123456789ABCDEF"|. This facilitates
conversion of decimal and hexadecimal data, and we can also use it for
radices higher than 16.

@d unexpected_char 100 /* default |icode| value */

@<Private...@>=
static char *imap="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ\
abcdefghijklmnopqrstuvwxyz_^~&@@,;.:?!%#$+-*/|\\<=>()[]{}`'\" \n";

@ Users of |gb_io| can look at the |imap|, but they can't change it.

@<External fun...@>=
char imap_chr(d)
  int d;
{
  return d<0 || d>strlen(imap)? '\0': imap[d];
}
@#
int imap_ord(c)
  char c;
{
  @<Make sure that |icode| has been initialized@>;
  return icode[c];
}

@ @(gb_io.h@>=
#define unexpected_char @t\quad@> 100
extern char imap_chr(); /* the character that maps to |d| */
extern int imap_ord(); /* the ordinal number of a given character */

@ @<Make sure that |icode| has been initialized@>=
if (!icode['1']) icode_setup();

@ @<Internal...@>=
static icode_setup()
{@+register int k;
  register char *p;
  for (k=0;k<256;k++) icode[k]=unexpected_char;
  for (p=imap,k=0; *p; p++,k++) icode[*p]=k;
}

@ Now we're ready to specify the first external subroutine for |gb_io| users.
Calling |gb_newline()| will read the next line of data into |buffer| and
update the magic number accordingly.

@(gb_io.h@>=
extern void gb_newline(); /* advance to next line of the data file */
extern long new_checksum(); /* compute change in magic number */

@ The magic checksum is not affected by lines that begin with \.*.

@<External f...@>=
gb_newline()
{
  if (++line_no>tot_lines) more_data=0;
  if (more_data) {
    fill_buf();
    if (buffer[0]!='*')
      magic=new_checksum(buffer,magic);
  }
}

@ Users can compute checksums like |gb_newline| does, but they can't
change the (private) value of |magic|.

@<External f...@>=
long new_checksum(s,old_checksum)
  char *s; /* a string */
  long old_checksum;
{@+register long a=old_checksum;
  register char*p;
  for (p=s; *p; p++)
    a=(a+a+icode[*p]) % checksum_prime;
  return a;
}

@ Another simple routine allows a user to read (but not write) the
variable |more_data|.

@(gb_io.h@>=
extern int gb_eof(); /* has the data all been read? */

@ @<External f...@>=
int gb_eof() { return !more_data; }

@* Parsing a line. The user can input characters from the buffer in several
ways. First, there's a basic |gb_char()| routine, which returns
a single character. The character is |'\n'| if the last character on the
line has already been read (and it continues to be |'\n'| until the user calls
|gb_newline|).

The current position in the line, |cur_pos|, always advances when |gb_char|
is called, unless |cur_pos| was already at the end of the line.
There's also a |gb_backup()| routine, which moves |cur_pos| one place
to the left unless it was already at the beginning.

@(gb_io.h@>=
extern char gb_char(); /* get next character of current line, or |'\n'| */
extern void gb_backup(); /* move back ready to scan a character again */

@ @<External f...@>=
char gb_char()
{
  if (*cur_pos) return (*cur_pos++);
  return '\n';
}
@#
gb_backup()
{
  if (cur_pos>buffer)
    cur_pos--;
}

@ There are two ways to read numerical data. The first, |gb_digit(d)|,
expects to read a single character in radix~|d|, using |icode| values
to specify digits greater than~9. (Thus, for example, |'A'| represents
the digit 10.) If the next character is a valid |d|-git,
|cur_pos| moves to the next character and the numerical value is returned.
Otherwise |cur_pos| stays in the same place and $-1$ is returned.

The second routine, |gb_number(d)|, reads characters and forms an
unsigned radix-|d| number until the first non-digit is encountered.
The resulting number is returned; it is zero if no digits were found.
No errors are possible with this routine, because it uses
|unsigned long| arithmetic.

@(gb_io.h@>=
extern int gb_digit(); /* |gb_digit(d)| reads a digit between 0 and |d-1| */
extern unsigned long gb_number(); /* |gb_number(d)| reads a radix-|d| number */

@ The value of |d| should be at most 127, if users want their programs to be
portable, because \Cee\ does not treat larger |char| values in a
well-defined manner. In most applications, |d| is of course either 10 or 16.

@<External f...@>=
int gb_digit(d)
    char d;
{
  if (icode[*cur_pos]<d) return icode[*cur_pos++];
  return -1;
}
@#
unsigned long gb_number(d)
    char d;
{@+register unsigned long a=0;
  icode[0]=d; /* make sure |'\0'| is a nondigit */
  while (icode[*cur_pos]<d)
    a=a*d+icode[*cur_pos++];
  return a;
}

@ The final subroutine for fetching data is |gb_string(p,c)|, which
stores a null-terminated string into locations starting at~|p|.
The string starts at |cur_pos| and ends just before the first appearance
of character |c|. If |c=='\n'|, the string will stop at the end of the line.
If |c| doesn't appear in the buffer at or after |cur_pos|, the last character
of the string will be the |'\n'| that is always inserted at the end
of a line, unless the entire line has already been read. (If the entire
line has previously been read, the empty string is always returned.)
After the string has been copied, |cur_pos| advances past it.

In order to use this routine safely, the user should first check that
there is room to store up to 81 characters beginning at location~|p|.
A suitable place to put the result, called |str_buf|, is provided
for the user's convenience.

The location following the stored string is returned. Thus, if the
stored string has length~|l| (not counting the null character that is
stored at the end), the value returned will be |p+l+1|.

@(gb_io.h@>=
#define STR_BUF_LENGTH 160
extern char str_buf[]; /* safe place to receive output of |gb_string| */
extern char *gb_string(); /* |gb_string(p,c)| reads a string delimited by |c|
  into bytes starting at |p| */

@ @d STR_BUF_LENGTH 160

@<External f...@>=
char str_buf[STR_BUF_LENGTH]; /* users can put strings here if they wish */
char *gb_string(p,c)
    char *p; /* where to put the result */
    char c; /* character following the string */
{
  while (*cur_pos && *cur_pos!=c)
    *p++=*cur_pos++;
  *p++=0;
  return p;
}

@ Here's how we test those routines in |io_test|: The first line of test
data consists of 79 characters, beginning with 64 zeroes and ending with
`\.{123456789ABCDEF}'. The second line is completely blank. The third
and final line says `\.{Oops:(intentional mistake)}'.

@<Test the sample data lines...@>=
if (gb_number(10)!=123456789)
  io_errors |= 1<<20; /* decimal number not working */
if (gb_digit(16)!=10)
  io_errors |= 1<<21; /* we missed the \.A following the decimal number */
gb_backup();@+ gb_backup(); /* get set to read `\.{9A}' again */
if (gb_number(16)!=0x9ABCDEF)
  io_errors |= 1<<22; /* hexadecimal number not working */
gb_newline(); /* now we should be scanning a blank line */
if (gb_char()!='\n')
  io_errors |= 1<<23; /* newline not inserted at end */
if (gb_char()!='\n')
  io_errors |= 1<<24; /* newline not implied after end */
if (gb_number(60)!=0)
  io_errors |= 1<<25; /* number should stop at null character */
{@+char temp[100];
  if (gb_string(temp,'\n')!=temp+1)
    io_errors |= 1<<26; /* string should be null after end of line */
  gb_newline();
  if (gb_string(temp,':')!=temp+5 || strcmp(temp,"Oops"))
    io_errors |= 1<<27; /* string not read properly */
}
if (io_errors)
  exit_test("Sorry, it failed. Look at the error code for clues");
if (gb_digit(10)!=-1) exit_test("Digit error not detected");
if (gb_char()!=':')
  io_errors |= 1<<28; /* lost synch after |gb_string| and |gb_digit| */
if (gb_eof())
  io_errors |= 1<<29; /* premature end-of-file indication */
gb_newline();
if (!gb_eof())
  io_errors |= 1<<30; /* postmature end-of-file indication */

@* Opening a file. The call |gb_weak_open("foo")| will open file |"foo"| and
initialize the checksumming process. If the file cannot be opened,
|io_errors| will be set to |cant_open_file|, otherwise
|io_errors| will be initialized to zero.

The call |gb_open("foo")| is a stronger version of |gb_weak_open|, which
is used for standard GraphBase data files like |"words.dat"| to make
doubly sure that they have not been corrupted. It returns the current value
of |io_errors|, which will be nonzero if any problems were detected
at the beginning of the file.

@<Test the |gb_open| routine...@>=
if (gb_open("test.dat")!=0)
  exit_test("Can't open test.dat");

@ @(gb_io.h@>=
extern void gb_weak_open(); /* open a file for GraphBase input */
extern int gb_open(); /* open a GraphBase data file; return 0 if OK */

@ @<External f...@>=
void gb_weak_open(f)
    char *f;
{
  @<Make sure that |icode|...@>;
  @<Try to open |f|@>;
  if (cur_file) {
    io_errors=0;
    more_data=1;
    line_no=magic=0;
    tot_lines=0x7fffffff; /* allow ``infinitely many'' lines */
    fill_buf();
  } else io_errors=cant_open_file;
}

@ Here's a possibly system-dependent part of the code: We try first to
open the data file by using the file name itself as the path name;
failing that, we try to prefix the file name with the name of the
standard directory for GraphBase data, found in
the header file \.{localdefs.h}.
@^system dependencies@>

@<Header...@>=
#include "localdefs.h"

@ @<Try to open |f|@>=
cur_file=fopen(f,"r");
@^system dependencies@>
if (!cur_file && (strlen(DATA_DIRECTORY)+strlen(f)<STR_BUF_LENGTH)) {
  sprintf(str_buf,"%s%s",DATA_DIRECTORY,f);
  cur_file=fopen(str_buf,"r");
}

@ @<External f...@>=
int gb_open(f)
    char *f;
{
  strncpy(file_name,f,19); /* save the name for use by |gb_close| */
  gb_weak_open(f);
  if (cur_file) {
    @<Check the first line; return if unsuccessful@>;
    @<Check the second line; return if unsuccessful@>;
    @<Check the third line; return if unsuccessful@>;
    @<Check the fourth line; return if unsuccessful@>;
    gb_newline(); /* the first line of real data is now in the buffer */
  }
  return io_errors;
}

@ @<Private...@>=
static char file_name[20]; /* name of the data file, without a prefix */

@ The first four lines of a typical data file should look something like this:
$$\halign{\hskip5em\.{#}\hfill\cr
  * File "words.dat" from the Stanford GraphBase (C) 1992 Stanford University\cr
  * A database of English 5-letter words\cr
  * This file may be freely copied but please do not change it in any way!\cr
  * (Checksum parameters 5678,78934448)\cr}$$
We actually verify only that the first four lines of a data file named |"foo"|
begin with the characters
$$\halign{\hskip5em\.{#}\hfill\cr
  * File "foo"\cr
  *\cr
  *\cr
  * (Checksum parameters $l,m$)\cr}$$
respectively, where $l$ and $m$ are decimal numbers. The values of $l$ and~$m$
are stored away as |tot_lines| and |final_magic|, to be matched at the
end of the file.

@<Check the first line...@>=
sprintf(str_buf,"* File \"%s\"",f);
if (strncmp(buffer,str_buf,strlen(str_buf)))
  return (io_errors |= bad_first_line);

@ @<Check the second line...@>=
fill_buf();
if (*buffer!='*') return (io_errors |= bad_second_line);

@ @<Check the third line...@>=
fill_buf();
if (*buffer!='*') return (io_errors |= bad_third_line);

@ @<Check the fourth line; return if unsuccessful@>=
fill_buf();
if (strncmp(buffer,"* (Checksum parameters ",23))
  return (io_errors |= bad_fourth_line);
cur_pos +=23;
tot_lines=gb_number(10);
if (gb_char()!=',')
  return (io_errors |= bad_fourth_line);
final_magic=gb_number(10);
if (gb_char()!=')')
  return (io_errors |= bad_fourth_line);

@* Closing a file. At the end, we check that the file was open
and that it had the correct number of lines, the correct magic number,
and a correct final line.
The subroutine |gb_close|, like |gb_open|, returns the value of
|io_errors|, which will be nonzero if at least one problem was noticed.

@<Test the |gb_close| routine; exit if there's trouble@>=
if (gb_close()!=0)
  exit_test("Bad checksum, or difficulty closing the file");

@ @<External f...@>=
int gb_close()
{
  if (!cur_file)
    return (io_errors |= no_file_open);
  fill_buf();
  sprintf(str_buf,"* End of file \"%s\"",file_name);
  if (strncmp(buffer,str_buf,strlen(str_buf)))
    io_errors |= bad_last_line;
  more_data=buffer[0]=0;
   /* now the |gb_io| routines are effectively shut down */
   /* we have |cur_pos=buffer| */
  if (fclose(cur_file)!=0)
    return (io_errors |= cant_close_file);
  cur_file=NULL;
  if (line_no!=tot_lines+1)
    return (io_errors |= wrong_number_of_lines);
  if (magic!=final_magic)
    return (io_errors |= wrong_checksum);
  return io_errors;
}

@ There is also a less paranoid routine, |gb_weak_close|, that
closes user-generated files. It simply closes the current file, if any,
and returns the value of the |magic| checksum.

Example: The |restore_graph| subroutine in module |gb_save| uses
|gb_weak_open| and |gb_weak_close| to provide system-independent input
that is almost as foolproof as the reading of standard GraphBase data.

@ @(gb_io.h@>=
extern int gb_close(); /* close a GraphBase data file; return 0 if OK */
extern long gb_weak_close(); /* close file and return the checksum */

@ @<External f...@>=
long gb_weak_close()
{
  if (cur_file) {
    fclose(cur_file);
    more_data=buffer[0]=0;
    cur_pos=buffer;
    cur_file=NULL;
  }
  return magic;
}

@* Index. Here is a list that shows where the identifiers of this program are
defined and used.
