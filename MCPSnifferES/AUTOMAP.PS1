# $TheUser = [Console]::ReadLine()
# $pw = [Console]::ReadLine() | ConvertTo-SecureString -AsPlainText -Force
# $cred=new-object System.Management.Automation.PsCredential($TheUser,$pw)
# $DriveOrMnt = [Console]::ReadLine()
# $FQShareName = [Console]::ReadLine()

$TheUser = 'MLUSER'
$pw = 'MLUSER' | ConvertTo-SecureString -AsPlainText -Force
$cred = new-object System.Management.Automation.PsCredential($TheUser, $pw)
$DriveOrMnt = 'M:'
$FQShareName = '\\192.168.16.5\_HOMEXL_'

$ec = 0

[Console]::WriteLine( "$TheUser $DriveOrMnt $FQShareName")

$null = net use * /delete /yes

# build an expression to do the mapping
$ex = '$null = new-smbmapping'
if ([string]::Empty -ne $DriveOrMnt) {
    # Have a local drive letter
    $ex += ' -LocalPath ' + $DriveOrMnt
}
$ex += ' -RemotePath ' + $FQShareName
$ex += ' -UserName ' + $TheUser
$ex += ' -Password ' + $cred.GetNetworkCredential().Password

Invoke-Expression $ex

if (!(Test-Path $FQShareName)) {
    [Console]::WriteLine("Automap failed")
    $ec = 1
}
else {
    [Console]::WriteLine("Automap worked")
}
[Console]::Out.Flush()
Exit $ec
