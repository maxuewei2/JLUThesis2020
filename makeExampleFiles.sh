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

# 以假粗体实现粗体生成的文档更接近 MS Word 的感觉，但似乎可能出现奇奇怪怪的问题(如部分字无法选中、该加粗的字没有加粗、不该加粗的字加粗了等)
# STSong， SimSun， NSimSun， SimSun-ExtB， Adobe Song Std
# documentclass 需设置 AutoFakeBold， jluthesis2020 需设置 manualSpine， 需重置CJKmainfont
sed 's/\documentclass\[.*\]/\documentclass\[oneside,a4paper,12pt,AutoFakeBold\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[amd,ebook,manualSpine\]{jluthesis2020}/' | \
sed 's/\\usepackage{hyperxmp}/\\usepackage{hyperxmp}\n\\setCJKmainfont{Adobe Song Std}\n\\setCJKfamilyfont{song}{Adobe Song Std}/' |\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学硕士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{计算机应用技术}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机应用技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机应用技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{数据挖掘}/' |\
sed 's/^\\jluCSpineTitle{\\jluPrintSpine{\\jluPrintSpineChinese{/% \\jluCSpineTitle{\\jluPrintSpine{\\jluPrintSpineChinese{/' |\
sed 's/% \\jluManualSpine{/\\jluManualSpine{/' |\
sed -z "$(echo 's/%[ \t]*\\jluPrintVerticallyOneByOne{/\t\\jluPrintVerticallyOneByOne{/'{4..1}\;)" |\
sed -z 's/%[ \t]*\\jluPrintVerticallySentence{/\t\\jluPrintVerticallySentence{/'  |\
sed -z 's/%[ \t]*} % jluManualSpine/} % jluManualSpine/' \
> tmp.tex
compile
mv tmp.pdf $tmpdir/amd-ebook-oneside-假粗体.pdf
mv tmp.tex $tmpdir/amd-ebook-oneside-假粗体.tex


sed 's/\documentclass\[.*\]/\documentclass\[oneside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[amd,ebook\]{jluthesis2020}/'|\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学硕士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{计算机应用技术}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机应用技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机应用技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{数据挖掘}/' > tmp.tex
compile
mv tmp.pdf $tmpdir/amd-ebook-oneside.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[phdfancy,ebook,twoSideCover\]{jluthesis2020}/' |\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学博士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{计算机应用技术}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机应用技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机应用技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{数据挖掘}/' > tmp.tex
compile
mv tmp.pdf $tmpdir/phdfancy-ebook-twoSideCover.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[phdplain,hardcopy\]{jluthesis2020}/' |\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学博士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{计算机应用技术}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机应用技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机应用技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{数据挖掘}/' > tmp.tex
compile
mv tmp.pdf $tmpdir/phdplain-hardcopy.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[phdplain,hardcopy,twoSideCover,onlyCover\]{jluthesis2020}/' |\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学博士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{计算机应用技术}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机应用技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机应用技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{数据挖掘}/' > tmp.tex
compile
mv tmp.pdf $tmpdir/phdplain-hardcopy-twoSideCover-onlyCover.pdf

sed 's/\documentclass\[.*\]/\documentclass\[oneside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[pmd,hardcopy,onlyCover\]{jluthesis2020}/' |\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工程硕士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{工程硕士}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{计算机技术}/' > tmp.tex
compile
mv tmp.pdf $tmpdir/pmd-hardcopy-onlyCover.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[pmd,hardcopy\]{jluthesis2020}/'|\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工程硕士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{工程硕士}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{计算机技术}/' > tmp.tex
compile
mv tmp.pdf $tmpdir/pmd-hardcopy-twoside.pdf

sed 's/\documentclass\[.*\]/\documentclass\[twoside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[pmd,hardcopy,noBlankPages\]{jluthesis2020}/'|\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工程硕士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{工程硕士}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{计算机技术}/' > tmp.tex
compile
mv tmp.pdf $tmpdir/pmd-hardcopy-twoside-noBlankPages.pdf

sed 's/\documentclass\[.*\]/\documentclass\[oneside,a4paper,12pt\]/' example.tex | \
sed 's/^\\usepackage\[.*\]{jluthesis2020}/\\usepackage\[amd,hardcopy\]{jluthesis2020}/'|\
sed 's/\\jluCDegree{.*} /\\jluCDegree{工学硕士}/' |\
sed 's/\\jluCSubject{.*} /\\jluCSubject{计算机应用技术}/' |\
sed 's/\\jluCSubjectScd{.*} /\\jluCSubjectScd{计算机应用技术}/' |\
sed 's/\\jluCSubjectTrd{.*} /\\jluCSubjectTrd{计算机应用技术}/' |\
sed 's/\\jluCInterest{.*} /\\jluCInterest{数据挖掘}/' > tmp.tex
compile
./makeCrosscheckVersion.sh tmp
mv tmp-CrosscheckVersion.pdf $tmpdir/amd-hardcopy-CrosscheckVersion.pdf

rm example_files/*
mv $tmpdir/* example_files/
