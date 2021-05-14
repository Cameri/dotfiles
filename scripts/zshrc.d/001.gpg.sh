# Use homebrew gnupg@2.2 version, gpnupg@2.3 has issues
export PATH="/usr/local/opt/gnupg@2.2/bin:$PATH"
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null
unset SSH_AGENT_PID
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
