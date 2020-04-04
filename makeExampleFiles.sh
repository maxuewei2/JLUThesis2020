#!/bin/bash
tmpdir=tmp
mkdir -p $tmpdir

compile(){
    latexmk -c
    xelatex tmp.tex
    bibtex tmp
    xelatex tmp.tex
    xelatex tmp.tex
}

sed 's/\documentclass\[.*\]/\documentclass\[oneside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[amd,ebook\]{jluthesis2020}/'|\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学硕士}/'> tmp.tex
compile
mv tmp.pdf $tmpdir/amd-ebook-oneside.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[phdfancy,ebook,twoSideCover\]{jluthesis2020}/' |\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学博士}/'> tmp.tex
compile
mv tmp.pdf $tmpdir/phdfancy-ebook-twoSideCover.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[phdplain,hardcopy\]{jluthesis2020}/' |\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学博士}/'> tmp.tex
compile
mv tmp.pdf $tmpdir/phdplain-hardcopy.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[phdplain,hardcopy,twoSideCover,onlyCover\]{jluthesis2020}/' |\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学博士}/'> tmp.tex
compile
mv tmp.pdf $tmpdir/phdplain-hardcopy-twoSideCover-onlyCover.pdf

sed 's/\documentclass\[.*\]/\documentclass\[oneside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[pmd,hardcopy,onlyCover\]{jluthesis2020}/'|\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学硕士}/'> tmp.tex
compile
mv tmp.pdf $tmpdir/pmd-hardcopy-onlyCover.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[pmd,hardcopy\]{jluthesis2020}/'|\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学硕士}/'> tmp.tex
compile
mv tmp.pdf $tmpdir/pmd-hardcopy-twoside.pdf

sed 's/\documentclass\[.*\]/\documentclass\[oneside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[amd,hardcopy\]{jluthesis2020}/'|\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学硕士}/'> tmp.tex
compile
./makeCrosscheckVersion.sh tmp
mv tmp-CrosscheckVersion.pdf $tmpdir/amd-hardcopy-CrosscheckVersion.pdf

rm example_files/*
mv $tmpdir/* example_files/
