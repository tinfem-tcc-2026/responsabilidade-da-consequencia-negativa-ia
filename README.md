# Template para criação de artigos científicos em Markdown

Escreva seus artigos científicos em markdown e veja-os sendo transformados em
pdf seguindo as normas abnt.

## Inicializando o projeto

Antes de proceder, certifique-se de ter inicializado o projeto com ``npm init``!

### Compilando o artigo

> [!WARNING]
> Para compilar o pdf localmente, você precisará do docker instalado.

Para compilar o seu artigo, basta executar o seguinte comando:

```bash
$ npm run build
```

que ele será salvo em ``./build/output.pdf``.

### Corretor ortográfico

#### Executando o corretor

Para realizar a verificação de ortografia utilizando o corretor incluso, basta
executar o seguinte comando:

```bash
$ npm run corretor:analisar
```

e ele exibirá o diagnóstico de todos os arquivos de markdown na pasta ``./src``.

#### Adicionando palavras ao dicionário

Caso o corretor acuse uma palavra mesmo que ela seja válida, você também tem a
opção de adicioná-la à whitelist. Para isto, basta executar o seguinte comando:

```bash
$ npm run corretor:ignorar
```

e a whitelist será atualizada em ``./_meta/dicts/whitelist.txt``.

## Créditos

Baseado no projeto do [dsoaress](https://github.com/dsoaress/abnt-pandoc), sendo adaptado para as
minhas necessidades específicas.
