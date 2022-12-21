%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides base class (margins + headings)
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksbase}[2011/09/11 Base class]

% inherit from article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax
\LoadClass[9pt,a5paper]{extarticle}

% packages
\@ifundefined{UseOption}{\def\UseOption{web}}{} % when no option set, we use web settings
\RequirePackage{optional} % ought be first

% font packages
\RequirePackage[no-math]{fontspec} % no-math is because of mathrm(Omega)
\RequirePackage{xunicode}
\RequirePackage{microtype}

\newfontfamily\cyrillicfont[
	Ligatures=TeX, % recommended
	Script=Cyrillic,
	ItalicFont=[cmunti.otf],
	BoldFont=[cmunbx.otf],
	BoldItalicFont=[cmunbi.otf],
	SlantedFont=[cmunsl.otf]
]{[cmunrm.otf]}

% IPA font (usage: \textIPA{<unicode string>})
% Note: font is visually different from Latin Modern,
%       however, `tipa` package is only for LaTeX (8b encoding).
\newfontfamily\doulos{Doulos SIL}
\DeclareTextFontCommand{\textIPA}{\doulos}

% useful packages
\RequirePackage[version=4]{mhchem}
\RequirePackage{amssymb}
\RequirePackage{paralist}

\RequirePackage{listings} % for code listings
\lstset{%
	basicstyle=\footnotesize\ttfamily,%
	columns=fixed,%
	showstringspaces=false,%
	showspaces=false,%
	frame=single,%
	breaklines=true%
}

% links
\RequirePackage[hyphens]{url}
\RequirePackage[xetex,
	setpagesize=false,
	linkcolor=black,
	anchorcolor=black,
	citecolor=black,
	filecolor=black,
	urlcolor=black,
	bookmarks=true,
]{hyperref}
\opt{web}{\hypersetup{colorlinks=false}}
\opt{print}{\hypersetup{colorlinks=true}}

% layout settings
\RequirePackage[
	includeheadfoot,
	margin=0.7cm,
	headsep=0.2cm
]{geometry}
\if@twoside
	\raggedbottom % twoside layout causes expanding vertical space around environments
\fi

\widowpenalty 1000 \clubpenalty 1000 \displaywidowpenalty 1000

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[L]{\bfseries\small \fksMeta@headerLeft}
\fancyhead[R]{\bfseries\small \fksMeta@headerRight}

% options
\fancyfoot{}
\if@twoside
	\fancyfoot[EL]{\bfseries \thepage}
	\fancyfoot[OR]{\bfseries \thepage}
\else
	\fancyfoot[C]{\bfseries \thepage}
\fi

% FYKOS packages
\RequirePackage{fkssugar} % needs to be loaded after hyperref due to \C redefinition
\RequirePackage{fksmeta}
\RequirePackage{fksfigures}
\RequirePackage{fkstables}

\setcounter{secnumdepth}{-1} % do not number headings

\newcommand\makefooter{%
	\vspace*{\fill}
	\noindent\begin{minipage}{\textwidth}
		\hrule
		\smallskip
		\makelicence
	\end{minipage}
}
