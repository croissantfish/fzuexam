\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fzuexam}[2026/01/12 Documentclass for FZU final exam]
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=fzuexam,
  prefix=fzuexam@
}
\DeclareStringOption[2025-2026]{academicyear}
\DeclareStringOption[1]{semester}
\DeclareStringOption[A]{examtype}
\DeclareStringOption[]{coursename}
\DeclareStringOption[期末]{at}
\DeclareStringOption[\today]{examdate}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessKeyvalOptions{fzuexam}
\LoadClass[a4paper,addpoints]{exam}

\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{tikz}
\RequirePackage[normalem]{ulem}
\RequirePackage[margin=1in]{geometry}
\RequirePackage[breakable, skins, most]{tcolorbox}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage{tikzpagenodes}
\RequirePackage{ctex}
\RequirePackage{totcount}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{setspace}
\RequirePackage{lastpage}
\RequirePackage{adjustbox}


\usetikzlibrary{shapes,shapes.geometric,shapes.misc,shapes.arrows}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{calc,positioning}
\pagestyle{headandfoot}
\firstpagefooter{}{\footnotesize 第 \thepage 页~~共 \pageref{LastPage} 页}{
  \begin{tikzpicture}[remember picture, overlay]
    \draw[thick] ($(current page text area.north west) + (-0.2in, -24pt)$) rectangle ($(current page text area.south east) + (0.2in, -0.2in)$);
  \end{tikzpicture}
}

\runningfooter{}{\footnotesize  第 \thepage 页~~共 \pageref{LastPage} 页}{
  \begin{tikzpicture}[remember picture, overlay]
    \draw[thick] ($(current page text area.north west) + (-0.2in, 0.2in)$) rectangle ($(current page text area.south east) + (0.2in, -0.2in)$);
  \end{tikzpicture}
}

\pointname{分}
\geometry{
  a4paper,
  margin=1in,
  % headheight=15pt
}

\newcommand*{\fakebreak}{\par\vspace{\textheight minus \textheight}\pagebreak}
\renewcommand{\thequestion}{\zhnum{question}}
\renewcommand{\questionlabel}{
  \large
  \thequestion、
}
\renewcommand{\questionshook}{\large\bfseries}
\renewcommand{\partlabel}{\arabic{partno}. }
\renewcommand{\partshook}{\setlength{\leftmargin}{0pt}\normalsize\normalfont}
\renewcommand{\solutiontitle}{\noindent\textbf{解答:}\par\noindent}
\regtotcounter{numquestions}
\unframedsolutions
\setlength{\rightpointsmargin}{2.2cm}
\setlength\linefillheight{28pt}
\totalformat{
  \ifprintanswers
  \else
    \doublespacing
    \begin{tabular}{|c|c|c|}
      \hline
      小计           & 得分 & 评卷人 \\
      \hline
      \totalpoints &    &     \\
      \hline
    \end{tabular}
  \fi
}

\AtBeginDocument{
  \begin{center}
    \LARGE
    \bfseries
    \heiti
    福州大学 \fzuexam@academicyear 学年第 \fzuexam@semester 学期\fzuexam@at 考试 \fzuexam@examtype 卷
  \end{center}
  \ifprintanswers
  \begin{center}
      \doublespacing
      \large
      \bfseries
      \begin{tabular}{p{.15\linewidth}p{.15\linewidth}p{.15\linewidth}p{.15\linewidth}p{.15\linewidth}p{.15\linewidth}}
        \multicolumn{3}{p{.45\linewidth}}{课程名称：\uline{\null\hfill \fzuexam@coursename \hfill\null}} & \multicolumn{3}{p{.45\linewidth}}{考试日期：\uline{\null\hfill \fzuexam@examdate \hfill\null}}                                                                     \\
        \multicolumn{6}{c}{参考答案与评分标准} \\
      \end{tabular}
      \singlespacing
    \end{center}
  \else
    \begin{center}
      \doublespacing
      \large
      \bfseries
      \begin{tabular}{p{.15\linewidth}p{.15\linewidth}p{.15\linewidth}p{.15\linewidth}p{.15\linewidth}p{.15\linewidth}}
        \multicolumn{3}{p{.45\linewidth}}{课程名称：\uline{\null\hfill \fzuexam@coursename \hfill\null}} & \multicolumn{3}{p{.45\linewidth}}{考试日期：\uline{\null\hfill \fzuexam@examdate \hfill\null}}                                                                     \\
        \multicolumn{2}{p{.3\linewidth}}{姓名： \uline{\null\hfill\null}}                              & \multicolumn{2}{p{.3\linewidth}}{学号： \uline{\null\hfill\null}}                            & \multicolumn{2}{p{.3\linewidth}}{专业或类别： \uline{\null\hfill\null}} \\
      \end{tabular}
      \singlespacing
    \end{center}
    \vspace{2pt}
    \begin{center}
      \bfseries
      \cellwidth{1cm}
      \hqword{大题}
      \hpword{分值}
      \hsword{得分}
      \htword{总分}
      \null\hfill
      \gradetable[h][questions]
      \hfill
      \begin{tabular}{|c|}
        \hline
        \Gape[10pt]{~~累分人~~} \\
        \hline
        \multirow{2}*{}      \\
        \\
        \hline
      \end{tabular}
      \hfill
      \null
    \end{center}
    \ifnum\totvalue{numquestions}>0
    \begin{center}
      \begin{tikzpicture}[,
        gtline/.style={draw, line width=0.8pt},
      ]
          \pgfmathtruncatemacro{\nq}{\totvalue{numquestions}}
          \pgfmathsetmacro{\cellwidth}{1.6}
          \pgfmathsetmacro{\cellheight}{0.8}
          \foreach \i in {-2,...,\nq} {
            \draw[gtline] (\i*\cellwidth, 0) -- (\i*\cellwidth, -2.4);
          }
          \draw[gtline] ({-2*\cellwidth}, 0) -- ({\nq*\cellwidth}, 0);
          \draw[gtline] ({-2*\cellwidth}, -\cellheight) -- ({\nq*\cellwidth}, -\cellheight);
          \draw[gtline] ({-2*\cellwidth}, -2*\cellheight) -- ({\nq*\cellwidth}, -2*\cellheight);
          \draw[gtline] ({-2*\cellwidth}, -3*\cellheight) -- ({\nq*\cellwidth}, -3*\cellheight);
          \node at ({-1.5*\cellwidth}, -0.5*\cellheight) {\textbf{大题}};
          \node at ({-1.5*\cellwidth}, -1.5*\cellheight) {\textbf{分值}};
          \node at ({-1.5*\cellwidth}, -2.5*\cellheight) {\textbf{得分}};
          \foreach \i in {1, ..., \nq} {
            \node at ({\cellwidth*(\i-1.5)}, -0.5*\cellheight) {\textbf{\zhnumber{\i}}};
            \node at ({\cellwidth*(\i-1.5)}, -1.5*\cellheight) {\textbf{\pointsofquestion{\i}}};
          }
          \node at ({(\nq-0.5)*\cellwidth}, -0.5*\cellheight) {\textbf{总分}};
          \node at ({(\nq-0.5)*\cellwidth}, -1.5*\cellheight) {\textbf{\numpoints}};
          \node at ({(\nq+0.5)*\cellwidth}, -0.5*\cellheight) {\textbf{累分人}};
          \draw[gtline] ({(\nq+1)*\cellwidth}, 0) -- ({(\nq+1)*\cellwidth}, -3*\cellheight);
          \draw[gtline] ({(\nq+1)*\cellwidth}, 0) -- ({\nq*\cellwidth}, 0);
          \draw[gtline] ({(\nq+1)*\cellwidth}, -\cellheight) -- ({\nq*\cellwidth}, -\cellheight);
          % \draw[gtline] ({(\nq+1)*\cellwidth}, -2*\cellheight) -- ({\nq*\cellwidth}, -2*\cellheight);
          \draw[gtline] ({(\nq+1)*\cellwidth}, -3*\cellheight) -- ({\nq*\cellwidth}, -3*\cellheight);
      \end{tikzpicture}
    \end{center}
    \fi
    % \qformat{\chinese{\thequestion}、}
  \fi
  \begin{questions}
}
\AtEndDocument{
  \end{questions}
}



