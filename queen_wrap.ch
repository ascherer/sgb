% This file is part of the Stanford GraphBase (c) Stanford University 1992
It's a demonstration "change file", which converts the demonstration program
called "queen" into a similar demonstration program called "queen_wrap".

Change files make it easy to modify CWEB source programs without
touching the master files, thereby remaining totally compatible with
all other users. Anybody can make whatever modifications they like in
change files, but everybody is supposed to leave the master files
intact. Please also leave the present file intact, so that it remains
as a useful demonstration of the change-file idea.

The format of change files is simple: First comes a line that begins with @x,
then comes a line that is a verbatim copy of some line from the master file,
then comes zero or more additional lines that should match the subsequent
lines of the master file. Then you say @y, and then you give replacement
lines for everything between @x and @y in the master file. Then you say @z.
All changes must occur in the order of replaced text in the master file,
and must be uniquely identifiable by the first line that follows @x.

Optional comments may follow @x, @y, or @z, and may occur outside
of @x-@y-@z groups. In fact, you are now reading such an optional comment.

@x change the program title and delete the copyright notice
\def\title{QUEEN}
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!
@y
\def\title{QUEEN\_WRAP}
\let\maybe=\iffalse % print only sections that change
\def\botofcontents{\vskip 0pt plus 1filll \parskip=0pt
  This program was obtained by modifying {\sc QUEEN} in the
  Stanford GraphBase.\par
  Only sections that have changed are listed here.\par}
@z

@x here we modify the introductory remarks of section 1
An ASCII file called \.{queen.gb} is also produced. Other programs
can make a copy of the queen graph by calling |restore_graph("queen.gb")|.
You may find it interesting to compare the output of |queen| with
the contents of \.{queen.gb}; the former is intended to be readable
by human beings, the latter by computers.
@y
Unlike an ordinary chessboard, the board considered here ``wraps around''
at the left and right edges, so that it is essentially a cylinder.
It does not, however, wrap around at the top and bottom; double wrapping
would, in fact, allow a lowly bishop to move from any position to any other,
in two different ways.

An ASCII file called \.{queen\_wrap.gb} is also produced. Other programs
can make a copy of the graph by calling |restore_graph("queen_wrap.gb")|.
You may find it interesting to compare the output of |queen_wrap| with
the contents of \.{queen\_wrap.gb}; the former is intended to be readable
by human beings, the latter by computers.
@z

@x changes to the code of section 1
  g=board(3,4,0,0,-1,0,0); /* a graph with rook moves */
  gg=board(3,4,0,0,-2,0,0); /* a graph with bishop moves */
  ggg=gunion(g,gg,0,0); /* a graph with queen moves */
  save_graph(ggg,"queen.gb"); /* generate an ASCII file for |ggg| */
@y we add wraparound
  g=board(3,4,0,0,-1,2,0); /* a graph with rook moves and wrapping */
    /* we set |wrap=2| because only the second coordinate wraps */
  gg=board(3,4,0,0,-2,2,0); /* a graph with bishop moves and wrapping */
  ggg=gunion(g,gg,0,0); /* a graph with queen moves and wrapping */
  save_graph(ggg,"queen_wrap.gb"); /* generate an ASCII file for |ggg| */
@z

@x change to the code of section 2
  printf("Queen Moves on a 3x4 Board\n\n");
@y
  printf("Queen Moves on a Cylindrical 3x4 Board\n\n");
@z

A change file is usually much shorter than the master file, but the
present one is an exception because the master file itself is short.
You can use many different change files with the same master file.

To run the queen_wrap program on a UNIX system, you can say
  ctangle queen.w queen_wrap.ch queen_wrap.c
and then compile and go. (The .w is optional in the first argument to ctangle;
the .ch is optional in the second; the .c is optional in the third.)

The C compiler and debugger will refer to appropriate lines of the original
source file queen.w and/or the change file queen_wrap.ch when you are
troubleshooting. You need never look at the file queen_wrap.c that was
output by ctangle, although the compiler and debugger will want to see it.

To obtain a TeXed documentation, you can say
  cweave queen queen_wrap
  tex queen
  rm queen.tex
