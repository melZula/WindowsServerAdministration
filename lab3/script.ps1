Get-Disk
echo "Enter disk number:"
$n = Read-Host
echo "All data on disk will be erased. Continue [Y/n]?"
$c = Read-Host
if ($c -eq "n"){
    exit
}
set-disk 1 -isOffline $true
Initialize-Disk -Number $n -PartitionStyle GPT
New-Partition -DiskNumber $n -Size 1GB -DriveLetter T
Format-Volume -DriveLetter T -FileSystem NTFS
Repair-Volume -DriveLetter T
Get-Volume -DriveLetter T