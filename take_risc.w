% This file is part of the Stanford GraphBase (c) Stanford University 1993
@i boilerplate.w %<< legal stuff: PLEASE READ IT BEFORE MAKING ANY CHANGES!
@i gb_types.w

\def\title{TAKE\_\,RISC}

\prerequisite{GB\_\,GATES}
@* Introduction. This demonstration program uses graphs
constructed by the |risc| procedure in the {\sc GB\_\,GATES} module to produce
an interactive program called \.{take\_risc}, which multiplies and divides
small numbers the slow way---by simulating the behavior of
a logical circuit, one gate at a time.

The program assumes that \UNIX/ conventions are being used. Some code in
sections listed under `\UNIX/ dependencies' in the index might need to change
if this program is ported to other operating systems.

\def\<#1>{$\langle${\rm#1}$\rangle$}
To run the program under \UNIX/, say `\.{take\_risc} \<trace>', where \<trace>
is nonempty if and only if you want the machine computations to
be printed out.

The program will prompt you for two numbers, and it will use the simulated
RISC machine to compute their product and quotient. Then it will ask
for two more numbers, and so on.

@ Here is the general layout of this program, as seen by the \CEE/ compiler:
@^UNIX dependencies@>

@p
#include "gb_graph.h" /* the standard GraphBase data structures */
#include "gb_gates.h" /* routines for gate graphs */
@h@#
@<Global variables@>@;
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
{
  trace=(argc>1? 8: 0); /* we'll show registers 0--7 if tracing */
  if ((g=risc(8L))==NULL) {
    printf("Sorry, I couldn't generate the graph (trouble code %ld)!\n",
      panic_code);
    return(-1);
  }
  printf("Welcome to the world of microRISC.\n");
  while(1) {
    @<Prompt for two numbers; |break| if unsuccessful@>;
    @<Use the RISC machine to compute the product, |p|@>;
    printf("The product of %ld and %ld is %ld%s.\n",m,n,p,
        o?" (overflow occurred)":"");
    @<Use the RISC machine to compute the quotient and remainder,
        |q| and~|r|@>;
    printf("The quotient is %ld, and the remainder is %ld.\n",q,r);
  }
  return 0; /* normal exit */
}

@ @<Glob...@>=
Graph *g; /* graph that defines a simple RISC machine */
long o,p,q,r; /* overflow, product, quotient, remainder */
long trace; /* number of registers to trace */
long m,n; /* numbers to be multiplied and divided */
char buffer[100]; /* input buffer */

@ @d prompt(s)
    {@+printf(s);@+fflush(stdout); /* make sure the user sees the prompt */
      if (fgets(buffer,99,stdin)==NULL) break;@+}

@<Prompt...@>=
prompt("\nGimme a number: ");
step0:if (sscanf(buffer,"%ld",&m)!=1) break;
step1:if (m<=0) {
  prompt("Excuse me, I meant a positive number: ");
  if (sscanf(buffer,"%ld",&m)!=1) break;
  if (m<=0) break;
}
while (m>0x7fff) {
  prompt("That number's too big; please try again: ");
  if (sscanf(buffer,"%ld",&m)!=1) goto step0; /* |step0| will |break| out */
  if (m<=0) goto step1;
}
@<Now do the same thing for |n| instead of |m|@>;

@ @<Now do the same thing for |n| instead of |m|@>=
prompt("OK, now gimme another: ");
if (sscanf(buffer,"%ld",&n)!=1) break;
step2:if (n<=0) {
  prompt("Excuse me, I meant a positive number: ");
  if (sscanf(buffer,"%ld",&n)!=1) break;
  if (n<=0) break;
}
while (n>0x7fff) {
  prompt("That number's too big; please try again: ");
  if (sscanf(buffer,"%ld",&n)!=1) goto step0; /* |step0| will |break| out */
  if (n<=0) goto step2;
}

@* A RISC program. Here is the little program we will run on the
little computer. It consists mainly of a subroutine called |tri|,
which computes the value of the ternary operation $x\lfloor
y/z\rfloor$, assuming that $y\ge0$ and $z>0$; the inputs $x,y,z$
appear in registers $1,2,3$, respectively, and the exit address is
assumed to be in register~7.  As special cases we can compute the
product $xy$ (letting $z=1$) or the quotient $\lfloor y/z\rfloor$
(letting $x=1$). When the subroutine returns, it leaves the result in
register~4; it also leaves the value $(y\bmod z)-z$ in register~2.
Overflow will be set if and only if the true result was not between
$-2^{15}$ and $2^{15}-1$, inclusive.

It would not be difficult to modify the code to make it work with unsigned
16-bit numbers, or to make it deliver results with 32 or 48 or perhaps
even 64 bits of precision.

@d div 7 /* location `|div|' in the program below */
@d mult 10 /* location `|mult|' in the program below */
@d memry_size 34 /* the number of instructions in the program below */

@<Glob...@>=
unsigned long memry[memry_size]={
           /* a ``read-only memory'' used by |run_risc| */
  0x2ff0, /* |start:| $\\{r2}=m$ (contents of next word) */
  0x1111, /* (we will put the value of |m| here, in |memry[1]|) */
  0x1a30, /* \quad$\\{r1}=n$ (contents of next word) */
  0x3333, /* (we will put the value of |n| here, in |memry[3]|) */
  0x7f70, /* \quad\&{jumpto} (contents of next word),
                        $\\{r7}={}$return address */
  0x5555, /* (we will put either |mult| or |div| here, in |memry[5]|) */
  0x0f8f, /* halt without changing any status bits */
  0x3a21, /* |div:| $\\{r3}=\\{r1}$ */
  0x1a01, /* \quad$\\{r1}=1$ */
  0x0a12, /* \quad|goto tri| (literally, |@t\\{r0}@>+=2|) */
  0x3a01, /* |mult:| $\\{r3}=1$ */
  0x4000, /* |tri:| $\\{r4}=0$ */
  0x5000, /* \quad$\\{r5}=0$ */
  0x6000, /* \quad$\\{r6}=0$ */
  0x2a63, /* \quad|@t\\{r2}@>-=@t\\{r3}@>| */
  0x0f95, /* \quad|goto l2| */
  0x3063, /* |l1:| |@t\\{r3}@><<=1| */
  0x1061, /* \quad|@t\\{r1}@><<=1| */
  0x6ac1, /* \quad|if| (overflow) $\\{r6}=1$ */
  0x5fd1, /* \quad|@t\\{r5}@>++| */
  0x2a63, /* |l2:| |@t\\{r2}@>-=@t\\{r3}@>| */
  0x039b, /* \quad|if| ($\ge0$) |goto l1| */
  0x0843, /* \quad|goto l4| */
  0x3463, /* |l3:| |@t\\{r3}@>>>=1| */
  0x1561, /* \quad|@t\\{r1}@>>>=1| */
  0x2863, /* |l4:| |@t\\{r2}@>+=@t\\{r3}@>| */
  0x0c94, /* \quad|if| ($<0$) |goto l5| */
  0x4861, /* \quad|@t\\{r4}@>+=@t\\{r1}@>| */
  0x6ac1, /* \quad|if| (overflow) $\\{r6}=1$ */
  0x2a63, /* \quad|@t\\{r2}@>-=@t\\{r3}@>| */
  0x5a41, /* |l5:| |@t\\{r5}@>--| */
  0x0398, /* \quad|if| ($\ge0$) |goto l3| */
  0x6666, /* \quad|if| (\\{r6}) force overflow (literally |@t\\{r6}@>>>=4|) */
  0x0fa7}; /* \quad|return|
                 (literally, $\\{r0}=\\{r7}$, preserving overflow) */

@ @<Use the RISC machine to compute the product, |p|@>=
memry[1]=m;
memry[3]=n;
memry[5]=mult;
run_risc(g,memry,memry_size,trace);
p=(long)risc_state[4];
o=(long)risc_state[16]&1; /* the overflow bit */

@ @<Use the RISC machine to compute the quotient and remainder, |q| and~|r|@>=
memry[5]=div;
run_risc(g,memry,memry_size,trace);
q=(long)risc_state[4];
r=((long)(risc_state[2]+n))&0x7fff;

@* Index. Finally, here's a list that shows where the identifiers of this
program are defined and used.
