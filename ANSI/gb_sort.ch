Change file for gb_sort.w

@x	line 109
for (pp=alt_sorted+255; pp>=alt_sorted; pp--) *pp=NULL;
@y
for (pp=alt_sorted+256; pp>alt_sorted; ) *--pp=NULL;
@z

@x	line 119
for (pp=gb_sorted+255; pp>=gb_sorted; pp--) *pp=NULL;
@y
for (pp=gb_sorted+256; pp>gb_sorted; ) *--pp=NULL;
@z

@x	lines 121-122
for (pp=alt_sorted+255; pp>=alt_sorted; pp--)
  for (p=*pp; p; p=q) {
@y
for (pp=alt_sorted+256; pp>alt_sorted; )
  for (p=*--pp; p; p=q) {
@z

@x	line 130
for (pp=alt_sorted+255; pp>=alt_sorted; pp--) *pp=NULL;
@y
for (pp=alt_sorted+256; pp>alt_sorted; ) *--pp=NULL;
@z

@x	lines 132-133
for (pp=gb_sorted+255; pp>=gb_sorted; pp--)
  for (p=*pp; p; p=q) {
@y
for (pp=gb_sorted+256; pp>gb_sorted; )
  for (p=*--pp; p; p=q) {
@z

@x	line 145
for (pp=gb_sorted+255; pp>=gb_sorted; pp--) *pp=NULL;
@y
for (pp=gb_sorted+256; pp>gb_sorted; ) *--pp=NULL;
@z

@x	line 156
for (pp=alt_sorted+255; pp>=alt_sorted; pp--) *pp=NULL;
@y
for (pp=alt_sorted+256; pp>alt_sorted; ) *--pp=NULL;
@z

@x	lines 158-159
for (pp=gb_sorted+255; pp>=gb_sorted; pp--)
  for (p=*pp; p; p=q) {
@y
for (pp=gb_sorted+256; pp>gb_sorted; )
  for (p=*--pp; p; p=q) {
@z

@x	line 172
for (pp=gb_sorted+255; pp>=gb_sorted; pp--) *pp=NULL;
@y
for (pp=gb_sorted+256; pp>gb_sorted; ) *--pp=NULL;
@z
