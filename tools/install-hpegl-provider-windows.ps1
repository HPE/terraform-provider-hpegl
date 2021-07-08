param ($VERSION)

$os="windows"
$arch="amd64"
$repo="HewlettPackard/terraform-provider-hpegl"
$windows_hpegl_dir="$env:appdata\terraform.d\plugins\registry.terraform.io\hewlettpackard\hpegl"

function get_latest_release {
    Write-Host Getting latest release
    $release_url="https://api.github.com/repos/${repo}/releases/latest"
    $tag = (Invoke-WebRequest $release_url | ConvertFrom-Json)[0].tag_name
    $VERSION=${tag}
    
    $VERSION
}

if (!$VERSION) {
    $VERSION=get_latest_release
}

$version_number=$VERSION -replace 'v'  

$dest_dir="${windows_hpegl_dir}\${version_number}\${os}_${arch}\"
$hpegl_zip="terraform-provider-hpegl_${version_number}_${os}_${arch}.zip"
$hpegl=$hpegl_zip -replace '.zip'
$hpegl_dl_url="https://github.com/${repo}/releases/download/${VERSION}/${hpegl_zip}"

Write-Host Downloading latest release
mkdir "$dest_dir" 
Set-Location "$dest_dir"
Invoke-WebRequest $hpegl_dl_url -Out $hpegl_zip

Write-Host Extracting release files
Expand-Archive $hpegl_zip -Force

Get-ChildItem -Path $hpegl -Recurse -File | Move-Item -Destination $dest_dir

Remove-Item $hpegl_zip -Recurse -Force -ErrorAction SilentlyContinue 
Remove-Item $hpegl -Recurse -Force -ErrorAction SilentlyContinue 
Write-Host Complete
