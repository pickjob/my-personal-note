$Source = "G:\backup-2022-08-01"
$Destion = "C:\repository"

foreach ($File in @(Get-ChildItem -Attributes Archive -Recurse $Source)) {
    $FileName = $File.BaseName
    if ($File.Directory.FullName -eq $Source) {
        $DestionFileName = "$Destion\$FileName"
    } else {
        $DestionFileName = "$Destion\$($File.Directory.Name)\$FileName"
    }
    $Compress = @{
        TargetPath = $DestionFileName
        ArchiveFileName  = $File.FullName
    }
    Expand-7Zip @Compress
}