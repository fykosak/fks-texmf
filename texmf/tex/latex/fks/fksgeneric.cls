%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for supporting loading problems, sugar, figures etc.
%              with possible redefinition of header/footer texts
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksgeneric}[2012/01/07 Customizable generic class]

% inherit from fksbase class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions
\LoadClass{fksbase}

\newcommand{\leftheader}[1]{%
\renewcommand\met@headername{#1}%
\AtBeginDocument{\hypersetup{pdftitle={#1}}}}
\newcommand{\rightheader}[1]{\renewcommand\met@volumeid{#1}}


\renewcommand\makefooter{%
\vspace*{\fill}
\noindent\begin{minipage}{\textwidth}
\hrule
\smallskip
\begin{center}
\met@licence
\end{center}
\end{minipage}
}