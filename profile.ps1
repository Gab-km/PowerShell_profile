# $HOME �̒l�����ϐ��� HOME �ɕύX����
Remove-Variable -Force HOME
Set-Variable HOME $env:HOME

# �v�����v�g�\����ύX����
# Thanks to http://qiita.com/kmr_hryk/items/424bb80e14f04e762578
function prompt {
   # �J�����g�f�B���N�g�����E�B���h�E�^�C�g���ɂ���
   (Get-Host).UI.RawUI.WindowTitle = "Windows PowerShell " + $pwd

   # GitBash���ۂ��\��
   # �J�����g�f�B���N�g�����擾
   $idx = $pwd.ProviderPath.LastIndexof("\") + 1
   $cdn = $pwd.ProviderPath.Remove(0, $idx)
   # �v�����v�g���Z�b�g
   $env:USERNAME + "@" + $env:USERDOMAIN + " " + $pwd + "
$ "
}

# �F�؃v���L�V�p�ɓK�؂ȃv���L�V���擾����
function Get-RequiredProxy {
param(
    [System.Uri]$proxyUri
)
    $cred = Get-Credential
    $proxy = New-Object System.Net.WebProxy($proxyUri)
    $proxy.credentials = $cred.GetNetworkCredential()
    $proxy
}