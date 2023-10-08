<# 
    O comando Get-Chielditem (alias gci) com o parâmetro "-Recurse" 
    obtem os arquivos e diretórios das pastas filhas

    Para quebrar linhas utilizar crase (`)

#>

Clear-Host

# Setando os diretórios raíz e log.

[String]$dirRaiz = "D:\Powershell\Testes"
[String]$dirLog = "D:\Powershell\log"

# Abrindo o diretório de trabalho
cd $dirRaiz

[String]$saida = ""

$dataRef = Get-Date
$dataRef = $dataRef.AddDays(-1)

# Selecionando os arquivos e colocando em um array
@($todosOsArquivos = Get-ChildItem -Recurse -File)

# Selecionando todos os objetos do diretório
#$dados = Get-ChildItem -recurse | Select-Object

# Percorrendo todos os arquivos
$todosOsArquivos.ForEach({
    
    [String]$nomeArquivo = $_.FullName 
    $getDate = Get-Date 
     
    if ($_.LastWriteTime -lt $dataRef) {
        try{
            # throw [System.IO.FileNotFoundException]::new()

            # Removendo o item
            Remove-Item -Force -Path $nomeArquivo

            $saida = "WARN: " + $getDate.ToString("yyyy-MM-dd HH:mm:ss") `
                + " - Arquivo excluído - LastWriteTime: " `
                + $_.LastWriteTime.ToString("yyyy-MM-dd hh:mm:ss") `
                + " - Path: `"" + $nomeArquivo + "`"" 
            Write-Host $saida
            $saida | Out-File -Append "$dirLog\log.log"

        } catch{

            $saida = "ERRO: " + $getDate.ToString("yyyy-MM-dd HH:mm:ss") `
             + " - Arquivo não excluído - `"" + $nomeArquivo + "`" " + $_
             Write-Host $saida
             $saida | Out-File -Append "$dirLog\log.log"  
        }
        
    } 
    #else {
     #   Write-Host "Manter arquivo data: " $_.LastWriteTime.ToString("yyyy-MM-dd hh:mm:ss") `
     #        " Path `""$nomeArquivo "`"" -Separator ""
    #}
     
})


# Selecionando os diretórios inclusive os filhos e colocando em um array
@($todosDiretorios = Get-ChildItem -Recurse -Directory)

# Percorrendo todos os diretórios

$todosDiretorios.ForEach({

    # Diretórios criados ou modificados antes da data de referência e vazios serão excluídos
    if (($_.CreationTime -lt $dataRef -or $_.LastWriteTime -lt $dataRef) `
            -and $_.GetDirectories().Length -eq 0 -and $_.GetFiles().Length -eq 0) {

        $getDate = Get-Date
        try {
            [String]$nameDir = $_.FullName
            # throw [System.IO.DirectoryNotFoundException]::new()

            # Removendo o item
            Remove-Item -Force -Path $nameDir
            $saida = "WARN: " + $getDate.ToString("yyyy-MM-dd HH:mm:ss") `
                + " - Directory: `"$nameDir`" has been deleted."
            Write-Host $saida
            $saida | Out-File -Append "$dirLog\log.log" 

        } catch{
            $saida = "ERRO: " + $getDate.ToString("yyyy-MM-dd HH:mm:ss") `
                + " - Directory: `"$nameDir`" $_" 
            Write-Host $saida
            $saida | Out-File -Append "$dirLog\log.log" 
        }
        
    }     

})
