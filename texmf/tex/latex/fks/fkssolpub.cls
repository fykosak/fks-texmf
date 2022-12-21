%
% @author Michal Koutný <michal@fykos.cz>
% @testing Lukáš Timko <spam-no-thanks>
% 
% This work is licenced under CC BY-SA 3.0 licence.
% Full form can be found at http://creativecommons.org/licenses/by-sa/3.0/.
%
% @description Class for typesetting solutions of physical problems for participants.
%

% Expected usage:
% \documentclass[10pt,a4paper]{fkssolpub}
% <include your packages>
%
% \author{<authors name>}
% \school{<authors school>}
% \series{<current series number>}
% \problem{<current problem number>}
%
% \begin{document}
%     <solution text>
% \end{document}

% Using \problemName{} you can also change the problem word in a header.
% By default, it's set to the Czech variant 'Úloha', but can be changed for
% example to the english translation 'Problem' or 'Solution'.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fkssolpub}[2011/10/26 FKS Solution public]

% inherit from article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[10pt,a4paper]{article}

% layout settings
\RequirePackage[
  margin=2cm,
  headsep=0.8cm,
  headheight=13pt]{geometry}

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[L]{\textbf{\fksSol@problemName~\fksSol@series.\fksSol@problem}}
\fancyhead[R]{\fksSol@school, \textbf{\@author}}
\fancyfoot{}
\fancyfoot[C]{\bfseries \thepage/\pageref{LastPage}}

% save the series number, problem number and school name
\newcommand\fksSol@school{N/A}
\newcommand\fksSol@series{N/A}
\newcommand\fksSol@problem{N/A}
\newcommand\fksSol@problemName{Úloha}

% setters for school, series and problem
\newcommand\school[1]{
\renewcommand\fksSol@school{#1}}
\newcommand\series[1]{
\renewcommand\fksSol@series{#1}}
\newcommand\problem[1]{
\renewcommand\fksSol@problem{#1}}
\newcommand\problemName[1]{
\renewcommand\fksSol@problemName{#1}}

% compatibility with older solutions
\def\endproblem{}
