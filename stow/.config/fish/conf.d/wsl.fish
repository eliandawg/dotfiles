if test -f /proc/sys/fs/binfmt_misc/WSLInterop
    set -x DISPLAY (route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
    abbr ssh ssh.exe -F ~/.ssh/config
    abbr ssh-add 'ssh-add.exe -L'
    abbr scp 'scp.exe'
end
