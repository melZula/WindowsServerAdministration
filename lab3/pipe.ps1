Get-Disk | ForEach-Object {
  if (!$_.BootFromDisk) {
    echo $_
  }
}
pause