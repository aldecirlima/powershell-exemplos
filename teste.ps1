# Remover pasta 
Clear-Host
$dirRaiz = 'D:\Powershell\Testes'
cd $dirRaiz
$dataBase = Get-Date
$dataBase = $dataBase.AddDays(-31)
$dataDoArquivo = [Datetime]::ParseExact('01/09/2023', 'dd/MM/yyyy', $null)

if ($dataBase -ge $dataDoArquivo) {
    Write-Host "data base maior igual arquivo"
} else {
    Write-Host "data base menor"
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
            Write-Host $element.Substring(50, ($element.Length -50))
            $dataArquivo = $element.Substring(14,10)
            $data = [Datetime]::ParseExact($dataArquivo, 'dd/MM/yyyy', $null)
            Write-Host $data
        }
     
    } catch {

    }
}


