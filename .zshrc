# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# additional config
[[ ! -f ~/.p10k.zsh ]]      || source ~/.p10k.zsh      # theme
[[ ! -f ~/.zshrc.local ]]   || source ~/.zshrc.local   # config just for this environment
[[ ! -f ~/.zshrc.aliases ]] || source ~/.zshrc.aliases # aliases and functions

# different editor for remote sessions
[[ -n $SSH_CONNECTION ]] && export EDITOR='vim'

export GPG_TTY=$TTY

# additional installations

export PATH="$HOME/nvim-osx64/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_COMPLETION_TRIGGER='§'
export FZF_DEFAULT_COMMAND='fd --type file --follow'
export FZF_CTRL_T_COMMAND='fd --type file --follow'
_fzf_compgen_path() {
	fd --hidden --follow --exclude '.git' . "$1"
}
_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude '.git' . "$1"
}

export _ZO_ECHO=1
eval "$(zoxide init zsh)"
