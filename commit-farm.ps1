$inicio = Get-Date "2026-01-01"
$fim = Get-Date "2026-12-31"
$data = $inicio

while ($data -le $fim) {
    $texto = $data.ToString("yyyy-MM-dd")
    Add-Content -Path "historico.txt" -Value $texto
    git add historico.txt

    $env:GIT_AUTHOR_DATE = "$texto 12:00:00"
    $env:GIT_COMMITTER_DATE = "$texto 12:00:00"

    git commit -m "Commit $texto"
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Falha no commit de $texto"
    }

    $data = $data.AddDays(1)
}

Remove-Item Env:\GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
Remove-Item Env:\GIT_COMMITTER_DATE -ErrorAction SilentlyContinue
