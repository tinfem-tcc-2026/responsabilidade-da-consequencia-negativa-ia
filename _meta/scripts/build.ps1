if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "Docker não está disponível em seu sistema, siga as instruções e instale: https://docs.docker.com/get-started/get-docker/"
    exit 1
}

& docker image inspect pandoc 1>$null 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Docker image não encontrada, realizando build neste instante"
    docker build -t pandoc .
    Write-Host "Feito!"
}

Write-Host "Gerando PDF"

$files = @(Get-ChildItem -Path . -Filter "*.md" -Recurse -Exclude "README.md" |
    Where-Object { $_.FullName -notmatch "node_modules|_meta" } |
    Sort-Object FullName |
    ForEach-Object { (Resolve-Path -Path $_.FullName -Relative).Replace('\', '/') })
$files += "./_meta/_referencias.md"

$dockerArgs = @(
    "run"
    "--rm"
    "-v", "./:/app"
    "-v", "./build:/app/build"
    "pandoc"
) + $files + @(
    "--bibliography", "./src/bibliografia.bib"
    "-o", "build/output.pdf"
)

& docker @dockerArgs
if ($LASTEXITCODE -ne 0) {
    Write-Host "Falhas ao gerar o PDF"
    exit 1
}

Write-Host "O PDF foi gerado com sucesso"
