%
% @author Michal Koutný <michal@fykos.cz>
% @testing Lukáš Timko <spam-no-thanks>
% 
% This work is licenced under CC BY-SA 3.0 licence.
% Full form can be found at http://creativecommons.org/licenses/by-sa/3.0/.
%
% @description Class for typesetting solutions of physical problems for participants.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fkssolpub}[2011/10/26 FKS Solution public]

% inherit from article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[10pt]{article}

% layout settings
\RequirePackage[
  a4paper,
  margin=2cm,  
  headsep=0.8cm,
  headheight=13pt]{geometry}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[L]{\textbf{\'Uloha \@series.\leftmark}}
\fancyhead[R]{\sch@ol, \textbf{\@author}}
\fancyfoot{}
\fancyfoot[C]{\bfseries \thepage/\pageref{pg:\theproblem}}

% problem managing
\newcommand\@series{0}
\newcommand\series[1]{
\renewcommand\@series{#1}}

\newcounter{problem}
\newcommand\sch@ol{N/A}
\newcommand\school[1]{
\renewcommand\sch@ol{#1}}

\let\oldmarkboth\markboth
\renewcommand\markboth[2]{\relax}
\newcommand\pr@blem{??}
\newenvironment{problem}[1]{%
\clearpage
\oldmarkboth{#1}{}
\setcounter{page}{1}
\stepcounter{problem}
}{%
\label{pg:\theproblem}
}

% comfort macros
%\RequirePackage{fkssugar}




