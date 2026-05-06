if test -f /proc/sys/fs/binfmt_misc/WSLInterop
    set -x DISPLAY (route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
    abbr winssh ssh.exe -F ~/.ssh/config
    abbr winssh-add 'ssh-add.exe -L'
    abbr winscp 'scp.exe'
end
