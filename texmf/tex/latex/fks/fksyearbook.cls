%
% @author Lukáš Timko <luky.timko@gmail.com>
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides Year book class
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksyearbook}[2012/11/13 Year book class]

% inherit from report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extreport}}
\ProcessOptions
\LoadClass[9pt]{extreport}

%
% packages
\@ifundefined{UseOption}{\def\UseOption{web}}{} % when no option set, we use web settings

\RequirePackage{optional} % ought be first
\RequirePackage{amssymb}
\RequirePackage[no-math]{fontspec} % no-math is because of mathrm(Omega)
\RequirePackage{xltxtra} % includes xunicode, fontspec
\RequirePackage{xunicode}
\RequirePackage{pgffor}
\RequirePackage{lastpage}
\UndeclareUTFcharacter[\UTFencname]{x2026}{\textellipsis} % we want normal
%ellipsis

\RequirePackage[version=3]{mhchem}
\RequirePackage{listings}

\RequirePackage[xetex,
  setpagesize=false,
  linkcolor=black,
  anchorcolor=black,
  citecolor=black,
  filecolor=black,
  urlcolor=black,
  bookmarks=true,
  bookmarksdepth=subsection,
]{hyperref}
\opt{web}{\hypersetup{colorlinks=false}}
\opt{print}{\hypersetup{colorlinks=true}}
\RequirePackage{xkeyval}
\RequirePackage{fkslang}

\newfontfamily\cyrillicfont[Ligatures=TeX, % recommended
ItalicFont=[cmunti.otf],
BoldFont=[cmunbx.otf],
BoldItalicFont=[cmunbi.otf],
SlantedFont=[cmunsl.otf]
]{[cmunrm.otf]}

\widowpenalty 1000 \clubpenalty 1000 \displaywidowpenalty 1000

% layout settings
\RequirePackage[includeheadfoot,
  twoside,
  a5paper,
  hmargin=1.6cm,
  vmargin=1.0cm,
  headsep=0.2cm]{geometry}
\if@twoside
  \raggedbottom % twoside layout causes expanding vertical space around environments
\fi

% Some packages rely on this condition
\newif\ifyearbook
\yearbooktrue

% FYKOS packages
\RequirePackage{fksmeta}
\RequirePackage{fkssugar}
%\RequirePackage{fkslegacy}
\RequirePackage{fksfigures}

\newcommand\chapternamehdr{}%obsahuje jmeno aktualni casti
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\renewcommand\headrulewidth{0pt}
\renewcommand\footrulewidth{0pt}

%vertikalni centrovani horiz. cary
\newcommand\lineleft[1]{\par\noindent\raisebox{.8ex}{\makebox[\linewidth]{\hrulefill\hspace{1ex}\raisebox{-.8ex}{#1}}}}
\newcommand\lineright[1]{\par\noindent\raisebox{.8ex}{\makebox[\linewidth]{\raisebox{-.8ex}{#1}\hspace{1ex}\hrulefill}}}

\fancyhead[EL]{\lineright{\textit{{\met@shortname}, \Roman{year}. ročník}}}
\fancyhead[OR]{\lineleft{\textit{\chapternamehdr}}}

% options
\fancyfoot{}
\if@twoside
  \fancyfoot[EL]{\bfseries \thepage}
  \fancyfoot[OR]{\bfseries \thepage}
\else
  \fancyfoot[C]{\bfseries \thepage}
\fi

% tabulky řešitelů (musí být před fkstables)
\renewcommand\met@resultsheader{& {\normalfont\bfseries jméno} & škola & $\Sigma$ \\}
\renewcommand\met@resultscols{\newcolumntype{T}{x{\bfseries}rA{\itshape}p{0.3\textwidth}^X% order, name, school
A{\bfseries}r}} % sum

\RequirePackage{fkstables}
\RequirePackage{fksmisc}

% counters
\newcounter{year}
\newcounter{batch}[year]
\newcounter{problem}[batch]
\newcounter{solvedbatch}
\newcounter{serieschapter}

\setcounter{serieschapter}{1}

% Snad to nezávisí na příliš interních makrech (@starttoc), ale funguje to.
\renewcommand\tableofcontents{%
    \chapter*{\met@headeryeartoc}%
    \@starttoc{toc}%
}

%
% Headings
%
\renewcommand\chapter{\@startsection {chapter}{-1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {3.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\Huge}}
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\LARGE}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {0.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\large}}
\renewcommand\subsubsection{\@startsection {subsubsection}{3}{\z@}%
  {-2.25ex \@plus -1ex \@minus -.2ex}%
  {0.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\normalsize}}
\newcommand\problem{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\bfseries\large}}
\newcommand\varproblem{\@startsection {subsection}{2}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\sffamily\Large}}

 %
 % Pro reklamu odlišný styl písma (sans serif) a nadpisů
 %
\newenvironment{comercial}{
\normalfont\sffamily\normalsize
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\sffamily\huge}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\sffamily\Large}}
\renewcommand\subsubsection{\@startsection {subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\sffamily\normalsize}}
}{%
\normalfont\rmfamily\upshape\normalsize
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\rmfamily\upshape\huge}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\rmfamily\upshape\Large}}
\renewcommand\subsubsection{\@startsection {subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\rmfamily\upshape\normalsize}}
}

%pro vypisovani jmena sekce do zahlavi
\newcommand\newchapter[2][]{\chapter[#1]{#2}\renewcommand{\chapternamehdr}{#1}}

\setcounter{secnumdepth}{-2} % do not number headings
\setcounter{tocdepth}{1}

%
% Zadání a řešení úloh
%
\input{problems}
\problemsdir{../problems}
% Podpisy/jména
\input{fkssignature}
\signaturesfile{../signatures.tex}
% bez statistik
\renewcommand\problemstats\relax
% řetezec v labelu pro vzorák
\newcommand\solutionref{solution}
% odkaz na vzorák
\renewcommand\problemtask{%
  \tasktrue\solutionfalse\solutionsinglefalse%
  \stepcounter{problem}%
  \@LoadProblem{\thebatch}{\theproblem}{%
   \problem[\fksMeta@problemLetter{problem}: \@probname]{Úloha \problemnum{batch}{problem} \,\ldots{} \@probname{} \hfill {\normalfont\normalsize\problempoints}}%
   \nopagebreak\ifthenelse{\equal{\@probfig}{N/A}}{}{\@probfig}\nopagebreak%
   \@probtask%
   \signed{\textit{(řešení str. \pageref{\solutionref\thecountx-\thecounty})}}
  }
}
% bez autora námětu a vzoráku (jsou vzadu), suffixování labelů u obrázků v zadání (kolize se skutečným zadáním)
\renewcommand\pr@blemsolution{%
   \varproblem[\fksMeta@problemLetter{problem}: \@probname]%
    {Úloha \problemnum{solvedbatch}{problem} \,\ldots{} \@probname{} \hfill
      {\normalfont\normalsize\problemstats}}%
	  \label{solution\thebatch-\theproblem}%
   \renewcommand\labelsuffix{_sol}\nopagebreak\ifthenelse{\equal{\@probfig}{N/A}}{}{\@probfig}\nopagebreak%
%   \nopagebreak\ifthenelse{\equal{\@probfig}{N/A}}{}{\@probfig}\nopagebreak%
   \textsl{\@probtask}
   \signed{\textit{\@proborigin}}
   \renewcommand\labelsuffix{}
   
   \medskip
   
   \noindent \@probsolution\par
}


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

\newcommand\solutionheading{%
\ifthenelse{\equal{\thesolvedbatch}{0}}{% implicitly set solvedbatch = batch - 1
\setcounter{solvedbatch}{\value{batch}}%
\addtocounter{solvedbatch}{-1}%
}{}%
\setcounter{problem}{0}%
\section[Řešení \Roman{solvedbatch}. série]{\met@headersolutions}}

%nove TODO predelat ze section na chapter
\newcommand\introheading{%
\newchapter[Předmluva]{\met@headeryearintro}}

\newcommand\theorproblemsheading{%
\newchapter[Zadání teoretických úloh]{\met@headeryeartheorproblems}\subpdfbookmark{Úlohy}{book_theory}}

\newcommand\theorsolutionsheading{%
\newchapter[Řešení teoretických úloh]{\met@headeryeartheorsolutions}\subpdfbookmark{Úlohy}{book_theorysol}}

\newcommand\expproblemsheading{%
\newchapter[Zadání experimentálních úloh]{\met@headeryearexpproblems}\subpdfbookmark{Úlohy}{book_exp}}

\newcommand\expsolutionsheading{%
\newchapter[Řešení experimentálních úloh]{\met@headeryearexpsolutions}\subpdfbookmark{Úlohy}{book_expsol}}

\newcommand\seriespartheading[1]{%
\newchapter[#1]{\met@headeryearseries{#1}}}

\newcommand\seriesheading[1]{%TODO mozna subsection
%\addcontentsline{toc}{section}{Kapitola \arabic{serieschapter}: {#1}}
\addtocontents{toc}{\protect\setcounter{tocdepth}{1}} % povolit section v TOC
\section[\met@headeryearserieschaptername: #1]{\met@headeryearserieschapter{#1}}
\addtocontents{toc}{\protect\setcounter{tocdepth}{0}} % zakazat section v TOC
}

\newcommand\seriessolutionsheading{%
\newchapter[\met@headeryearseriessolutionsbasic]{\met@headeryearseriessolutions}\subpdfbookmark{Úlohy}{book_sersol}}

\newcommand\eventsheading{%
\newchapter[Akce \met@shortname u]{\met@headeryearevents}%
}

\newcommand\summerheading{%
\newchapter[Zadání prázdninových úloh]{\met@headersummer}\subpdfbookmark{Úlohy}{book_holiday}%
}

\newcommand\summersolutionsheading{%
\newchapter[Řešení prázdninových úloh]{\met@headersummersolutions}\subpdfbookmark{Úlohy}{book_holidaysol}%
}

\newcommand\resultsheading{%
\newchapter[Pořadí nejlepších řešitelů]{\met@headeryearresults}
}
\newcommand\resultsheadingall{%
	\newchapter[Pořadí řešitelů]{\met@headeryearresultsall}
}

\newcommand\address{
\met@address
}
%pro potreby rocenky
%\newcommand\met@headeryeartheorproblems{Zadání teoretických úloh}
%\newcommand\met@headeryeartheorsolutions{Řešení teoretických úloh}
%\newcommand\met@headeryearexpproblems{Zadání experimentálních úloh}
%\newcommand\met@headeryearexpsolutions{Řešení experimentálních úloh}
%\newcommand\met@headeryearseries[1]{Seriál o #1}
%\newcommand\met@headeryearserieschapter[1]{Kapitola \arabic{serieschapter}: #1}
%\newcommand\met@headeryearseriessolutions{Řešení úloh ze seriálu}
%\newcommand\met@headeryearresults{Pořadí nejlepších řešitelů}
%\newcommand\met@headeryearevents{Akce semináře}%FYKOSu || VYFUKu

%for loop USAGE: \forLoop[STEP]{START}{END}{COUNTERNAME}{COMMANDS}
\newcommand{\forLoop}[5][1]{%
   \setcounter{#4}{#2} %
   \ifthenelse{ \value{#4}<#3 }%
   {%
      #5 %
      \addtocounter{#4}{#1} %
      \forLoop[#1]{\value{#4}}{#3}{#4}{#5} %
   }%
   {%
      #5 %
   }%
}%

%big roman numerals in text
\newcommand{\rom}[1]{\expandafter\@slowromancap\romannumeral #1@}

%
% Settings (credits) and closing page
%
\newcommand\getparam[1]{%
  \expandafter\ifx\csname #1\endcsname\relax
  \PackageWarning{fksyearbook}{Undefined param #1}
  \else
  \expandafter\csname #1\endcsname\fi
}

%\newcommand\@title{}
\newcommand\@subtitle{}
%\newcommand\@author{}
\newcommand\@authors{\@author{} a kolektiv}
\newcommand\@predmluva{}
\newcommand\s@zba{}
\newcommand\obr@zky{}
\newcommand\@korektury{}
\newcommand\@odbornekorektury{}
\newcommand\cislo@publikace{???}
\newcommand\pocet@vytisku{???}
\newcommand\@isbn{???-???-???}
\newcommand\@tiskarna{???}
\newcommand\school@year{????/??}
\newcommand\@published{????}


\renewcommand\title[1]{
\renewcommand\@title{#1}
}
\newcommand\subtitle[1]{
\renewcommand\@subtitle{#1}
}
\renewcommand\author[1]{
\renewcommand\@author{#1}
}
\newcommand\authors[1]{
\renewcommand\@authors{#1}
}
\newcommand\predmluva[1]{
\renewcommand\@predmluva{#1}
}
\newcommand\sazba[1]{
\renewcommand\s@zba{#1}
}
\newcommand\obrazky[1]{
\renewcommand\obr@zky{#1}
}
\newcommand\korektury[1]{
\renewcommand\@korektury{#1}
}
\newcommand\odbornekorektury[1]{
\renewcommand\@odbornekorektury{#1}
}
\newcommand\cislopublikace[1]{
\renewcommand\cislo@publikace{#1}
}
\newcommand\pocetvytisku[1]{
\renewcommand\pocet@vytisku{#1}
}
\newcommand\isbn[1]{
\renewcommand\@isbn{#1}
}
\newcommand\tiskarna[1]{
\renewcommand\@tiskarna{#1}
}
\newcommand\published[1]{
\renewcommand\@published{#1}
}
\newcommand\schoolyear[1]{
\renewcommand\school@year{#1}
}


%
% Authors page
%

\renewcommand\met@licence{
\footnotesize
Fyzikální korespondenční seminář je organizován studenty MFF~UK.
Je zastřešen Oddělením propagace a mediální komunikace MFF~UK
a~podporován Ústavem teoretické fyziky
MFF~UK, jeho zaměstnanci a~Jednotou českých matematiků a~fyziků. 
Realizace projektu byla podpořena Ministerstvem školství, mládeže a tělovýchovy.
\par
}


\newlength{\tmpp@rindent}\newlength{\tmpp@rskip}

\newcommand\nullp@r{%
\setlength{\tmpp@rindent}{\parindent}%
\setlength{\tmpp@rskip}{\parskip}}

\newcommand\revertp@r{%
\setlength{\parindent}\tmpp@rindent%
\setlength{\parskip}\tmpp@rskip}

\newcommand\authorspage{
\newpage
\thispagestyle{empty}
\nullp@r

\setlength{\parindent}{0pt}
\setlength{\parskip}{2pt}

{\LARGE\rmfamily
\textsc{\@authors}\par
\textbf{\@title}\par
\textbf{\@subtitle}}
\bigskip
\setlength{\parskip}{4pt}


\textit{Předmluva:} \@predmluva\par

\met@probthemeauthors

\textit{Řešení úloh:}\par
\hspace{\tmpp@rindent}
\begin{minipage}{\dimexpr\textwidth-\tmpp@rindent-3pt\relax} % 3pt is magic
\input{authors/solauthors}
\end{minipage}\par

\met@authorspage

\ifthenelse{\equal{\s@zba}{}}{}{\textit{Sazba:} \s@zba\par}
\ifthenelse{\equal{\obr@zky}{}}{}{\textit{Obrázky a grafy:} \obr@zky\par}
\ifthenelse{\equal{\@korektury}{}}{}{\textit{Jazykové korektury:} \@korektury\par}
\ifthenelse{\equal{\@odbornekorektury}{}}{}{\textit{Odborné korektury:} \@odbornekorektury\par}

\revertp@r

\makefooter
}

%
% Closing page
%

\newcommand\closingpage{
\newpage
\nullp@r
\null\vfill
\begin{center}
\begin{minipage}{10cm}
\noindent{\LARGE\rmfamily
\textsc{\@authors}\par
\textbf{\@title}\par
\textbf{\@subtitle}}
\bigskip\bigskip\bigskip

Vydal \mffpress\\
nakladatelství Matematicko-fyzikální fakulty\\
Univerzity Karlovy\\
Sokolovská 83, 186\,75 Praha 8\\
jako svou \cislo@publikace. publikaci.
\bigskip

Vytiskl \@tiskarna
\bigskip

Publikace neprošla recenzním ani lektorským řízením.\\
Nakladatelství neodpovídá za kvalitu a obsah textu.\\
Vydáno pro interní potřebu MFF UK.\\
Neprodejná publikace
\bigskip

\pageref{LastPage} stran, \arabic{figure} obrázků\\
Sazba písmem Latin Modern v programu \XeLaTeX \\
Vydání první\\
Náklad \pocet@vytisku~výtisků
\bigskip

Praha \@published
\bigskip\bigskip\bigskip

ISBN \@isbn
\end{minipage}
\end{center}
\revertp@r
}

\newcommand\makefooter{%
\vspace*{\fill}
\noindent\begin{minipage}{\textwidth}
\hrule
\smallskip
\begin{center}
\met@licence
\end{center}
\end{minipage}
}

%
% Title page
%
\newcommand\titlefontsc{\fontsize{20pt}{20pt}\selectfont\scshape}
\newcommand\titlefontmain{\fontsize{40pt}{60pt}\selectfont\bfseries}
\newcommand\titlefontsub{\fontsize{20pt}{20pt}\selectfont\bfseries}

\renewcommand\maketitle{%
	\thispagestyle{empty}

	\begin{center}
	\null\vspace{12pt}
	{\titlefontsc\@authors}
	\vspace{36pt}

	{\titlefontmain\@title}
	\vspace{36pt}

	{\titlefontsub\@subtitle}
	\vspace{72pt}

	\includegraphics[width=0.7\textwidth]{logo3.pdf}

	\end{center}
}

\newcommand\copyrightpage{%
\newpage
\thispagestyle{empty}
\null\vfill
\nullp@r
\begin{tabular}{@{}l@{}l}
 Copyright \copyright &\ \@author, \@published\\
 Copyright \copyright &\ \mffpress, nakladatelství Matematicko-fyzikální fakulty\\
 &\ Univerzity Karlovy, \@published
\end{tabular}
\vspace{1cm}

ISBN \@isbn
\revertp@r
}


%
% Misc
%
\newcommand\mffpress{MatfyzPress}

\AtBeginDocument{%
  \renewcommand\figurename{Obr.}
  \renewcommand\tablename{Tab.}
}

