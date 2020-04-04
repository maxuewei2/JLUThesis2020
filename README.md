# JLUThesisLaTeX

吉林大学学位论文 LaTeX 模板。

可生成学硕、专硕、博士简装、博士精装 PDF 论文，可生成单面或双面印刷版本，可生成单页或双页封面。

## 示例

示例文档见 [example_files](https://github.com/maxuewei2/JLUThesisLaTeX/tree/master/example_files) 下各文件。

使用示例见 [example.tex](https://github.com/maxuewei2/JLUThesisLaTeX/blob/master/example.tex)。
## 使用
可用选项有 `debug | ebook | hardcopy`，`amd | pmd | phdplain | phdfancy`，`nobox`， `manualSpine`， `onlyCover`， `twoSideCover`。

|选项|作用|
|:---:|---|
|debug| 生成的PDF带框线，方便调试|
|ebook| 带彩色文字的PDF|
|hardcopy| 无彩色文字的PDF|
|amd| 学术学位硕士使用|
|pmd |专业学位硕士使用|
|phdplain| 博士简装版使用|
|phdfancy |博士精装版使用|
|nobox | 输出的封面无框线和书脊|
|manualSpine |手动输出书脊|
|onlyCover | 仅输出封面页|
|twoSideCover | 输出双页封面|
 默认为 `hardcopy,amd`，且`nobox=false, manualSpine=false, onlyCover=false, twoSideCover=false`

举例如下
  ```
      \usepackage[phdplain,ebook,twoSideCover,onlyCover]{jluthesis2020}
      \usepackage[amd,hardcopy,twoSideCover]{jluthesis2020}
      \usepackage[amd,hardcopy]{jluthesis2020}
  ```

- 建议安装 TeX Live 并使用 XeLaTeX 编译。<br/>
  校内可在[吉大 CTAN 镜像站](http://mirrors.jlu.edu.cn/)下载 TeX Live。

- 若缺少字体需自行下载安装。所需字体如下：
	- Adobe Song Std
	- Adobe Heiti Std
	- Adobe Kaiti Std
	- Adobe Fangsong Std
	- LiSu
	- Source Han Serif CN Heavy (思源宋体粗体)
	- Nimbus Roman No9 L
	- Nimbus Sans L
	- Nimbus Mono L

 下载字体并放入系统字体文件夹后，运行 `fc-cache` 刷新字体缓存。<br/>
  Linux 用户可通过 ` fc-list : family | sort ` 查看已安装字体。 

- 若要使用此模板生成的 PDF 文档查重，需确保 PDF 能够正常复制出汉字。

- 要生成 MS Word 文档，可使用 pandoc 或 Adobe Acrobat DC，也可直接用 MS Word 打开 PDF 得到 Word 文档，只是这三种方式得到的 Word 文档质量不同。

## 免责声明

此模板为个人实现，使用者应当自行承担一切后果。

## 同类解决方案

- [jiafeng5513/JLU_Dissertation](https://github.com/jiafeng5513/JLU_Dissertation)

## 后记
- 此模板写于 2020 年 3 月 31 日，主要参考 jluthesis 及自己在写毕业论文时用 LaTeX 实现的 2020 年吉林大学研究生学位论文撰写及装帧规范。<br/>
- 因个人 TeX 能力有限且我自己的实现看起来很乱，所以参考 jluthesis 进行模板化修改产生此模板。<br/>
- 感谢实现 jluthesis 并开源的前辈 Zhang Yinhe。<br/>
 jluthesis 原档存储于 google code，但已无法下载。<br/>
 此模板参考的 jluthesis 下载自 [dartall](https://github.com/dartall/jluthesis) 。<br/>
- 生成双页封面的部分参考 [pkuthss](https://gitea.com/CasperVector/pkuthss/src/branch/master/doc/example/spine.tex) 和 [jiafeng5513/JLU_Dissertation](https://github.com/jiafeng5513/JLU_Dissertation)。
- 2020.4.3 得到学院查重结果，两个查重平台重复率都在 1.X%，且主要集中在原创声明和授权声明的部分，其他人基本不会出现这种情况，大概是查重系统会自动识别论文格式，并忽略了摘要之前的内容，不知道为什么我的没有识别出来。对这一点不放心的或许可以使用 pdfseparate 及 pdfjoin 之类的工具将 LaTeX 生成的 PDF 与 Word 生成的 PDF 组合，或者将两个声明、参考文献、致谢等改为不可选中不可复制。

## 联系方式

maxuewei1995 at 126 dot com

