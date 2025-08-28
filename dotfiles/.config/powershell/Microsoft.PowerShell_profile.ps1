[System.Environment]::SetEnvironmentVariable('PATH', $('{0}/.nix-profile/bin:/etc/profiles/per-user/{1}/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:' -f $HOME, $env:USER + $env:PATH), [System.EnvironmentVariableTarget]::Process)
$(/opt/homebrew/bin/brew shellenv) | Invoke-Expression
[System.Environment]::SetEnvironmentVariable('PATH', $('{0}/.cargo/bin:' -f $HOME + $env:PATH), [System.EnvironmentVariableTarget]::Process)
