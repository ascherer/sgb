Change file for multiply.w

@x	line 165
for (r=buffer+strlen(buffer)-1;r>=buffer;r--) {
@y
for (r=buffer+strlen(buffer);r>buffer; ) {
@z
@x	line 178
  if (*r=='1') *q=2*a+'1';
@y
  if (*--r=='1') *q=2*a+'1';
@z

