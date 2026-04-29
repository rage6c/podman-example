param(
    [string]$RegistryHost = "localhost",
    [int]$RegistryPort = 5000,
    [string]$Namespace = "local"
)

$podman = Get-Command podman -ErrorAction SilentlyContinue
if (-not $podman -and (Test-Path 'C:\Program Files\RedHat\Podman\podman.exe')) {
    $podman = Get-Item 'C:\Program Files\RedHat\Podman\podman.exe'
}

if (-not $podman) {
    throw "podman is required to sync local images."
}

$podmanExe = $podman.Source

$images = & $podmanExe images --format "{{.Repository}}|{{.Tag}}" |
    Where-Object { $_ -and ($_ -notmatch "^<none>\|") -and ($_ -notmatch "\|<none>$") }

if (-not $images) {
    Write-Host "No tagged local images found."
    exit 0
}

foreach ($image in $images) {
    $parts = $image.Split("|", 2)
    $repository = $parts[0]
    $tag = $parts[1]
    $source = "${repository}:${tag}"
    $target = "${RegistryHost}:${RegistryPort}/${Namespace}/${repository}:${tag}"

    Write-Host "Syncing $source -> $target"
    & $podmanExe tag $source $target
    & $podmanExe push $target
}
