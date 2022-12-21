%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for solution leaflet. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fkssolution}[2011/09/23 Solution leaflet]

% inherit from fksbase class
\LoadClass{fksbase}

\RequirePackage{fksmeta}
\RequirePackage{fksproblems}

\rightheader{\fksMeta@problemSolutionTitle~\fksMeta@formatContestYear{year}.\problemNum{solvedbatch}{problem}}

\hypersetup{
	pdftitle={\fksMeta@contestNameShort, \fksMeta@formatContestYear{year}.\problemNum{solvedbatch}{problem} \@probname},
	pdfauthor={\@probsolauthors} % TODO get authors full name
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions\relax
