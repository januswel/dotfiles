# definitions
$targets = @(
    ".bash_aliases",
    ".bash_profile",
    ".bashrc",
    ".dir_colors",
    ".gitconfig",
    ".gitignore",
    ".gvimrc",
    ".tidyrc",
    ".tmux.conf",
    ".vim:vimfiles",
    ".vimperator:vimperator",
    ".vimperatorrc",
    ".vimrc",
    ".zprofile",
    ".zshrc"
)

# functions
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

# main
$src_dir = '..'
$dst_dir = [Environment]::GetEnvironmentVariable('HOME')
if ($dst_dir -eq '') {
    echo 'Set the environment variable "HOME"'
    exit
}

foreach ($target in $targets) {
    $args = $target.Split(":")
    switch ($args.Length) {
        1 {
            $src = Join-Path $src_dir $target
            $dst = Join-Path $dst_dir $target
            CreateSymLink $src $dst
        }
        2 {
            $src = Join-Path $src_dir $args[0]
            $dst = Join-Path $dst_dir $args[1]
            CreateSymLink $src $dst
        }
        default {
            throw 'too many colons'
        }
    }
}
