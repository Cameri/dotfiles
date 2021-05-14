export ZSH="$HOME/.oh-my-zsh"
export ANTIGEN="$HOME/.antigen"

source $ZSH/oh-my-zsh.sh
source $ANTIGEN/antigen.zsh

antigen bundle git
antigen bundle nvm
antigen bundle nvm-auto-use
antigen bundle pip
antigen bundle 256color
antigen bundle colors
antigen bundle docker-compose
antigen bundle fzf
antigen bundle command-not-found
antigen bundle wd
antigen bundle safe-paste
antigen bundle npm

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

antigen apply
