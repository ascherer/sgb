Change file for gb_econ.w

@x	lines 386-387
  for (p=node_index[ADJ_SEC]-1;p>=node_block;p--) /* bottom up */
    if (p->rchild)
@y
  for (p=node_index[ADJ_SEC];p>node_block; ) /* bottom up */
    if ((--p)->rchild)
@z

@x	lines 579-580
for (p=node_index[ADJ_SEC];p>=node_block;p--) { /* bottom up */
  if (p->SIC) { /* original leaf */
@y
for (p=node_index[ADJ_SEC]+1;p>node_block; ) { /* bottom up */
  if ((--p)->SIC) { /* original leaf */
@z
