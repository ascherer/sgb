Change file for gb_save.w

@x	lines 641-642
for (cur_block=blocks+block_count-1;cur_block>=blocks;cur_block--) {
  if (cur_block->cat==vrt) {
@y
for (cur_block=blocks+block_count;cur_block>blocks; ) {
  if ((--cur_block)->cat==vrt) {
@z

@x	lines 658-659
for (cur_block=blocks+block_count-1;cur_block>=blocks;cur_block--)
  if (cur_block->start_addr==(char *)g->vertices) {
@y
for (cur_block=blocks+block_count;cur_block>blocks; )
  if ((--cur_block)->start_addr==(char *)g->vertices) {
@z

@x	lines 809-814
  for (cur_block=blocks+block_count-1;cur_block>=blocks;cur_block--)
    if (cur_block->cat==vrt && cur_block->offset==0)
      @<Translate all |Vertex| records in |cur_block|@>;
  for (cur_block=blocks+block_count-1;cur_block>=blocks;cur_block--)
    if (cur_block->cat==vrt && cur_block->offset!=0)
      @<Translate all |Vertex| records in |cur_block|@>;
@y
  for (cur_block=blocks+block_count;cur_block>blocks; )
    if ((--cur_block)->cat==vrt && cur_block->offset==0)
      @<Translate all |Vertex| records in |cur_block|@>@;
  for (cur_block=blocks+block_count;cur_block>blocks; )
    if ((--cur_block)->cat==vrt && cur_block->offset!=0)
      @<Translate all |Vertex| records in |cur_block|@>@;
@z

@x	lines 835-836
  for (cur_block=blocks+block_count-1;cur_block>=blocks;cur_block--)
    if (cur_block->cat==ark)
@y
  for (cur_block=blocks+block_count;cur_block>blocks; )
    if ((--cur_block)->cat==ark)
@z
