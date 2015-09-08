@x l.72
main(argc,argv)
  int argc; /* the number of command-line arguments */
  char *argv[]; /* an array of strings containing those arguments */
@y
int main(@t\1\1@>
  int argc, /* the number of command-line arguments */
  char *argv[]@t\2\2@>) /* an array of strings containing those arguments */
@z

@x
for (k=0;k<m;k++) {
  for (l=0;l<n;l++) printf("% 4ld",compl?d-*(mtx+k*n+l):*(mtx+k*n+l));
@y
for (k=0;k<(long)m;k++) {
  for (l=0;l<(long)n;l++) printf("% 4ld",compl?(long)d-*(mtx+k*n+l):*(mtx+k*n+l));
@z

@x
  for (l=0; l<n; l++) {
@y
  for (l=0; l<(long)n; l++) {
@z

@x
    for (k=1;k<n;k++) 
@y
    for (k=1;k<(long)n;k++)
@z

@x
      for (k=0;k<n;k++)
@y
      for (k=0;k<(long)n;k++)
@z

@x
for (l=0; l<n; l++) {
@y
for (l=0; l<(long)n; l++) {
@z

@x
for (k=0; k<m; k++) {
@y
for (k=0; k<(long)m; k++) {
@z

@x
  for (l=1; l<n; l++) if (o,aa(k,l)<s) s=aa(k,l);
@y
  for (l=1; l<(long)n; l++) if (o,aa(k,l)<s) s=aa(k,l);
@z

@x
  for (l=0; l<n; l++)
@y
  for (l=0; l<(long)n; l++)
@z

@x
for (l=0; l<n; l++) {
@y
for (l=0; l<(long)n; l++) {
@z

@x
for (k=0; k<m; k++)
@y
for (k=0; k<(long)m; k++)
@z

@x
  for (l=0; l<n; l++)
@y
  for (l=0; l<(long)n; l++)
@z

@x
for (l=0; l<n; l++)
@y
for (l=0; l<(long)n; l++)
@z

@x
for (l=0; l<n; l++)
@y
for (l=0; l<(long)n; l++)
@z

@x
    for (j=l+1; j<n; j++)
@y
    for (j=l+1; j<(long)n; j++)
@z

@x
for (k=0;k<m;k++)
  for (l=0;l<n;l++)
@y
for (k=0;k<(long)m;k++)
  for (l=0;l<(long)n;l++)
@z

@x
for (k=0;k<m;k++) {
@y
for (k=0;k<(long)m;k++) {
@z

@x
for (l=0;l<n;l++) if (col_inc[l]) k++;
if (k>m) {
@y
for (l=0;l<(long)n;l++) if (col_inc[l]) k++;
if (k>(long)m) {
@z

@x
  for (k=0; k<m; k++) for (l=0; l<n; l++)
@y
  for (k=0; k<(long)m; k++) for (l=0; l<(long)n; l++)
@z

@x
  for (k=0; k<m; k++) for (l=0; l<n; l++)
@y
  for (k=0; k<(long)m; k++) for (l=0; l<(long)n; l++)
@z

@x
  for (k=0; k<m; k++)
@y
  for (k=0; k<(long)m; k++)
@z

@x
    for (k=0;k<m;k++) @<Output row |k| as a hexadecimal string@>;
@y
    for (k=0;k<(long)m;k++) @<Output row |k| as a hexadecimal string@>;
@z

@x
  for (l=0; l<n; l++) {
    x=(long)(conv*(float)(compl?d-aa(k,l):aa(k,l)));
@y
  for (l=0; l<(long)n; l++) {
    x=(long)(conv*(float)(compl?(long)d-aa(k,l):aa(k,l)));
@z

@x
  for (k=0; k<m; k++)
@y
  for (k=0; k<(long)m; k++)
@z
