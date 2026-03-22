FROM ubuntu:22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y install \
    texlive-publishers \
    texlive-latex-extra \
    texlive-xetex \
    fonts-liberation \
    texlive-lang-spanish \
    texlive-lang-french \
    texlive-lang-portuguese \
    wget

RUN wget -c https://github.com/jgm/pandoc/releases/download/2.9.1.1/pandoc-2.9.1.1-1-amd64.deb && \
    dpkg -i pandoc-2.9.1.1-1-amd64.deb && \
    gem install pandoc_abnt

FROM base AS pandoc

WORKDIR /app

COPY ./_meta/abnt.csl .
COPY ./_meta/abnt.latex .

ENTRYPOINT [ \
    "pandoc", \
    "-s", \
    "-F", \
    "pandoc_abnt", \
    "-F", \
    "pandoc-citeproc", \
    "--csl=./_meta/abnt.csl", \
    "--template=./_meta/abnt.latex", \
    "--pdf-engine=xelatex" \
]
