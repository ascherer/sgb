@x l.10
#include <stdio.h> /* the \.{NULL} pointer (|NULL|) is defined here */
#include "gb_flip.h" /* we need to use the random number generator */
@y
#include "gb_sort.h" /* we use our own interface |@(gb_sort.h@>| first */
#include "gb_flip.h" /* we need to use the random number generator */
#include <stdio.h> /* the \.{NULL} pointer (|NULL|) is defined here */
@z

@x l.69
@ In the header file, |gb_sorted| is declared to be
an array of pointers to |char|, since
nodes may have different types in different applications. User programs
should cast |gb_sorted| to the appropriate type as in the example above.

@(gb_sort.h@>=
extern void gb_linksort(); /* procedure to sort a linked list */
extern char* gb_sorted[]; /* the results of |gb_linksort| */
@y
@ @(gb_sort.h@>=
#ifndef GB_SORT_H
#define GB_SORT_H
typedef struct node_struct node;
extern void gb_linksort(node *); /* procedure to sort a linked list */
extern node* gb_sorted[]; /* the results of |gb_linksort| */
#endif /* |GB_SORT_H| */
@z

@x l.95
void gb_linksort(l)
  node *l;
@y
void gb_linksort(
  node *l)
@z
