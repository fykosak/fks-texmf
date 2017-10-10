%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for supporting loading problems, sugar, figures etc.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksempty}[2011/10/13 Empty template for various leaflets]

% inherit from fksbase class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions
\LoadClass{fksbase}

\fancyhf{}
\renewcommand{\headrulewidth}{0pt}

\AtBeginDocument{\hypersetup{pdftitle={}}}

\geometry{ignoreheadfoot,
  a5paper,
  margin=0.7cm,
  headsep=0.2cm}






