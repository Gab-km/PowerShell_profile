# $HOME の値を環境変数の HOME に変更する
Remove-Variable -Force HOME
Set-Variable HOME $env:HOME

# プロンプト表示を変更する
# Thanks to http://qiita.com/kmr_hryk/items/424bb80e14f04e762578
function prompt {
   # カレントディレクトリをウィンドウタイトルにする
   (Get-Host).UI.RawUI.WindowTitle = "Windows PowerShell " + $pwd

   # GitBashっぽく表示
   # カレントディレクトリを取得
   $idx = $pwd.ProviderPath.LastIndexof("\") + 1
   $cdn = $pwd.ProviderPath.Remove(0, $idx)
   # プロンプトをセット
   $env:USERNAME + "@" + $env:USERDOMAIN + " " + $pwd + "
$ "
}

# 認証プロキシ用に適切なプロキシを取得する
function Get-RequiredProxy {
param(
    [System.Uri]$proxyUri
)
    $cred = Get-Credential
    $proxy = New-Object System.Net.WebProxy($proxyUri)
    $proxy.credentials = $cred.GetNetworkCredential()
    $proxy
}