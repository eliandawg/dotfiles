# Detect if kitty is running, if so use SSH kitten
if test (printenv KITTY_WINDOW_ID)
    abbr -a ssh "kitten ssh"
end
