%% Copyright (C) Sun Xuehan, 2018 Shanghai Jiao Tong University Mathematical Modeling Group.
%% This is the Document Class for CUMCM2018, Version 1.2, Release 2018/9/12.
%
% This is the file `cumcm.cls'.
%

\ProvidesClass{cumcmm.cls}[2018/9/12 v1.2 Sun Xuehan]

 % here is the document class
\LoadClass[11pt,UTF8]{ctexart}
\RequirePackage{iftex}
\RequirePackage{fix-cm}
\RequirePackage{fixltx2e}

 % declaration page
\newtoks\displaytitle
\newtoks\school
\newtoks\authorone
\newtoks\authortwo
\newtoks\authorthree
\newtoks\advisor
\newtoks\teamnumber


 % Hyperref
\RequirePackage{hyperref}
\hypersetup{
bookmarksnumbered,
bookmarksopen,
breaklinks,
colorlinks,
linkcolor = black,
anchorcolor = black,
citecolor = black,
filecolor = black,
urlcolor = black,
pdfstartview = FitH
}
 
 % Page Layout
\RequirePackage{geometry}
\if@twoside
 \geometry{a4paper,
 bindingoffset = 2cm,
 inner = 0.5cm,
 outer = 2cm,
 top = 3cm,
 bottom = 2cm
 }
\else
 \geometry{a4paper,
 left = 2cm,
 right = 2cm,
 top = 2cm,
 bottom = 2cm
 }
 
 % declaration page
\newtoks\displaytitle
\newtoks\school
\newtoks\authorone
\newtoks\authortwo
\newtoks\authorthree
\newtoks\advisor

\RequirePackage{makecell}
\RequirePackage{graphicx}
\def\maketitle{
  \null
  \thispagestyle{empty}
  \leavevmode
  \input{declaration.tex}
  \null
  \cleardoublepage
  \setcounter{page}{1}
  \begin{center}
     {\heiti\zihao{3} \@title \par}
  \end{center}
  \vspace{3\ccwd}\par
  }
 
 % Format packages
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\lhead{}\chead{}\rhead{}
\lfoot{}\cfoot{\thepage}\rfoot{}
\renewcommand{\headrulewidth}{0pt}
\RequirePackage{lastpage}
\RequirePackage[title,titletoc,header]{appendix}
\RequirePackage{tocbibind}

 % Figure & table packages
\RequirePackage{graphicx}
\RequirePackage{subfigure}
\RequirePackage{caption}
\RequirePackage{diagbox}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{float}
\RequirePackage{flowchart}

 % Algorithm and program code Packages
\RequirePackage{listings}
\lstset{%
breaklines=true,
columns=flexible,
numbers=left,
numberstyle=\tt\small\color{gray},
basicstyle=\ttfamily,
keywordstyle=\color{blue}
}
\RequirePackage{algorithm}
\RequirePackage{algorithmic}  

 % Math & symbols Packages
\RequirePackage{amsmath,amsthm,amsfonts,amssymb}
\RequirePackage{mathrsfs}

 % Enumerate
\RequirePackage{enumerate}

 % Theorem environments (Chinese)
\newtheorem{theorem}{{定理}}
\newtheorem{proposition}{{命题}}
\newtheorem{lemma}{{引理}}
\newtheorem{corollary}{{推论}}
\newtheorem{definition}{{定义}}
\newtheorem{example}{{例}}

 % Abstract & Keywords
\newcommand\cnabstractname{\ziju{2}摘要}
\newcommand\enabstractname{ABSTRACT}
\newcommand\cnkeywords[1]{\pushziti {\heiti\zihao{-4}\cnkeywordsname #1}}
\newcommand\cnkeywordsname{关键词}
\newcommand\enkeywords[1]{\pushziti {\bfseries\zihao{-4}\enkeywordsname #1}}
\newcommand\enkeywordsname{Key words}

\endinput