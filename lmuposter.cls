% Copyright (c) 2013 Joost van Zwieten
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
%
\ProvidesClass{lmu}[2017/11/08, v. 1.0]
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\RequirePackage{etoolbox}

% options [[[

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=lmuposter,prefix=lmu@opt@}

\DeclareVoidOption{draft}{\PassOptionsToClass{draft}{article}}
\DeclareVoidOption{final}{\PassOptionsToClass{final}{article}}
\DeclareStringOption[]{ncolumns}
\DeclareStringOption[]{footerheight}
\DeclareBoolOption{landscape}
\DeclareBoolOption{experimentalheadergradient}

\ExecuteOptions{final}
\ProcessKeyvalOptions*

\ifx\lmu@opt@ncolumns\@empty%
  \def\lmu@opt@ncolumns{\iflmu@opt@landscape 3\else 2\fi}%
\fi

\iflmu@opt@landscape%
  \PassOptionsToPackage{landscape}{geometry}%
\fi

% ]]]

\LoadClass[onecolumn]{article}
\setlength{\columnsep}{3cm}
\newlength{\lmu@hmargin}
\setlength{\lmu@hmargin}{\columnsep}

% packages [[[

\RequirePackage[paper=a0paper,hmargin=\lmu@hmargin,vmargin={0cm,0cm},footskip=\columnsep]{geometry}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\usetikzlibrary{fadings}
\RequirePackage{multicol}
\RequirePackage{caption}
\RequirePackage{qrcode}

% ]]]

% color definitions [[[

\definecolor{lmudarkblue}{HTML}{293878}
\definecolor{lmulightblue}{HTML}{0e5ba3}
\definecolor{lmuorange}{HTML}{e5442d}
\definecolor{lmudarkgrey}{HTML}{5b5c5e}
\definecolor{lmulightgrey}{HTML}{6ff66e}
\colorlet{lmu@backgroundcolor}{white}
\let\lmu@orig@pagecolor\pagecolor
\def\pagecolor#1{%
  \colorlet{lmu@backgroundcolor}{#1}%
  \lmu@orig@pagecolor{#1}}

% ]]]
% font size definitions (TODO: should be placed in sizeXXposter.clo files ...) [[[

\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}

% Fix small math symbols.
% source: http://tex.stackexchange.com/questions/74623/big-integral-in-lmodern
% TODO: Is there a better way to fix this?
\DeclareFontFamily{OMX}{lmex}{}
\DeclareFontShape{OMX}{lmex}{m}{n}{<-> lmex10}{}

\rmfamily

%% size 24.88pt
%\renewcommand{\tiny}{\fontsize{12}{14}\selectfont}
%\renewcommand{\scriptsize}{\fontsize{14.4}{18}\selectfont}
%\renewcommand{\footnotesize}{\fontsize{17.28}{22}\selectfont}
%\renewcommand{\small}{\fontsize{20.74}{25}\selectfont}
%\renewcommand{\normalsize}{\fontsize{24.88}{30}\selectfont}
%\renewcommand{\large}{\fontsize{29.86}{37}\selectfont}
%\renewcommand{\Large}{\fontsize{35.83}{45}\selectfont}
%\renewcommand{\LARGE}{\fontsize{43}{54}\selectfont}
%\renewcommand{\huge}{\fontsize{51.6}{64}\selectfont}
%\renewcommand{\Huge}{\fontsize{61.92}{77}\selectfont}
%\newcommand{\veryHuge}{\fontsize{74.3}{93}\selectfont}
%\newcommand{\VeryHuge}{\fontsize{89.16}{112}\selectfont}
%\newcommand{\VERYHuge}{\fontsize{107}{134}\selectfont}

% size 43pt
\renewcommand{\tiny}{\fontsize{20.74}{25}\selectfont}
\renewcommand{\scriptsize}{\fontsize{24.88}{30}\selectfont}
\renewcommand{\footnotesize}{\fontsize{29.86}{37}\selectfont}
\renewcommand{\small}{\fontsize{35.83}{45}\selectfont}
\renewcommand{\normalsize}{\fontsize{43}{54}\selectfont}
\renewcommand{\large}{\fontsize{51.6}{64}\selectfont}
\renewcommand{\Large}{\fontsize{61.92}{77}\selectfont}
\renewcommand{\LARGE}{\fontsize{74.3}{93}\selectfont}
\renewcommand{\huge}{\fontsize{89.16}{112}\selectfont}
\renewcommand{\Huge}{\fontsize{107}{134}\selectfont}

\normalsize
\setlength\parindent{2em}
\setlength\parskip{0pt plus .5ex}
%\setlength\parindent{0pt}
%\setlength\parskip{2ex}
\setlength\floatsep{45pt plus 5pt minus 5pt}
\setlength\textfloatsep{86pt plus 9pt minus 18pt}
\setlength\intextsep{45pt plus 5pt minus 15pt}
\setlength\dblfloatsep{45pt plus 5pt minus 5pt}
\setlength\dbltextfloatsep{86pt plus 9pt minus 18pt}

\setlength\abovedisplayskip{32pt plus 3pt minus 3pt}
\setlength\abovedisplayshortskip{14pt plus 3pt minus 3pt}
\setlength\belowdisplayskip{\abovedisplayskip}
\setlength\belowdisplayshortskip{\abovedisplayskip}

% ]]]

% utilities: string [[[

\def\lmu@string@new{%
  \@ifnextchar [{\lmu@string@new@i}{\lmu@string@new@ii[][]}}%]

\def\lmu@string@new@i[#1]{%
  \@ifnextchar [{\lmu@string@new@ii[#1]}{\lmu@string@new@ii[#1][]}}%]

\def\lmu@string@new@ii[#1][#2]#3{%
  \csgdef{lmu@string@separator@#3}{#1}%
  \csgdef{lmu@string@end@#3}{#2}}

\def\lmu@string@append#1#2{%
  \def\lmu@tmp{#2}%
  \ifcsdef{lmu@string@data@#1}{%
    \csxdef{lmu@string@data@#1}{\csexpandonce{lmu@string@data@#1}\csexpandonce{lmu@string@separator@#1}\expandonce\lmu@tmp}}{%
    \csxdef{lmu@string@data@#1}{\expandonce\lmu@tmp}}}

\def\lmu@string@use#1{%
  \csuse{lmu@string@data@#1}{\csuse{lmu@string@end@#1}}}

\long\def\lmu@string@ifempty#1#2#3{%
  \ifcsdef{lmu@string@data@#1}{#3}{#2}}

% ]]]

% fonts and sections [[[

\renewcommand{\familydefault}{\sfdefault}
\newcommand{\lmustylesection}{\normalfont\sffamily\large\bfseries\color{lmudarkblue}}

\setcounter{secnumdepth}{0}
\renewcommand\section{%
  \@startsection{section}{1}{0pt}%
   {-2ex plus -1ex minus -.2ex}%
   {1ex plus 1ex}%
   {\lmustylesection}%
}

% ]]]
% authors [[[

% \addauthornote{key}[symbol]{description}

\def\lmu@authornote@getsymbol#1{%
  \ifcsdef{lmu@authornote@symbol@#1}{%
    \textsuperscript{\csuse{lmu@authornote@symbol@#1}}}{%
    \ClassWarning{lmuposter}{unknown author note '#1'}%
    \textsuperscript{{\bfseries??}}}}

\def\addauthornote#1{\@ifnextchar[{\lmu@authornote@addi{#1}}{\lmu@authornote@addii{#1}}}%]

\def\lmu@authornote@addi#1[#2]#3{%
  \csgdef{lmu@authornote@symbol@#1}{#2}%
  \lmu@authornote@addiii{#1}{#3}}%

\newcounter{lmu@authornote@symbolcounter}
\setcounter{lmu@authornote@symbolcounter}{0}

\def\lmu@authornote@addii#1#2{%
  \stepcounter{lmu@authornote@symbolcounter}%
  \newcounter{lmu@authornote@symbol@#1@counter}%
  \setcounter{lmu@authornote@symbol@#1@counter}{%
    \value{lmu@authornote@symbolcounter}}%
  \csgdef{lmu@authornote@symbol@#1}{%
    \fnsymbol{lmu@authornote@symbol@#1@counter}}%
  \lmu@authornote@addiii{#1}{#2}}%

\lmu@string@new[,\quad]{authornotes}
\def\lmu@authornote@addiii#1#2{%
  \lmu@string@append{authornotes}{\mbox{\lmu@authornote@getsymbol{#1}{#2}}}}

% \addauthor[authornote1,authornote2]{name}

\newbox\lmu@authors@tempboxa
\newbox\lmu@authors@tempboxb

\def\lmu@authors@foo#1#2{%
  \setbox\lmu@authors@tempboxa\hbox{#1}%
  \setbox\lmu@authors@tempboxb\hbox{#2}%
  \ifdimgreater{\wd\lmu@authors@tempboxa}{\wd\lmu@authors@tempboxb}{\makebox[0pt][l]{#2}#1}{\makebox[0pt][l]{#1}#2}}

\lmu@string@new[,\quad][\null]{authors}
\def\addauthor{\@ifnextchar [{\lmu@authors@add}{\lmu@authors@add[]}}%]
\def\lmu@authors@add[#1]#2{%
  \lmu@string@append{authors}{%
    \mbox{#2}%
    \lmu@authors@foo{%
    \@for\lmu@tmp:=#1\do{%
      \lmu@authornote@getsymbol{\lmu@tmp}}}}}

% ]]]
% header [[[

\newcommand{\lmustyleheadtitle}{\normalfont\sffamily\color{white}\huge\bfseries}
\newcommand{\lmustyleheadauthors}{\normalfont\sffamily\Large\frenchspacing}
\newcommand{\lmustyleheadauthornotes}{\normalfont\sffamily\fontsize{32}{45}\selectfont}

\newlength\safetymargin
\setlength\safetymargin{1cm}

\def\@maketitle{%
  \newpage%
  \null%
  \setbox\@tempboxa\vbox{%
    \vskip 2em%
    \begin{center}%
    \let \footnote \thanks
      {\lmustyleheadtitle \@title \par}%
      \vskip 1.5em%
      {\Large
        \lineskip .5em%
        \lmu@string@ifempty{authors}{{%
          \lmustyleheadauthors%
          % old style authors
          \begin{tabular}[t]{c}%
            \@author
          \end{tabular}}%
        }{%
          % new style authors
          {\lmustyleheadauthors%
          \lmu@string@use{authors}}%
          \par\vskip .5em%
          {\lmustyleheadauthornotes%
          \lmu@string@use{authornotes}}%
        }%
      }%
    \end{center}%
    \par%
    \vskip\columnsep}%
  \lmu@headergradient{\ht\@tempboxa+\dp\@tempboxa}%
  \unvbox\@tempboxa%
}

\newlength\lmu@titleheaderheight
\def\lmu@headergradient#1{%
  \global\deflength\lmu@titleheaderheight{#1}%
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.north west)
      {\begin{tikzpicture}[remember picture,overlay]
        \iflmu@opt@experimentalheadergradient
          \fill[lmulightblue,path fading=south] (-\safetymargin,\safetymargin) rectangle (\paperwidth+\safetymargin,-\lmu@titleheaderheight);
        \else
          \draw[draw=none,top color=lmulightblue,bottom color=lmu@backgroundcolor] (-\safetymargin,\safetymargin) rectangle (\paperwidth+\safetymargin,-\lmu@titleheaderheight);
        \fi
       \end{tikzpicture}
      };
  \end{tikzpicture}}

\newcommand{\lmu@set@tikz@body}{%
  \newlength{\lmu@body@t}\deflength{\lmu@body@t}{\paperheight-\lmu@titleheaderheight-\columnsep}%
  \newlength{\lmu@body@b}\deflength{\lmu@body@b}{\footerheight+\columnsep}%
  \newlength{\lmu@body@l}\deflength{\lmu@body@l}{\lmu@hmargin}%
  \newlength{\lmu@body@r}\deflength{\lmu@body@r}{\paperwidth-\lmu@hmargin}%
  \csdef{pgf@sh@ns@body}{rectangle}%
  \csdef{pgf@sh@np@body}{%
    \def\southwest{\pgfqpoint{\lmu@body@l}{\lmu@body@b}}%
    \def\northeast{\pgfqpoint{\lmu@body@r}{\lmu@body@t}}%
  }%
  \csdef{pgf@sh@nt@body}{{1}{0}{0}{1}{0pt}{0pt}}%
  \csdef{pgf@sh@pi@body}{pgfpageorigin}%
}

\AfterEndPreamble{%
  \maketitle%
  \lmu@set@tikz@body%
  \begin{multicols}{\lmu@opt@ncolumns}}
\AtEndDocument{%
  \end{multicols}}

% ]]]
% footer [[[

\newlength\footerheight
\ifx\lmu@opt@footerheight\@empty%
  \deflength\footerheight{.1\paperheight}%
\else%
  \deflength\footerheight{\lmu@opt@footerheight}%
\fi
\newlength\footerheightwithmargin
\deflength\footerheightwithmargin{\footerheight+\columnsep}
\geometry{vmargin={0cm,\footerheightwithmargin}}

\newlength\footerblacklinewidth
\deflength\footerblacklinewidth{1pt}
\newlength\footerwhiteliney
\deflength\footerwhiteliney{.115\footerheight}
\newlength\footerwhitelinewidth
\deflength\footerwhitelinewidth{.01\footerheight}
\newlength\footerblueyi
\deflength\footerblueyi{\footerwhiteliney-.5\footerwhitelinewidth}
\newlength\footerblueyii
\deflength\footerblueyii{\footerwhiteliney+.5\footerwhitelinewidth}
\newlength\footerblueyiii
\deflength\footerblueyiii{.4\footerheight}
\newlength\footerimagemargin
\deflength\footerimagemargin{.085\footerheight}
\newlength\footerimageheight
\deflength\footerimageheight{\footerheight-\footerblueyiii-2\footerimagemargin}

\newlength\footerimagey
\deflength\footerimagey{\footerblueyiii+\footerimagemargin}

\newcommand{\lmufooterfontsize}{\fontsize{0.1\footerheight}{0.125\footerheight}\selectfont}
\newcommand{\lmustylefooter}{\normalfont\sffamily\color{white}\lmufooterfontsize\bfseries}
\newlength\footertextheight
\settoheight\footertextheight{\lmustylefooter X}
\newlength\footerimagetexty
\deflength\footerimagetexty{.5\footerblueyii+.5\footerblueyiii-.5\footertextheight}

\lmu@string@new{footer}

\def\ps@plain{%
  \let\@mkboth\@gobbletwo%
  \let\@oddhead\@empty%
  \def\@oddfoot{%
    \reset@font%
    \begin{tikzpicture}[remember picture,overlay]
      \node at (current page.south west)
        {\begin{tikzpicture}[remember picture, overlay]
          \fill[lmuorange] (-\safetymargin,-\safetymargin) rectangle (\paperwidth+\safetymargin,\footerblueyi);
          \fill[lmuorange] (-\safetymargin,\footerblueyii) rectangle (\paperwidth+\safetymargin,\footerblueyiii);
          \fill[black] (-\safetymargin,\footerheight) rectangle (\paperwidth+\safetymargin,\footerheight+\footerblacklinewidth);
          \lmu@string@use{footer}
         \end{tikzpicture}
        };
     \end{tikzpicture}%
     \hfil}%
  \let\@evenhead\@empty%
  \let\@evenfoot\@oddfoot}

\def\lmu@footer@getposition#1{\csuse{lmu@footer@position@#1}}
\def\lmu@footer@position@c{above}
\def\lmu@footer@position@l{above right}
\def\lmu@footer@position@r{above left}

\def\lmu@footer@addtoimagebar#1#2#3{%
  \lmu@string@append{footer}{%
    \node[inner sep=0pt,\lmu@footer@getposition{#1}] at (\lmu@xpos@resolve{#2},\footerimagey) {%
      {#3}};}}

\def\lmu@footer@addtotextbar#1#2#3{%
  \lmu@string@append{footer}{%
    \node[inner sep=0pt,\lmu@footer@getposition{#1},baseline=0cm] at (\lmu@xpos@resolve{#2},\footerimagetexty) {%
      \raisebox{0pt}[\height][0pt]{{\lmustylefooter #3}}};}}

\pagestyle{plain}

\def\addfootimage(#1:#2){%
  \@ifnextchar [{\lmu@footer@addimage{#1}{#2}}{\lmu@footer@addimage{#1}{#2}[]}}%]

\def\lmu@footer@addimage#1#2[#3]#4{%
  \lmu@footer@addtotextbar{#1}{#2}{#3}%
  \lmu@footer@addtoimagebar{#1}{#2}{\includegraphics[height=\footerimageheight]{#4}}}

\def\addfootobject{%
  \@ifstar{\lmu@footer@addrawobject}{\lmu@footer@addobject}}

\def\lmu@footer@addrawobject(#1:#2){%
  \@ifnextchar [{\lmu@footer@addrawobjecti{#1}{#2}}{\lmu@footer@addrawobjecti{#1}{#2}[]}}%]

\def\lmu@footer@addrawobjecti#1#2[#3]#4{%
  \lmu@footer@addtotextbar{#1}{#2}{#3}%
  \lmu@footer@addtoimagebar{#1}{#2}{#4}}

\def\lmu@footer@addobject(#1:#2){%
  \@ifnextchar [{\lmu@footer@addobjecti{#1}{#2}}{\lmu@footer@addobjecti{#1}{#2}[]}}%]

\def\lmu@footer@addobjecti#1#2[#3]#4{%
  \lmu@footer@addtotextbar{#1}{#2}{#3}%
  \lmu@footer@addtoimagebar{#1}{#2}{\resizebox{!}{\footerimageheight}{#4}}}

\def\addfoottext(#1:#2)#3{%
  \lmu@footer@addtotextbar{#1}{#2}{#3}}

\def\addfootqrcode(#1:#2){%
  \@ifnextchar [{\lmu@footer@addqrcode{#1}{#2}}{\lmu@footer@addqrcode{#1}{#2}[]}}%]

\def\lmu@footer@addqrcode#1#2[#3]#4{%
  \lmu@footer@addtotextbar{#1}{#2}{#3}%
  \lmu@footer@addtoimagebar{#1}{#2}{\qrcode[hyperlink,height=\footerimageheight]{#4}}}

% position aliases

\def\lmu@xpos@resolve#1{%
  \ifcsdef{lmu@xpos@@\detokenize{#1}}{\csuse{lmu@xpos@@#1}}{#1}}

\def\lmu@def@xpos#1#2{%
  \expandafter\newlength\csname lmu@xpos@@#1\endcsname%
  \expandafter\deflength\csname lmu@xpos@@#1\endcsname{#2}}%

\lmu@def@xpos{page.center}{.5\paperwidth}%
\lmu@def@xpos{page.left}{0pt}%
\lmu@def@xpos{page.right}{\paperwidth}%

\lmu@def@xpos{body.center}{.5\paperwidth}%
\lmu@def@xpos{body.left}{\lmu@hmargin}%
\lmu@def@xpos{body.right}{\paperwidth-\columnsep}%

\newlength{\lmu@columnwidth}
\deflength{\lmu@columnwidth}{(\paperwidth-2\lmu@hmargin+\columnsep)/\lmu@opt@ncolumns-\columnsep}
\newcounter{lmu@xpos@item}
\setcounter{lmu@xpos@item}{0}
\@whilenum{\value{lmu@xpos@item}<\lmu@opt@ncolumns}\do{%
  \lmu@def@xpos{column\thelmu@xpos@item.center}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep+0.5\lmu@columnwidth}%
  \lmu@def@xpos{column\thelmu@xpos@item.left}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep}%
  \lmu@def@xpos{column\thelmu@xpos@item.right}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep+\lmu@columnwidth}%
  \stepcounter{lmu@xpos@item}%
}

\setcounter{lmu@xpos@item}{0}
\lmu@def@xpos{left column.center}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep+0.5\lmu@columnwidth}%
\lmu@def@xpos{left column.left}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep}%
\lmu@def@xpos{left column.right}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep+\lmu@columnwidth}%
\setcounter{lmu@xpos@item}{\lmu@opt@ncolumns}
\addtocounter{lmu@xpos@item}{-1}%
\lmu@def@xpos{right column.center}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep+0.5\lmu@columnwidth}%
\lmu@def@xpos{right column.left}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep}%
\lmu@def@xpos{right column.right}{\lmu@hmargin+\value{lmu@xpos@item}\lmu@columnwidth+\value{lmu@xpos@item}\columnsep+\lmu@columnwidth}%

% ]]]
% floats [[[

\renewenvironment{table}[1][1]%
{%
  \setlength{\parindent}{0pt}%
  \vspace{\baselineskip}%
  \def\@captype{table}
}{%
  \vspace{\baselineskip}%
}

\renewenvironment{figure}[1][1]%
{%
  \setlength{\parindent}{0pt}%
  \vspace{\intextsep}%
  \def\@captype{figure}
}{%
  \vspace{\intextsep}%
}

\captionsetup{font={small,sl}}

% ]]]
% list environments [[[

\setlength\leftmargini  {2em}
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {.5em}
\setlength\leftmarginvi {.5em}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\labelitemi{{\fontfamily{lmr}\selectfont\textbullet}}
\renewcommand\labelitemii{\normalfont\bfseries \textendash}
\renewcommand\labelitemiii{\textasteriskcentered}
\renewcommand\labelitemiv{\textperiodcentered}

% ]]]
% block [[[

\newlength\lmu@block@inset%
\newlength\lmu@block@vmargin%
\newlength\lmu@block@hmargin%
\newlength\lmu@block@textwidth%

\newcommand{\experimentalblockleft}[1]{%
  \begin{figure}
    \setlength\lmu@block@inset{\oddsidemargin}%
    \addtolength\lmu@block@inset{1in}%
    \addtolength\lmu@block@inset{\safetymargin}%
    \setlength\lmu@block@vmargin{.5\columnsep}%
    \setlength\lmu@block@hmargin{\columnsep}%
    \setlength\lmu@block@textwidth{\columnwidth}%
    \addtolength\lmu@block@textwidth{-\lmu@block@hmargin}%
    \hspace{-\lmu@block@inset}%
    \makebox[0pt][l]{%
      \colorbox{black}{%
        \vbox{%
          \vbox to\lmu@block@vmargin{\vfill}%
          \hbox{%
            \hspace{\lmu@block@inset}\parbox{\lmu@block@textwidth}{%
              \color{white}%
              \bfseries%
              #1%
            }\hspace{\lmu@block@hmargin}%
          }%
          \vbox to\lmu@block@vmargin{\vfill}%
        }%
      }%
    }%
  \end{figure}%
}

\newcommand{\experimentalblockright}[1]{%
  \begin{figure}%
    \setlength\lmu@block@inset{\evensidemargin}%
    \addtolength\lmu@block@inset{1in}%
    \addtolength\lmu@block@inset{\safetymargin}%
    \setlength\lmu@block@vmargin{.5\columnsep}%
    \setlength\lmu@block@hmargin{\columnsep}%
    \setlength\lmu@block@textwidth{\columnwidth}%
    \addtolength\lmu@block@textwidth{-\lmu@block@hmargin}%
%   \hspace{-\lmu@block@inset}%
    \makebox[0pt][l]{%
      \colorbox{black}{%
        \vbox{%
          \vbox to\lmu@block@vmargin{\vfill}%
          \hbox{%
            \hspace{\lmu@block@hmargin}\parbox{\lmu@block@textwidth}{%
              \color{white}%
              \bfseries%
              #1%
            }\hspace{\lmu@block@inset}%
          }%
          \vbox to\lmu@block@vmargin{\vfill}%
        }%
      }%
    }%
  \end{figure}%
}

% ]]]

% vim: ts=2:sts=2:sw=2:et:fdm=marker:fmr=[[[,]]]
