# Remover pasta 
Clear-Host
$dirRaiz = 'D:\Powershell\Testes'
cd $dirRaiz
$dataBase = Get-Date
$dataBase = $dataBase.AddDays(-31)


if ($dataBase -ge $dataDoArquivo) {
    Write-Host "Não excluir o arquivo"
} else {
    Write-Host "Excluir o arquivo"
}

Write-Host $dataBase
# -Recurse apaga sem confirmação
Remove-Item -Force -Path "$dirRaiz\teste3.txt"
Remove-Item -Force -Path "$dirRaiz\teste2.txt"


Get-ChildItem -Path $dirRaiz -Force > teste2.txt


#Lendo um arquivo txt
$Text = Get-Content -Path "$dirRaiz\teste2.txt"
#Transformando as linhas do arquivo em um array 
$Text.GetType() | Format-Table -AutoSize

#Listando as linhas do arquivo
foreach ($element in $Text) 
{ 
    $element = $element.Trim()
    
    try {
        if ($element.Substring(0,2) -eq "d-" -or $element.Substring(0,2) -eq "-a") {
            $element >> teste3.txt
            $nomeItem = $element.Substring(50, ($element.Length -50))
            $dataString = $element.Substring(14,10)
            $dataDoArquivo = [Datetime]::ParseExact($dataString, 'dd/MM/yyyy', $null)

            if ($dataBase -ge $dataDoArquivo) {
                Write-Host "Excluir o item $nomeItem" $dataDoArquivo 
            } else {
                Write-Host "Não excluir o item $nomeItem" $dataDoArquivo
            }
        }
     
    } catch {

    }
}


