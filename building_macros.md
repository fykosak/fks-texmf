# Make a lokální překlad

## 1) Windows

### 1) WSL

Nainstalujte si Windows Subsystem for Linux ([WSL](https://learn.microsoft.com/en-us/windows/wsl/install))

## 2) Linux/WSL

### 1) Git

Na Linuxu/WSL si nainstalujte [Git](https://git-scm.com/downloads) pomocí:

```
sudo apt install git
```

#### SSH Klíč

Podle návodu níže si vygenerujte SSH klíč pro bezpečnou komunikaci se serverem.

Návod na vygenerování nového SSH klíče najdete [zde](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent). 

Svůj veřejný klíč najdete ve složce `~/.ssh/` s příponou `.pub`

#### Používání Gitu

Při prvním použití si nastavte jméno a email pomocí následujících příkazů:

```
git config --global user.name "Jméno Příjmení"
git config --global user.email "váš email"
```

Kopii repozitáře získáte pomocí:

```
git clone gitea@fykos.cz:Vyfuk/vyfuk<rocnik>.git
```

Tento příkaz stáhne celou kopii repozitáře k vám do aktuální složky.

Více se můžete dozvědět [zde](https://wiki.vyfuk.org/navody/it/git).

#### Základní příkazy v Gitu

- `git pull` - aktualizuje vaší (lokální) verzi repozitáře
- `git add .` - řekne Gitu aby sledoval změny ve všech souborech, které ještě nesleduje
- `git commit -m [<série>-<úloha>] <zpráva>` - shromáždí všechny změny do jednoho "balíčku"
- `git push` - synchronizuje vaše úpravy repozitáře s online repozitářem
- `git status` - řekne vám aktuální status Gitu (změny, commity, ...)
- `git reset` - vrátí změny na poslední commit

### 2) Gitea

Přihlašte se na [Giteu](https://git.fykos.cz/). Login je vaše příjmení + první písmeno jména.
Po prvním přihlášení si změňte heslo, vyplňte údaje v profilu a přidejte si tam i svůj veřejný SSH klíč.

### 3) Makra

Dokumentaci FYKOSích maker můžete najít v souboru [zde](https://raw.githubusercontent.com/fykosak/fks-texmf/master/texmf/doc/fks/jakpsat.pdf).

#### Instalace ze zdroje

Nainstalujte si make pomocí:

```
sudo apt install make
```

Dále si nainstalujete xsltproc, inkscape, xelatex:

```
sudo apt-get update
sudo apt-get -y install xsltproc

sudo apt install inkscape

sudo apt install texlive
sudo apt install texlive-base texlive-xetex texlive-lang-english texlive-lang-czechslovak
```

Naklonujte si FYKOSí repozitář `fks-texmf`:

```
git clone git@github.com:fykosak/fks-texmf.git
```

Přesuňte se do naklonované složky a spusťtě `make install`:

```
cd fks-texmf
sudo make install
```

Tento postup opakujte i s repozitáři `fks-templates` a `fks-scripts`.

#### Fix na uvozovkové makro

Vytvořte soubor `~/texmf/tex/latex/polyglossia/gloss-czech.ldf` s obsahem uvedeným v původním dokumentu.

```tex
\ProvidesFile{gloss-czech.ldf}[polyglossia: module for czech]

\PolyglossiaSetup{czech}{
  bcp47=cz,
  hyphennames={czech},
  hyphenmins={2,2},
  langtag=CSY,
  frenchspacing=true,
  fontsetup=true,
}

% BCP-47 compliant aliases
\setlanguagealias*{czech}{cz}

\ifluatex
  \RequirePackage{luavlna}
\fi

\define@boolkey{czech}[czech@]{babelshorthands}[true]{}

\define@boolkey{czech}[czech@]{splithyphens}[true]{}

\define@boolkey{czech}[czech@]{vlna}[true]{}

% Register default options
\xpg@initialize@gloss@options{czech}{babelshorthands=false,splithyphens=true,vlna=true}

\ifsystem@babelshorthands
  \setkeys{czech}{babelshorthands=true}
\else
  \setkeys{czech}{babelshorthands=false}
\fi

%\ifcsundef{initiate@active@char}{%
%  \input{babelsh.def}%
%  \initiate@active@char{"}%
%  \shorthandoff{"}%
%}{}

\def\czech@@splithyphen#1{%
  \def\czech@sh@tmp{%
       \if\czech@sh@next-#1%
       \else\expandafter\czech@@@splithyphen{#1}\fi%
     }%
     \futurelet\czech@sh@next\czech@sh@tmp%
}

\def\czech@@@splithyphen#1{%
  \ifnum\hyphenchar \font>0%
    \kern\z@\discretionary{-}{\char\hyphenchar\the\font}{#1}%
    \nobreak\hskip\z@%
  \else%
    #1%
  \fi%
}

\def\czech@splithyphen{%
  \czech@@splithyphen{-}%
}

\def\czech@shorthands{%
  \bbl@activate{"}%
  \def\language@group{czech}%
  \declare@shorthand{czech}{"=}{\czech@splithyphen}%
  \declare@shorthand{czech}{"`}{„}%
  \declare@shorthand{czech}{"'}{“}%
  \declare@shorthand{czech}{"<}{«}%
  \declare@shorthand{czech}{">}{»}%
}

\def\noczech@shorthands{%
  \@ifundefined{initiate@active@char}{}{\bbl@deactivate{"}}%
}

\ifxetex
  % splithyphens
  \newXeTeXintercharclass\czech@hyphen % -
  % vlna
  \newXeTeXintercharclass\czech@openpunctuation
  \newXeTeXintercharclass\czech@nonsyllabicpreposition
  \ifdefined\e@alloc@intercharclass@top
    \chardef\czech@boundary=\e@alloc@intercharclass@top
  \else
    \ifdefined\XeTeXinterwordspaceshaping
      \chardef\czech@boundary=4095 %
      \def\newXeTeXintercharclass{%
        \e@alloc\XeTeXcharclass\chardef
              \xe@alloc@intercharclass\m@ne\@ucharclass@boundary}%
    \else
      \chardef\czech@boundary=255
    \fi
  \fi
\fi

\def\czech@hyphens{%
    \ifluatex
      \AfterPreamble{\enablesplithyphens{czech}}%
    \else
      \XeTeXinterchartokenstate=1
      \XeTeXcharclass `\- \czech@hyphen
      \XeTeXinterchartoks \z@ \czech@hyphen = {\czech@@splithyphen}% "-" -> "\czech@@splithyphen-"
      % necessary if used together with vlna:
      \XeTeXinterchartoks \czech@nonsyllabicpreposition \czech@hyphen = {\czech@@splithyphen}% "-" -> "\czech@@splithyphen-"
    \fi%
}

\def\noczech@hyphens{%
    \ifluatex
      \AfterPreamble{\disablesplithyphens{czech}}%
    \else
      \XeTeXcharclass `\- \z@
    \fi%
}

% Add nonbreakable space after single-letter word to
% prevent them to land at the end of a line
% vlna code taken and adapted from xevlna.sty
\ifxetex
    \def\czech@nointerchartoks{\let\czech@interchartoks\czech@PreCSpreposition}%
    \def\czech@PreCSpreposition{%
       \def\next{}%
       \ifnum\catcode`\ =10 % nothing will be done in verbatim
       \ifmmode % nothing in math
       \else
          \let\czech@interchartoks\czech@nointerchartoks
          \let\next\czech@ExamineCSpreposition
       \fi\fi
       \next%
    }%
    \def\czech@ExamineCSpreposition #1{#1\futurelet\next\czech@ProcessCSpreposition}%
    \def\czech@ProcessCSpreposition{\ifx\next\czech@XeTeXspace\nobreak\fi}%
    \futurelet\czech@XeTeXspace{ }\czech@nointerchartoks
\fi

\def\czech@vlna{%
    \ifluatex
       \preventsingleon
    \else
        % Code taken and adapted from xevlna.sty
        \XeTeXinterchartokenstate=1
        \XeTeXcharclass `\( \czech@openpunctuation
        \XeTeXcharclass `\[ \czech@openpunctuation
        \XeTeXcharclass `\„ \czech@openpunctuation
        \XeTeXcharclass `\» \czech@openpunctuation
        \XeTeXcharclass `\K \czech@nonsyllabicpreposition
        \XeTeXcharclass `\k \czech@nonsyllabicpreposition
        \XeTeXcharclass `\S \czech@nonsyllabicpreposition
        \XeTeXcharclass `\s \czech@nonsyllabicpreposition
        \XeTeXcharclass `\V \czech@nonsyllabicpreposition
        \XeTeXcharclass `\v \czech@nonsyllabicpreposition
        \XeTeXcharclass `\Z \czech@nonsyllabicpreposition
        \XeTeXcharclass `\z \czech@nonsyllabicpreposition
        \XeTeXcharclass `\O \czech@nonsyllabicpreposition
        \XeTeXcharclass `\o \czech@nonsyllabicpreposition
        \XeTeXcharclass `\U \czech@nonsyllabicpreposition
        \XeTeXcharclass `\u \czech@nonsyllabicpreposition
        \XeTeXcharclass `\A \czech@nonsyllabicpreposition
        \XeTeXcharclass `\a \czech@nonsyllabicpreposition
        \XeTeXcharclass `\I \czech@nonsyllabicpreposition
        \XeTeXcharclass `\i \czech@nonsyllabicpreposition
        \XeTeXinterchartoks \czech@boundary \czech@nonsyllabicpreposition {\czech@interchartoks}%
        \XeTeXinterchartoks \czech@openpunctuation \czech@nonsyllabicpreposition {\czech@interchartoks}%
    \fi
}

\def\noczech@vlna{%
    \ifluatex
        \preventsingleoff
    \else
        \XeTeXcharclass`\(\z@
        \XeTeXcharclass`\[\z@
        \XeTeXcharclass`\„\z@
        \XeTeXcharclass`\»\z@
        \XeTeXcharclass`\K\z@
        \XeTeXcharclass`\k\z@
        \XeTeXcharclass`\S\z@
        \XeTeXcharclass`\s\z@
        \XeTeXcharclass`\V\z@
        \XeTeXcharclass`\v\z@
        \XeTeXcharclass`\Z\z@
        \XeTeXcharclass`\z\z@
        \XeTeXcharclass`\O\z@
        \XeTeXcharclass`\o\z@
        \XeTeXcharclass`\U\z@
        \XeTeXcharclass`\u\z@
        \XeTeXcharclass`\A\z@
        \XeTeXcharclass`\a\z@
        \XeTeXcharclass`\I\z@
        \XeTeXcharclass`\i\z@
    \fi
}


\def\captionsczech{%
   \def\refname{Reference}%
   \def\abstractname{Abstrakt}%
   \def\bibname{Literatura}%
   \def\prefacename{Předmluva}%
   \def\chaptername{Kapitola}%
   \def\appendixname{Dodatek}%
   \def\contentsname{Obsah}%
   \def\listfigurename{Seznam obrázků}%
   \def\listtablename{Seznam tabulek}%
   \def\indexname{Index}%
   \def\figurename{Obrázek}%
   \def\tablename{Tabulka}%
   %\def\thepart{}%
   \def\partname{Část}%
   \def\pagename{Strana}%
   \def\seename{viz}%
   \def\alsoname{viz}%
   \def\enclname{Příloha}%
   \def\ccname{Na vědomí:}%
   \def\headtoname{Komu}%
   \def\proofname{Důkaz}%
   \def\glossaryname{Slovník}%was Glosář
}

\def\dateczech{%
   \def\today{\number\day.~\ifcase\month\or
    ledna\or února\or března\or dubna\or května\or
    června\or července\or srpna\or září\or
    října\or listopadu\or prosince\fi
    \space \number\year}%
}

\def\noextras@czech{%
  \ifczech@babelshorthands\noczech@shorthands\fi%
  \noczech@hyphens%
  \noczech@vlna%
  \ifxetex\XeTeXinterchartokenstate=0\fi%
}

\def\blockextras@czech{%
  \ifczech@babelshorthands\czech@shorthands\else\noczech@shorthands\fi%
  \ifczech@vlna\czech@vlna\else\noczech@vlna\fi%
  \ifczech@splithyphens\czech@hyphens\else\noczech@hyphens\fi%
}

\def\inlineextras@czech{%
  \ifczech@babelshorthands\czech@shorthands\else\noczech@shorthands\fi%
  \ifczech@vlna\czech@vlna\else\noczech@vlna\fi%
  \ifczech@splithyphens\czech@hyphens\else\noczech@hyphens\fi%
}

\endinput
```

### 4) Lokální překlad

Přesuňtě se do libovolné složky jejíž obsah chcete přeložit (z hlediska časové efektivity se vyplatí překladátat jen soubory, které opravdu potřebujete), např. `cd batch1`, a použijte jeden z příkazů níže. Přeložené soubory najde ve složce `<aktualni_slozka>/out`.

- `make` - přeloží všechny soubory v aktuální složce
- `make brojure` - vytvoří pdf brožurku zadání a brožurku celé série
- `make web` - vytvoří brožurku určenou ke zveřejnění na webu a xml soubor s texty zadání rovněž pro upload na web
- `make book` - vytvoří pdf brožurku
- `make print` - vytvoří jen brožurku určenou k tisku
- `make solutions` - vytvoří jen pdf soubory s jednotlivými vzoráky
- `make series` - vytvoří pdf seriálu (výfučtení)
- `make out/soubor.pdf` - vytvoří pdf jen daného souboru (pokud chcete pdf konkrétní úlohy přesuňte se do složky dané série a použijte `make out/reseniX-Y.pdf`)
- `make clean` - odstraní všechny pomocné soubory v aktuální složce
- `make clenall` - odstraní i pdf soubory

Pokud chcete (a máte dostatečná práva ve FKSDB) můžete si do souboru `Makefile.conf` přidat své přihlašovací jméno a heslo do databáze a pak se vám z ní budou stahovat body, když smažete soubory `results` a `stats` ve složce `data`.

#### Troubleshooting

V případě že se v překládaném souboru nachází chyba program nedoběhne. Program můžete ukončit pomocí `x` anebo kombinací `Ctrl + C`.

### 5) Astrid

Na [Astrid](https://astrid.fykos.cz/) najdete všechny aktuální přeložené soubory. Přihlašovací jméno je „vyfuk", heslo znáte (pokud ne napište někomu z kolegů).