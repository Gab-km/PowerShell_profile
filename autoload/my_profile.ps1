# $HOME の値を環境変数の HOME に変更する
Remove-Variable -Force HOME
Set-Variable HOME $env:HOME

# Git 管理ディレクトリ
function git_branch {
    git branch 2>$null | % { $bn = $_.Split()[1]
                             Write-Output "(git:$bn)" }
}

# Mercurial 管理ディレクトリ
function hg_branch {
    hg branch 2>$null | % { Write-Output "(hg:$_)" }
}

# プロンプト表示を変更する
# Thanks to http://qiita.com/kmr_hryk/items/424bb80e14f04e762578
function prompt {
   # カレントディレクトリをウィンドウタイトルにする
   (Get-Host).UI.RawUI.WindowTitle = "Windows PowerShell " + $pwd

   # GitBashっぽく表示
   # カレントディレクトリを取得
   $idx = $pwd.ProviderPath.LastIndexof("\") + 1
   $cdn = $pwd.ProviderPath.Remove(0, $idx)
 
   # 現在時刻を取得
   $t = (Get-Date).ToLongTimeString()

   # ブランチ名を取得
   $gitBranch = git_branch
   $hgBranch = hg_branch

   # プロンプトをセット
   Write-Host "[" -NoNewline -ForegroundColor White
   Write-Host "$t " -NoNewline -ForegroundColor Green
   Write-Host $env:USERNAME -NoNewline -ForegroundColor Cyan
   Write-Host "@$env:USERDOMAIN $gitBranch$hgBranch" -NoNewline -ForegroundColor White
   Write-Host $pwd -NoNewline -ForegroundColor Green
   Write-Host "]
$" -NoNewline -ForegroundColor White
   return " "
}

# 認証プロキシ用に適切なプロキシを取得する
function Get-RequiredProxy {
param(
    [Parameter(Mandatory=$true)]
    [System.Uri]$proxyUri
)
    $proxy = New-Object System.Net.WebProxy($proxyUri) -ErrorAction Stop
    $cred = Get-Credential
    $proxy.credentials = $cred.GetNetworkCredential()
    $proxy
}