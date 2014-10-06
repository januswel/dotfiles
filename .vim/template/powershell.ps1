$array = @(
    1,
    2,
    3
)

$hash = @{
    key = "val";
}

# function
function GetScriptDir() {
    return Split-Path (& {$MyInvocation.ScriptName}) -Parent
}

function IsDir($path) {
    return Test-Path $path -PathType Container
}

function CreateSymLink($src, $dst) {
    if ((Test-Path $src) -ne $true) {
        $msg = 'The source is not found: ' + $src
        echo $msg
        return
    }
    if ((Test-Path $dst) -eq $true) {
        $msg = 'The destination already exists: ' + $dst
        echo $msg
        return
    }

    $isDir = IsDir($src)
    $command = 'mklink ' + $dst + ' ' + $src
    if ($isDir -eq $true) {
        $command = 'mklink /D ' + $dst + ' ' + $src
    }
    echo $command
    cmd /c $command
}
