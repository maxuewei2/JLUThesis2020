# JLUMasterThesisLaTeX

吉林大学硕士学位论文 LaTeX 模板。
可生成学硕或专硕版本，可生成单页或双页封面。

## 示例

示例文档见 [example-onesidecover.pdf](https://github.com/maxuewei2/JLUMasterThesisLaTeX/blob/master/example-onesidecover.pdf) 和 [example-twosidescover.pdf](https://github.com/maxuewei2/JLUMasterThesisLaTeX/blob/master/example-twosidescover.pdf)。

## 使用
可用选项有 `debug|ebook|hardcopy`， `makebox|nobox` ，`onesidecover|twosidescover` ，`amd|pmd`

|选项|作用|
|:---:|---|
|debug| 生成的PDF带框线，方便调试|
|ebook| 带彩色文字的PDF|
|hardcopy| 无彩色文字的PDF|
|makebox| 输出的封面带框线和书脊|
|nobox| 输出的封面无框线和书脊|
|onesidecover| 输出的封面为单页|
|twosidescover |输出的封面为双页|
|amd| 学术学位使用|
|pmd |专业学位使用|

默认为 `hardcopy,onesidecover,makebox,amd`

举例如下
  ```
       \usepackage[ebook,twosidescover,amd]{jluthesis2020}
       \usepackage[onesidecover,makebox,pmd]{jluthesis2020}
  ```

- 建议安装 TeX Live 并使用 XeLaTeX 编译。<br/>
  校内可在[吉大 CTAN 镜像站](http://mirrors.jlu.edu.cn/)下载 TeX Live。

- 若缺少字体需自行下载安装。所需字体如下：
	- Adobe Song Std
	- Adobe Heiti Std
	- Adobe Kaiti Std
	- Adobe Fangsong Std
	- LiSu
	- Nimbus Roman No9 L
	- Nimbus Sans L
	- Nimbus Mono L

 下载字体并放入系统字体文件夹后，运行 `fc-cache` 刷新字体缓存。<br/>
  Linux 用户可通过 ` fc-list : family | sort ` 查看已安装字体。 

- 若要使用此模板生成的 PDF 文档查重，需确保 PDF 能够正常复制出汉字。

- 要生成 MS Word 文档，可使用 pandoc 或 Adobe Acrobat DC，也可直接用 MS Word 打开 PDF 得到 Word 文档。

## 免责声明

此模板为个人实现，使用者应当自行承担一切后果。

## 同类解决方案

- [jiafeng5513/JLU_Dissertation](https://github.com/jiafeng5513/JLU_Dissertation)

## 后记
- 此模板写于 2020 年 3 月 31 日，主要参考 jluthesis 及自己在写毕业论文时用 LaTeX 实现的 2020 年吉林大学研究生学位论文撰写及装帧规范。<br/>
- 因个人 TeX 能力有限且我自己的实现看起来很乱，所以参考 jluthesis 进行模板化修改产生此模板。<br/>
- 感谢实现 jluthesis 并开源的前辈 Zhang Yinhe。<br/>
 jluthesis 原档存储于 google code，但已无法下载。<br/>
本文参考的 jluthesis 下载自 [dartall](https://github.com/dartall/jluthesis) 。<br/>
- 生成双面封皮的部分参考 [pkuthss](https://gitea.com/CasperVector/pkuthss/src/branch/master/doc/example/spine.tex) 和 [jiafeng5513/JLU_Dissertation](https://github.com/jiafeng5513/JLU_Dissertation)。

## 联系方式

maxuewei1995 at 126 dot com

