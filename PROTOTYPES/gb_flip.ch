@x l.38
int main()
@y
int main(void)
@z

@x l.57
@<Private declarations@>@;
@y
#include "gb_flip.h" /* we use our own interface first */
@<Private declarations@>@;
@z

@x l.101
@d gb_next_rand() (*gb_fptr>=0? *gb_fptr--: gb_flip_cycle())

@y
@z

@x l.103
@(gb_flip.h@>=
@y
@(gb_flip.h@>=
#ifndef GB_FLIP_H
#define GB_FLIP_H
@z

@x l.106
extern long gb_flip_cycle(); /* compute 55 more pseudo-random numbers */
@y
extern long gb_flip_cycle(void); /* compute 55 more pseudo-random numbers */
@z

@x l.126
long gb_flip_cycle()
@y
long gb_flip_cycle(void)
@z

@x l.151
void gb_init_rand(seed)
    long seed;
@y
void gb_init_rand(
    long seed)
@z

@x l.223
@<Get the array...@>=
(void) gb_flip_cycle();
(void) gb_flip_cycle();
(void) gb_flip_cycle();
@y
@<Get the array...@>=
(void) gb_flip_cycle();
(void) gb_flip_cycle();
(void) gb_flip_cycle();@/
@z

@x l.230
extern void gb_init_rand();
@y
extern void gb_init_rand(long);
@z

@x l.244
long gb_unif_rand(m)
    long m;
@y
long gb_unif_rand(
    long m)
@z

@x l.256
  do@+{
@y
  do {
@z

@x l.258
  }@+while (t<=(unsigned long)r);
@y
  } while (t<=(unsigned long)r);
@z

@x l.263
extern long gb_unif_rand();
@y
extern long gb_unif_rand(long);
@#
#endif /* |GB_FLIP_H| */
@z
