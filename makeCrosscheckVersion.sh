#!/bin/bash

# 此脚本作用：
#    1. 将 PDF 文档分割为五部分
#         A 封面到扉页
#         B 原创声明到授权声明
#         C 摘要到参考文献
#         D 作者简介到致谢
#         E 附录
#    2. B 和 D 都通过处理使文字无法复制，得到B-rst，D-rst
#    3. 将 A，B-rst，C，D-rst，E 组合为新的 PDF 文档


# ！！！注意
# 执行此脚本需
#     1. 安装pdftk、Ghostscript并将其路径加入PATH环境变量
#           pdftk: https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/
#           Ghostscript: https://www.ghostscript.com/download/gsdnld.html
#     2. 将TeX Live可执行文件路径加入PATH环境变量
#     3. 有类Linux环境，可执行cat、grep、awk、head等命令
#           Windows下安装Git并使用Git Bash可得到，Git: https://git-scm.com/downloads

pdfName=$1
makeUnselectableSh="./makeUnselectable.sh"
rm $pdfName-crosscheck-*.pdf

# 提取原文档的数据信息，如meta-data、bookmark等
pdftk $pdfName.pdf dump_data_utf8 output $pdfName-crosscheck-data.info
info_file=$pdfName-crosscheck-data.info

# 通过章节题目从书签信息中提取页码
get_page_num(){ 
    mark=$1
    echo $mark
    line_num=$(grep "$mark" -n $info_file | grep "BookmarkTitle:" | awk -F ':' '{print $1}' | head -n 1)
    # echo $line_num
    if [ -z $line_num ]
    then 
        return 0
    else
        line_num=`expr $line_num + 2`
        echo $line_num
        r=`head -$line_num $info_file|tail -1|awk '{print $2}'`
        # echo $r
        return $r 
    fi
}

get_page_num 封面
coverPageNum=$?
echo coverPageNum $coverPageNum

get_page_num 扉页
titlePageNum=$?
echo titlePageNum $titlePageNum

get_page_num 学位论文原创性声明
originalStatementPageNum=$?
echo originalStatementPageNum $originalStatementPageNum

get_page_num 关于学位论文使用授权的声明
contributionStatementPageNum=$?
echo contributionStatementPageNum $contributionStatementPageNum

get_page_num "摘 要"
cAbstractPageNum=$?
echo cAbstractPageNum $cAbstractPageNum

get_page_num 参考文献
referencePageNum=$?
echo referencePageNum $referencePageNum

get_page_num 作者简介
selfIntroPageNum=$?
echo selfIntroPageNum $selfIntroPageNum

get_page_num "致 谢"
acknowledgmentPageNum=$?
echo acknowledgmentPageNum $acknowledgmentPageNum

get_page_num 附录
appendixPageNum=$?
echo appendixPageNum $appendixPageNum

lastPageNum=$(grep "NumberOfPages:" $info_file | awk -F ' ' '{print $2}')
echo totalPages $lastPageNum

#exit

pageRange=$coverPageNum-$titlePageNum
pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-A.pdf

pageRange=$originalStatementPageNum-$contributionStatementPageNum
pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-B.pdf

pageRange=$cAbstractPageNum-`expr $selfIntroPageNum - 1`
pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-C.pdf


if [ $appendixPageNum  -eq 0 ]
then
    pageRange=$selfIntroPageNum-$lastPageNum
    pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-D.pdf
else
    pageRange=$selfIntroPageNum-`expr $appendixPageNum - 1`
    pdftk $pdfName.pdf cat $pageRange output $pdfName-crosscheck-D.pdf

    pageRange=$appendixPageNum-$lastPageNum
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
rm $pdfName-crosscheck-*.ps


# 将原文档的数据信息，如meta-data、bookmark等，加到新拼成的pdf中
pdftk $pdfName-CrosscheckVersion-tmp.pdf update_info_utf8 $pdfName-crosscheck-data.info output $pdfName-CrosscheckVersion.pdf
rm $pdfName-CrosscheckVersion-tmp.pdf
rm $pdfName-crosscheck-data.info
