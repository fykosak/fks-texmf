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

\RequirePackage{fksmeta}
\RequirePackage{fksserial}
\RequirePackage{fksproblems}
\RequirePackage{fksserial}
\RequirePackage{fkssections}

\AtBeginDocument{
	\hypersetup{pdftitle={\fksMeta@headerLeft}}
}
