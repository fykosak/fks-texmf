%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for batch brojure. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksbatch}[2011/09/11 Batch brojure]

% inherit from fksbase class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions
\LoadClass{fksbase}



\newcommand\problemsheading{%
\section[Zadání \Roman{batch}. série]{\met@headerproblems}
\vspace{-4pt}
\ifthenelse{\equal{\@deadlineS}{N/A}}{%
\centerline{\Large\slshape\sffamily Termín doručení: \@deadline}
}{%
\centerline{\Large\slshape\sffamily Termín uploadu: \@deadline}
\centerline{\Large\slshape\sffamily Termín odeslání: \@deadlineS}}
\vspace{1.5ex}
\setcounter{problem}{0}}

\newcommand\problemsheadingsummer[3]{%
\setcounter{batch}{#1}
\deadline{#2}\deadlineS{#3}
\section[Zadání \Roman{batch}. série]{\met@summerheaderproblems}
\vspace{-4pt}
\centerline{\Large\slshape\sffamily Termín uploadu: \@deadline}
\centerline{\Large\slshape\sffamily Termín odeslání: \@deadlineS}
\vspace{1.5ex}
\setcounter{problem}{0}}

\newcommand\problemsheadingsummerBonus[3]{%
\setcounter{batch}{#1}
\deadline{#2}\deadlineS{#3}
\section[Zadání bonusové série]{\met@summerheaderproblemsBonus}
\vspace{-4pt}
\centerline{\Large\slshape\sffamily Termín uploadu: \@deadline}
\centerline{\Large\slshape\sffamily Termín odeslání: \@deadlineS}
\vspace{1.5ex}
\setcounter{problem}{0}}
%}




\newcommand\solutionheading{%
\ifthenelse{\equal{\thesolvedbatch}{0}}{% implicitly set solvedbatch = batch - 1
\setcounter{solvedbatch}{\value{batch}}%
\addtocounter{solvedbatch}{-1}%
}{}%
\setcounter{problem}{0}%
\section[Řešení \Roman{solvedbatch}. série]{\met@headersolutions}}

\newcommand\solutionheadingsummer[1]{%
\setcounter{solvedbatch}{#1}
\setcounter{problem}{0}%
\section[Řešení \Roman{solvedbatch}. série]{\met@summerheadersolutions}}



\newcommand\seriesheading[1]{%
\section[Seriál: #1]{\met@headerseries{#1}}}

\newcommand\resultsheading{%
\section[Pořadí řešitelů po \Roman{solvedbatch}. sérii]{\met@headerresults}
}

\newcommand\resultsheadingsummer[1]{%
\section[Pořadí #1 řešitelů po \Roman{solvedbatch}. sérii]{\met@summerheaderresults{#1}}
}


% other
\let\oldfooter\makefooter
\renewcommand\makefooter{%
\null
\vfill
\begin{center}
  \met@address
\end{center}
  \oldfooter
}

\newcommand\@deadline{NENÍ ZADÁNO} % upload/receive
\newcommand\deadline[1]{\renewcommand\@deadline{#1}}

\newcommand\@deadlineS{N/A} % send
\newcommand\deadlineS[1]{\renewcommand\@deadlineS{#1}}




