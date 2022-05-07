@x l.72
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
@y
int main(
  int argc, /* the number of command-line arguments */
  char *argv[]) /* an array of strings containing those arguments */
@z

@x l.149
for (k=0;k<m;k++) {
  for (l=0;l<n;l++) printf("% 4ld",compl?d-*(mtx+k*n+l):*(mtx+k*n+l));
@y
for (k=0;k<(long)m;k++) {
  for (l=0;l<(long)n;l++) printf("% 4ld",compl?(long)d-*(mtx+k*n+l):*(mtx+k*n+l));
@z

@x l.309
  for (l=0; l<n; l++) {
@y
  for (l=0; l<(long)n; l++) {
@z

@x l.311
    for (k=1;k<n;k++) 
@y
    for (k=1;k<(long)n;k++)
@z

@x l.314
      for (k=0;k<n;k++)
@y
      for (k=0;k<(long)n;k++)
@z

@x l.396
@d INF 0x7fffffff /* infinity (or darn near) */
@y
@d INF (long)(((unsigned long)-1)>>1) /* infinity (or darn near) */
@z

@x l.400
for (l=0; l<n; l++) {
@y
for (l=0; l<(long)n; l++) {
@z

@x l.406
for (k=0; k<m; k++) {
@y
for (k=0; k<(long)m; k++) {
@z

@x l.408
  for (l=1; l<n; l++) if (o,aa(k,l)<s) s=aa(k,l);
@y
  for (l=1; l<(long)n; l++) if (o,aa(k,l)<s) s=aa(k,l);
@z

@x l.410
  for (l=0; l<n; l++)
@y
  for (l=0; l<(long)n; l++)
@z

@x l.428
for (l=0; l<n; l++) {
@y
for (l=0; l<(long)n; l++) {
@z

@x l.432
for (k=0; k<m; k++)
@y
for (k=0; k<(long)m; k++)
@z

@x l.469
  for (l=0; l<n; l++)
@y
  for (l=0; l<(long)n; l++)
@z

@x l.512
for (l=0; l<n; l++)
@y
for (l=0; l<(long)n; l++)
@z

@x l.517
for (l=0; l<n; l++)
@y
for (l=0; l<(long)n; l++)
@z

@x l.542
    for (j=l+1; j<n; j++)
@y
    for (j=l+1; j<(long)n; j++)
@z

@x l.562
for (k=0;k<m;k++)
  for (l=0;l<n;l++)
@y
for (k=0;k<(long)m;k++)
  for (l=0;l<(long)n;l++)
@z

@x l.568
for (k=0;k<m;k++) {
@y
for (k=0;k<(long)m;k++) {
@z

@x l.575
for (l=0;l<n;l++) if (col_inc[l]) k++;
if (k>m) {
@y
for (l=0;l<(long)n;l++) if (col_inc[l]) k++;
if (k>(long)m) {
@z

@x l.596
  for (k=0; k<m; k++) for (l=0; l<n; l++)
@y
  for (k=0; k<(long)m; k++) for (l=0; l<(long)n; l++)
@z

@x l.608
  for (k=0; k<m; k++) for (l=0; l<n; l++)
@y
  for (k=0; k<(long)m; k++) for (l=0; l<(long)n; l++)
@z

@x l.622
  for (k=0; k<m; k++)
@y
  for (k=0; k<(long)m; k++)
@z

@x l.670
    for (k=0;k<m;k++) @<Output row |k| as a hexadecimal string@>;
@y
    for (k=0;k<(long)m;k++) @<Output row |k| as a hexadecimal string@>;
@z

@x l.684
  for (l=0; l<n; l++) {
    x=(long)(conv*(float)(compl?d-aa(k,l):aa(k,l)));
@y
  for (l=0; l<(long)n; l++) {
    x=(long)(conv*(float)(compl?(long)d-aa(k,l):aa(k,l)));
@z

@x l.699
  for (k=0; k<m; k++)
@y
  for (k=0; k<(long)m; k++)
@z
