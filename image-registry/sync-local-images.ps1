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

$publishedTargets = [System.Collections.Generic.HashSet[string]]::new()

foreach ($image in $images) {
    $parts = $image.Split("|", 2)
    $repository = $parts[0]
    $tag = $parts[1]
    $source = "${repository}:${tag}"
    $targetRepository = $repository

    if ($targetRepository.StartsWith("${RegistryHost}:${RegistryPort}/")) {
        continue
    }

    if (-not ($targetRepository -match '^localhost/(local/)?[^/]+$')) {
        continue
    }

    if ($targetRepository.StartsWith("localhost/")) {
        $targetRepository = $targetRepository.Substring("localhost/".Length)
    }

    if ($targetRepository.StartsWith("${Namespace}/")) {
        $targetRepository = $targetRepository.Substring($Namespace.Length + 1)
    }

    $target = "${RegistryHost}:${RegistryPort}/${Namespace}/${targetRepository}:${tag}"

    if (-not $publishedTargets.Add($target)) {
        continue
    }

    Write-Host "Syncing $source -> $target"
    & $podmanExe tag $source $target
    & $podmanExe push --tls-verify=false $target
}
