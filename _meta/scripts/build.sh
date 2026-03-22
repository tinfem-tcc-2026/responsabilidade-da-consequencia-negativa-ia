#!/bin/bash

if ! command -v docker -v > /dev/null; then
    echo "Docker não está disponível em seu sistema, siga as instruções e instale: https://docs.docker.com/get-started/get-docker/"
    exit 1
fi

if ! docker image inspect pandoc 1> /dev/null 2>&1; then
    echo "Docker image não encontrada, realizando build neste instante"
    docker build -t pandoc .
    echo "Feito!"
fi

echo "Gerando PDF"

if docker \
    run --rm -v ./:/app -v ./build:/app/build \
        pandoc $(find . -path ./node_modules -prune , -path ./_meta -prune , -name "*.md" ! -name "README.md" | sort) ./_meta/_referencias.md \
        --bibliography ./src/bibliografia.bib \
        -o build/output.pdf; then
    echo "O PDF foi gerado com sucesso"
else
    echo "Falhas ao gerar o PDF"
fi
