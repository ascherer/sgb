# How to format SGB with CTWILL

Here is a short recipe to format the _heavily modified_ CWEB sources of the
Stanford GraphBase with CTWILL. The complete list of items—in increasing levels
of complexity—is stated in the description of
issue [#17](https://github.com/ascherer/sgb/issues/17). We work in the `local`
branches of the `sgb` and `mmix` projects and in the root directory of `sgb`.

## Apply all patches

`git am {0002..46}-*.patch`

## Create the CWEB changefiles

```
for f in gb_flip gb_graph gb_io
do
    tie -c $f-ctwill.ch $f.w PROTOTYPES/$f.ch CTWILL/$f.tch
done
```

## Create the TeX files and PDF output

```
cp /path/to/mmix/system.bux .
for f in gb_flip gb_graph gb_io
do
    CWEBINPUTS=.//: ctwill -lpdf $f.w $f-ctwill.ch
    CWEBINPUTS=.//: ctwill -lpdf $f.w $f-ctwill.ch
    pdftex $f.tex
    ctwill-refsort <$f.ref >$f.sref
    pdftex $f.tex
done
```

## Create the general index

```
ctwill-twinx *.tex >index.tex
pdftex index.tex
```
