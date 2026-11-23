\NeedsTeXFormat{LaTeX2e}[2021-06-01]
\ProvidesClass{dgm-homework}[2026/10/16 Persian DGM homework report]

\RequirePackage{iftex}
\ifXeTeX\else
  \ClassError{dgm-homework}{This class requires XeLaTeX}
    {Compile main.tex with xelatex main.tex.}
  \expandafter\endinput
\fi
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper,12pt]{article}

% Load additional packages here, BEFORE xepersian.
\RequirePackage[left=23mm,right=23mm,top=23mm,bottom=22mm,
  nohead,footskip=10mm]{geometry}
\RequirePackage{graphicx}
\RequirePackage[table]{xcolor}
\RequirePackage{amsmath,amssymb}
\RequirePackage{array,booktabs}
\RequirePackage{float}
\RequirePackage{listings}
\RequirePackage{keyval}
\RequirePackage[unicode,hidelinks,bookmarksnumbered]{hyperref}
% bidi needs to see the packages above when xepersian is loaded.
\RequirePackage{xepersian}

% bidi 26.01's array adapter references this former kernel tagging hook.
% It is absent in LaTeX 2026-06; this untagged XeLaTeX report needs no action.
\providecommand{\UseMathForPositioningText}{}

% Use B Nazanin font when available; keep a usable fallback (both local Fonts/ and system).
\IfFileExists{Fonts/B Nazanin.ttf}{
  \settextfont[
    Path = Fonts/,
    BoldFont = {B Nazanin Bold.ttf},
    Scale = 1.1667
  ]{B Nazanin.ttf}
}{
  \IfFileExists{Fonts/BNazanin.ttf}{
    \settextfont[
      Path = Fonts/,
      BoldFont = {BNaznnBd.ttf},
      Scale = 1.1667
    ]{BNazanin.ttf}
  }{
    \IfFileExists{Fonts/XB Zar.ttf}{
      \settextfont[
        Path = Fonts/,
        BoldFont = {XB ZarBd.ttf},
        ItalicFont = {XB ZarIt.ttf},
        BoldItalicFont = {XB ZarBdIt.ttf},
        Scale = 1.15
      ]{XB Zar.ttf}
    }{
      \IfFileExists{Fonts/Amiri-Regular.ttf}{
        \settextfont[
          Path = Fonts/,
          BoldFont = {Amiri-Bold.ttf},
          ItalicFont = {Amiri-Italic.ttf},
          BoldItalicFont = {Amiri-BoldItalic.ttf},
          Scale = 1.10
        ]{Amiri-Regular.ttf}
      }{
        \IfFontExistsTF{B Nazanin}{
          \settextfont[Scale=1.1667]{B Nazanin}
        }{
          \IfFontExistsTF{XB Zar}{
            \settextfont[Scale=1.15]{XB Zar}
          }{
            \IfFontExistsTF{Amiri}{\settextfont[Scale=1.10]{Amiri}}{
              \IfFontExistsTF{Tahoma}{\settextfont{Tahoma}}{
                \ClassError{dgm-homework}{No supported Persian font found}
                  {Install B Nazanin, XB Zar, Amiri, or Tahoma, then compile again.}
              }
            }
          }
        }
      }
    }
  }
}
% Latin text font
\IfFileExists{Fonts/LiberationSerif-Regular.ttf}{
  \setlatintextfont[
    Path = Fonts/,
    BoldFont = {LiberationSerif-Bold.ttf},
    ItalicFont = {LiberationSerif-Italic.ttf},
    BoldItalicFont = {LiberationSerif-BoldItalic.ttf}
  ]{LiberationSerif-Regular.ttf}
}{
  \IfFontExistsTF{Times New Roman}{
    \setlatintextfont{Times New Roman}
  }{\setlatintextfont{Latin Modern Roman}}
}

% Monospace font (LiberationMono / Consolas / Courier New)
\IfFileExists{Fonts/LiberationMono-Regular.ttf}{
  \setmonofont[
    Path = Fonts/,
    BoldFont = {LiberationMono-Bold.ttf},
    ItalicFont = {LiberationMono-Italic.ttf},
    BoldItalicFont = {LiberationMono-BoldItalic.ttf}
  ]{LiberationMono-Regular.ttf}
}{
  \IfFontExistsTF{Consolas}{
    \setmonofont{Consolas}
  }{
    \IfFontExistsTF{Courier New}{
      \setmonofont{Courier New}
    }{\setmonofont{Courier New}}
  }
}

\definecolor{dgmAccent}{HTML}{4B5563}
\definecolor{dgmMuted}{HTML}{6B7280}
\definecolor{dgmLine}{HTML}{9CA3AF}
\definecolor{dgmLight}{HTML}{F3F4F6}

\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt}
\linespread{1.25}
\setlength{\emergencystretch}{2em}
\setlength{\tabcolsep}{10pt}
\renewcommand{\arraystretch}{1.35}
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{3}

% Per-homework metadata, configured from main.tex.
\newcommand{\dgm@course}{مدل‌های مولد عمیق}
\newcommand{\dgm@homework}{۱}
\newcommand{\dgm@instructor}{دکتر مصطفی توسلی‌پور}
\newcommand{\dgm@student}{[نام و نام خانوادگی]}
\newcommand{\dgm@studentid}{۸۱۰۱۰۰۰۰۰}
\newcommand{\dgm@date}{[تاریخ ارسال]}
\newcommand{\dgm@semester}{نیم‌سال اول ۱۴۰۵}
\define@key{dgm}{course}{\renewcommand{\dgm@course}{#1}}
\define@key{dgm}{homework}{\renewcommand{\dgm@homework}{#1}}
\define@key{dgm}{instructor}{\renewcommand{\dgm@instructor}{#1}}
\define@key{dgm}{student}{\renewcommand{\dgm@student}{#1}}
\define@key{dgm}{student-id}{\renewcommand{\dgm@studentid}{#1}}
\define@key{dgm}{submission-date}{\renewcommand{\dgm@date}{#1}}
\define@key{dgm}{semester}{\renewcommand{\dgm@semester}{#1}}
\newcommand{\DGMSetup}[1]{\setkeys{dgm}{#1}}

% LaTeX's shipout picture has its origin at the upper-left page corner.
\AddToHook{shipout/background}{%
  \begingroup\setLTR
  \put(8.5mm,-\dimexpr\paperheight-8.5mm\relax){%
    \color{dgmAccent}\linethickness{0.4pt}%
    \framebox(\dimexpr\paperwidth-17mm\relax,
      \dimexpr\paperheight-17mm\relax){}%
  }%
  \endgroup
}

% Standard LaTeX page style: no header, centered page number in the footer.
\pagestyle{plain}

% Standard sectioning keeps labels, references, and bookmarks working.
\newcommand{\dgm@prefix@section}{سوال\space}
\renewcommand{\@seccntformat}[1]{%
  \ifcsname dgm@prefix@#1\endcsname
    \csname dgm@prefix@#1\endcsname
  \fi
  \csname the#1\endcsname\quad
}
\renewcommand{\section}{\@startsection{section}{1}{\z@}%
  {-2.5ex \@plus -1ex \@minus -.2ex}{1.2ex \@plus .2ex}%
  {\normalfont\Large\bfseries\color{dgmAccent}}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
  {-2ex \@plus -.5ex \@minus -.2ex}{.8ex \@plus .2ex}%
  {\normalfont\large\bfseries\color{dgmAccent}}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
  {-1.5ex \@plus -.5ex \@minus -.2ex}{.6ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries\color{dgmAccent}}}
\newcommand{\question}[1]{\clearpage\section{#1}}

\newcommand{\dgm@maketitle}{%
  \hypersetup{pageanchor=false}%
  \begin{titlepage}
    \thispagestyle{empty}
    \begin{center}
      \begin{LTR}
        \noindent
        \begin{minipage}[t]{.20\textwidth}
          \vspace{0pt}\centering
          \includegraphics[width=30mm,height=30mm,keepaspectratio]{images/eng-logo.png}
        \end{minipage}\hfill
        \begin{minipage}[t]{.55\textwidth}
          \vspace{0pt}\centering\begin{RTL}
            {\large\bfseries به نام خدا\par}
            \vspace{8mm}
            {\large\bfseries دانشگاه تهران\par}
            \vspace{3mm}
            {\large\bfseries پردیس دانشکدگان فنی\par}
          \end{RTL}
        \end{minipage}\hfill
        \begin{minipage}[t]{.20\textwidth}
          \vspace{0pt}\centering
          \includegraphics[width=27mm,height=27mm,keepaspectratio]{images/ut-logo.png}
        \end{minipage}
      \end{LTR}
      \vspace{5mm}
      {\large\bfseries دانشکده مهندسی برق و کامپیوتر\par}
      \vspace{28mm}
      {\color{dgmAccent}\fontsize{26}{34}\selectfont\bfseries
        درس \dgm@course\par}
      \vspace{7mm}
      {\Large\bfseries گزارش تمرین شماره \dgm@homework\par}
      \vspace{17mm}
      {\large\bfseries استاد درس: \dgm@instructor\par}
      \vspace{15mm}
      {\arrayrulecolor{dgmLine}%
        \setlength{\extrarowheight}{3pt}%
        \begin{tabular}{|>{\columncolor{dgmLight}\centering\arraybackslash\bfseries}m{43mm}|
          >{\centering\arraybackslash}m{85mm}|}
          \hline
          نام و نام خانوادگی & \dgm@student \\ \hline
          شماره دانشجویی & \dgm@studentid \\ \hline
          تاریخ ارسال گزارش & \dgm@date \\ \hline
        \end{tabular}\par}
      \vfill
      {\color{dgmMuted}\dgm@semester\par}
      \vspace{7mm}
    \end{center}
  \end{titlepage}
  \setcounter{page}{1}%
  \hypersetup{pageanchor=true}%
}
% Install after bidi/hyperref have finished their begin-document patches.
\AddToHook{begindocument/end}{\let\maketitle\dgm@maketitle}

% Numbering is continuous across questions.
\lstset{
  basicstyle=\ttfamily\footnotesize\linespread{1}\selectfont,
  captiondirection=LTR,captionscript=latin,
  keywordstyle=\bfseries\color{dgmAccent},
  commentstyle=\color{dgmMuted},
  stringstyle=\color{dgmAccent},
  backgroundcolor=\color{dgmLight},
  frame=single,rulecolor=\color{dgmLine},
  breaklines=true,columns=fullflexible,keepspaces=true,
  showstringspaces=false,tabsize=4,
  aboveskip=8pt,belowskip=8pt
}
\lst@AddToHook{Init}{\setlength{\parskip}{0pt}}

\AtBeginDocument{%
  \renewcommand{\contentsname}{فهرست مطالب}%
  \renewcommand{\refname}{مراجع}%
  \hypersetup{pdftitle={گزارش تمرین — \dgm@course},
    pdfauthor={\dgm@student}}%
}
\let\dgm@bibliography\thebibliography
\renewcommand{\thebibliography}[1]{%
  \clearpage\phantomsection
  \addcontentsline{toc}{section}{\refname}%
  \dgm@bibliography{#1}%
}
\endinput
