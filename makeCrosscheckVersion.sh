#!/bin/bash
# 将 PDF 文档分割为五部分：
# A 封面到扉页
# B 原创声明到授权声明
# C 摘要到参考文献
# D 作者简介到致谢
# E 其余，如附录
# B 和 D 都通过处理使文字无法复制，得到B-rst，D-rst
# 将 A，B-rst，C，D-rst，E 组合为新的 PDF 文档

pdfName=$1
makeUnselectableSh="./makeUnselectable.sh"
rm $pdfName-crosscheck-*.pdf


coverPageNum=$(grep "jluPageNum jluCover" $pdfName.log|awk -F ' ' '{print $3}')
echo coverPageNum $coverPageNum
titlePageNum=$(grep "jluPageNum jluTitlePage" $pdfName.log|awk -F ' ' '{print $3}')
echo titlePageNum $titlePageNum
originalStatementPageNum=$(grep "jluPageNum jluOriginalStatement" $pdfName.log|awk -F ' ' '{print $3}')
echo originalStatementPageNum $originalStatementPageNum
contributionStatementPageNum=$(grep "jluPageNum jluContributionStatement" $pdfName.log|awk -F ' ' '{print $3}')
echo contributionStatementPageNum $contributionStatementPageNum
cAbstractPageNum=$(grep "jluPageNum jluCAbstract" $pdfName.log|awk -F ' ' '{print $3}')
echo cAbstractPageNum $cAbstractPageNum
referencePageNum=$(grep "jluPageNum jluReference" $pdfName.log|awk -F ' ' '{print $3}')
echo referencePageNum $referencePageNum
selfIntroPageNum=$(grep "jluPageNum jluSelfIntroduction" $pdfName.log|awk -F ' ' '{print $3}')
echo selfIntroPageNum $selfIntroPageNum
acknowledgmentPageNum=$(grep "jluPageNum jluAcknowledgment " $pdfName.log|awk -F ' ' '{print $3}')
echo acknowledgmentPageNum $acknowledgmentPageNum
acknowledgmentLastPageNum=$(grep "jluPageNum jluAcknowledgmentLastPage" $pdfName.log|awk -F ' ' '{print $3}')
echo acknowledgmentLastPageNum $acknowledgmentLastPageNum
lastPageNum=$(pdftk $pdfName.pdf dump_data |grep NumberOfPages|awk -F ' ' '{print $2}')
echo totalPages $lastPageNum

pageRange=$coverPageNum-$titlePageNum
pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-A.pdf

pageRange=$originalStatementPageNum-$contributionStatementPageNum
pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-B.pdf

pageRange=$cAbstractPageNum-`expr $selfIntroPageNum - 1`
pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-C.pdf

pageRange=$selfIntroPageNum-$acknowledgmentLastPageNum
pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-D.pdf

if [ "$acknowledgmentLastPageNum" -lt "$lastPageNum" ]
then
    pageRange=`expr $acknowledgmentLastPageNum + 1`-$lastPageNum
    pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-E.pdf
fi

$makeUnselectableSh $pdfName-crosscheck-B.pdf
$makeUnselectableSh $pdfName-crosscheck-D.pdf
rm $pdfName-crosscheck-B.pdf
rm $pdfName-crosscheck-D.pdf

# 见 https://blog.dbrgn.ch/2013/8/14/merge-multiple-pdfs/
#pdfunite `ls $pdfName-crosscheck-*.pdf -v` $pdfName-CrosscheckVersion-tmp.pdf #会使超链接失效
#pdfjoin `ls $pdfName-crosscheck-*.pdf -v` -o $pdfName-CrosscheckVersion-tmp.pdf #会使超链接失效
pdftk `ls $pdfName-crosscheck-*.pdf -v` cat output $pdfName-CrosscheckVersion-tmp.pdf
rm $pdfName-crosscheck-*.pdf

# 提取原文档的数据信息，如meta-data、bookmark等，加到新拼成的pdf中
pdftk $pdfName.pdf dump_data_utf8 output $pdfName-crosschecck-data.info
pdftk $pdfName-CrosscheckVersion-tmp.pdf update_info_utf8 $pdfName-crosschecck-data.info output $pdfName-CrosscheckVersion.pdf
rm $pdfName-CrosscheckVersion-tmp.pdf
rm $pdfName-crosschecck-data.info
