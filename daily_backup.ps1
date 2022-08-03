$Source = "C:\repository"
$Destion = "D:\repository_all\backup"

$NoSubDiectory = "bin", "cargo-win", "maven", "msys64", "gradle", "npm-win", "pip-win", "vimfiles"
$SkipDiectory = , ""

$Date = Get-Date -Format "yyyy-MM-dd"
$Destion = "$Destion-$Date"
New-Item "$Destion" -ItemType Directory -Force
foreach ($Directory in @(Get-ChildItem -Attributes Directory $Source)) {
    if ($SkipDiectory.Contains($Directory.Name)) {
        continue
    }
    if ($NoSubDiectory.Contains($Directory.Name)) {
        $DirectoryInfo = Get-ChildItem $Directory.FullName | Measure-Object
        if ($DirectoryInfo.count -eq 0){
            continue
        }
        $DestionZipName = "$Destion\$($Directory.Name).7z"
        if (Test-Path $DestionZipName) {
            "$($DestionZipName) already exits."
            continue
        }
        $Compress = @{
            Path             = $Directory.FullName
            Format           = "SevenZip"
            CompressionLevel = "Normal"
            ArchiveFileName  = $DestionZipName
        }
        Compress-7Zip @Compress
    } else {
        foreach ($SubDirectory in @(Get-ChildItem -Attributes Directory $Directory.FullName)) {
            $DirectoryInfo = Get-ChildItem $SubDirectory.FullName | Measure-Object
            if ($DirectoryInfo.count -eq 0){
                continue
            }
            if (-Not (Test-Path "$Destion\$($Directory.Name)")) {
                "$Destion\$($Directory.Name) not exits."
                New-Item -ItemType Directory "$Destion\$($Directory.Name)"
            }
            $DestionZipName = "$Destion\$($Directory.Name)\$($SubDirectory.Name).7z"
            if (Test-Path $DestionZipName) {
                "$($DestionZipName) already exits."
                continue
            }
            $Compress = @{
                Path             = $SubDirectory.FullName
                Format           = "SevenZip"
                CompressionLevel = "Normal"
                ArchiveFileName  = $DestionZipName
            }
            Compress-7Zip @Compress
        }
    }
}