% This material goes at the beginning of all Stanford GraphBase CWEB files

\def\topofcontents{
  \leftline{\sc\today\ at \hours}\bigskip\bigskip
  \centerline{\titlefont\title}}

\font\ninett=cmtt9
\def\botofcontents{\vskip 0pt plus 1filll
    \ninerm\baselineskip10pt
    \noindent\copyright\ 1992 Stanford University
    \bigskip\noindent
    This file may be freely copied and distributed, provided that
    no changes whatsoever are made. All users are asked to help keep
    the Stanford GraphBase files consistent and ``uncorrupted,''
    identical everywhere in the world. Changes are permissible only
    if the modified file is given a new name, different from the names of
    existing files in the Stanford GraphBase, and only if the modified file is
    clearly identified as not being part of that GraphBase.
    (The {\ninett CWEB} system has a ``change file'' facility by
    which users can easily make minor alterations without modifying
    the master source files in any way. Everybody is supposed to use
    change files instead of changing the files.)
    The author has tried his best to produce correct and useful programs,
    in order to help promote computer science research,
    but no warranty of any kind should be assumed.
    \smallskip\noindent
    Preliminary work on the Stanford GraphBase project
    was supported in part by National Science
    Foundation grant CCR-86-10181.}

\def\prerequisite#1{\def\startsection{\noindent
    Important: Before reading {\sc\title},
    please read or at least skim the program for {\sc#1}.\bigskip
    \let\startsection=\stsec\stsec}}
\def\prerequisites#1#2{\def\startsection{\noindent
    Important: Before reading {\sc\title}, please read
    or at least skim the programs for {\sc#1} and {\sc#2}.\bigskip
    \let\startsection=\stsec\stsec}}
