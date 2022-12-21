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

\RequirePackage{fksserial}
\RequirePackage{fksproblems}
\RequirePackage{fksserial}
\RequirePackage{fkssections}

% other
\let\oldfooter\makefooter
\renewcommand\makefooter{%
	\null
	\vfill
	\makeaddress
	\oldfooter
}
