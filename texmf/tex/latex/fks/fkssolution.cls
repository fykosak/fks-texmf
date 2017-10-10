%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for solution leaflet. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fkssolution}[2011/09/23 Solution leaflet]

% inherit from fksbase class
\LoadClass{fksbase}

\DeclareOption{fykos}{
	\fancyhead{}
	\fancyhead[L]{\bfseries\small \met@headername}
	\fancyhead[R]{\bfseries\small Řešení \Roman{year}.\problemnum{solvedbatch}{problem}}
}

\DeclareOption{vyfuk}{
	\fancyhead{} % To get rid of fksbaseheader, cleaning it up.
	\pagestyle{fancy} % New definition of header starts here.
	\renewcommand{\headrulewidth}{0pt}
	\chead{\setlength{\parindent}{0pt}
		\colorbox{black}{
	     	\begin{minipage}{\textwidth-6pt}
	      		\textcolor{white}{\raisebox{-8.5pt}{\bfseries\sffamily 
	      		\met@headername{}} \hfill \raisebox{-8.5pt}{\bfseries\sffamily 
	      		Řešení \Roman{year}.\problemnum{solvedbatch}{problem}}}
	     	\end{minipage}
		}
	}
	\setlength{\headsep}{5mm}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions\relax
