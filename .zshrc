autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

###############################################################################
# Load dotfiles                                                               #
###############################################################################
dotfiles=(
    "path"        # $PATH configuration
    "exports"     # Export environment variables
    "aliases"     # So many aliases
    "functions"   # Custom functions I never use but should
    "local_rc"    # Machine-specific config
)

for file in ${dotfiles[@]}; do
    file="$HOME/.$file"
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


###############################################################################
#  zsh options                                                                #
###############################################################################

# Many sensible defaults
source $ZSH/oh-my-zsh.sh

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="random"

# Automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# I like my LS aliases better
DISABLE_LS_COLORS="true"

# Command auto-correction.
ENABLE_CORRECTION="true"

# Don't use fancy mode if the enivronment doesn't support it
[[ $TERM == xterm* ]] || : ${PURE_POWER_MODE:=portable}

# Approximate autocompletion. Typo forgiveness. 🙏
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2

setopt inc_append_history
autoload -Uz history-search-end

# Fix up arrow completion with vi-mode enabled
# https://superuser.com/a/1371822
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M vicmd '^[[A' history-beginning-search-backward-end \
                 '^[OA' history-beginning-search-backward-end \
                 '^[[B' history-beginning-search-forward-end \
                 '^[OB' history-beginning-search-forward-end
bindkey -M viins '^[[A' history-beginning-search-backward-end \
                 '^[OA' history-beginning-search-backward-end \
                 '^[[B' history-beginning-search-forward-end \
                 '^[OB' history-beginning-search-forward-end

# Allow Ctrl-z to toggle between suspend and resume
function Resume {
    fg
    zle push-input
    BUFFER=""
    zle accept-line
}
zle -N Resume
bindkey "^Z" Resume

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish


###############################################################################
# Plugins                                                                     #
###############################################################################

source ~/.zinit/bin/zinit.zsh

autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice wait lucid
zplugin snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/git.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/osx/osx.plugin.zsh
zplugin ice wait lucid
zplugin snippet OMZ::plugins/osx/spotify

zplugin ice wait lucid svn
zplugin snippet OMZ::plugins/z

zplugin ice wait lucid svn
zplugin snippet OMZ::plugins/gitfast

zplugin ice wait lucid
zplugin light MichaelAquilina/zsh-emojis             # $em_shrug

zplugin ice wait lucid
zplugin light igoradamenko/jira.plugin.zsh           # JIRA commands

zplugin ice wait lucid
zplugin light MichaelAquilina/zsh-you-should-use     # Force alias usage

zplugin ice wait lucid
zplugin light lukechilds/zsh-nvm                     # Zsh manages nvm

zplugin ice wait lucid
zplugin light zsh-users/zsh-syntax-highlighting      # CLI syntax highlighting

zplugin ice wait lucid atload'zpcompinit'
zplugin light zsh-users/zsh-autosuggestions          # command autosuggestions


###############################################################################
# Theme Settings                                                              #
###############################################################################

zplugin light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"

###############################################################################
# Plugin Settings                                                             #
###############################################################################

# JIRA
JIRA_URL="https://vimean.atlassian.net"
JIRA_NAME="corinne"
JIRA_RAPID_BOARD=true
JIRA_DEFAULT_ACTION="git"
JIRA_BRANCH_REGEX="s/(.+\-|^)([A-Z0-9]+-[0-9]+)(\-.+|$)/\2/p"

# you-should-use
export YSU_HARDCORE=0
export YSU_MODE=ALL

# zsh autosuggest
ZSH_AUTOSUGGEST_USE_ASYNC="true"


# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc

###############################################################################
# Stuff to do last                                                            #
###############################################################################

unalias _ # remove dumb sudo alias

### End of Zinit's installer chunk
