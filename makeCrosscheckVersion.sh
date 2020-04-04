#!/bin/bash
# 将 PDF 文档分割为四部分：
# A 封面到扉页
# B 原创声明到授权声明
# C 摘要到参考文献
# D 作者简介到致谢
# B 和 D 都通过处理使文字无法复制，得到B-rst，D-rst
# 将 A，B-rst，C，D-rst 组合为新的 PDF 文档

pdfName=$1
makeUnselectableSh="./makeUnselectable.sh"

coverPageNum=$(grep "jluPageNum jluCover" $pdfName.log|awk -F ' ' '{print $3}')
echo $coverPageNum
titlePageNum=$(grep "jluPageNum jluTitlePage" $pdfName.log|awk -F ' ' '{print $3}')
echo $titlePageNum
originalStatementPageNum=$(grep "jluPageNum jluOriginalStatement" $pdfName.log|awk -F ' ' '{print $3}')
echo $originalStatementPageNum
contributionStatementPageNum=$(grep "jluPageNum jluContributionStatement" $pdfName.log|awk -F ' ' '{print $3}')
echo $contributionStatementPageNum
cAbstractPageNum=$(grep "jluPageNum jluCAbstract" $pdfName.log|awk -F ' ' '{print $3}')
echo $cAbstractPageNum
referencePageNum=$(grep "jluPageNum jluReference" $pdfName.log|awk -F ' ' '{print $3}')
echo $referencePageNum
selfIntroPageNum=$(grep "jluPageNum jluSelfIntroduction" $pdfName.log|awk -F ' ' '{print $3}')
echo $selfIntroPageNum
acknowledgmentPageNum=$(grep "jluPageNum jluAcknowledgment" $pdfName.log|awk -F ' ' '{print $3}')
echo $acknowledgmentPageNum
lastPageNum=$(grep "jluPageNum jluLastPage" $pdfName.log|awk -F ' ' '{print $3}')
echo $lastPageNum

pageRange=$coverPageNum-$titlePageNum
pdftk $pdfName.pdf cat $pageRange output $pdfName-A.pdf

pageRange=$originalStatementPageNum-$contributionStatementPageNum
pdftk $pdfName.pdf cat $pageRange output $pdfName-B.pdf

pageRange=$cAbstractPageNum-`expr $selfIntroPageNum - 1`
pdftk $pdfName.pdf cat $pageRange output $pdfName-C.pdf

pageRange=$selfIntroPageNum-$lastPageNum
pdftk $pdfName.pdf cat $pageRange output $pdfName-D.pdf


$makeUnselectableSh $pdfName-B.pdf
$makeUnselectableSh $pdfName-D.pdf

#pdfunite $pdfName-A.pdf $pdfName-B-rst.pdf $pdfName-C.pdf $pdfName-D-rst.pdf $pdfName-CrosscheckVersion.pdf #会使超链接失效
#pdfjoin $pdfName-A.pdf $pdfName-B-rst.pdf $pdfName-C.pdf $pdfName-D-rst.pdf -o $pdfName-CrosscheckVersion.pdf #会使超链接失效
pdftk $pdfName-A.pdf $pdfName-B-rst.pdf $pdfName-C.pdf $pdfName-D-rst.pdf cat output $pdfName-CrosscheckVersion.pdf