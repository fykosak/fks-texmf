%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for series leaflet. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksseries}[2011/10/26 Series leaflet]

% inherit from fksbase class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions
\LoadClass{fksbase}

\fancyhead{}
\fancyhead[L]{\bfseries\small \met@shortname}
%\fancyhead[R]{\bfseries\small Řešení \Roman{year}.\Roman{solvedbatch}.\metaprobletter{problem}}

\newcommand\seriesheading[1]{%
\hypersetup{
    pdftitle={Seriál \Roman{year}.\Roman{batch} #1, \met@shortname}%
}
\fancyhead[R]{\bfseries\small Seriál \Roman{year}.\Roman{batch} #1}
\section[#1]{\met@headerseries{#1}}}






