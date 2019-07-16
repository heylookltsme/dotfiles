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

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=powerlevel10k/powerlevel10k
# ZSH_THEME=dracula/dracula

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


###############################################################################
# Plugins                                                                     #
###############################################################################

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh-custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    colored-man-pages     # Colors in man pages
    composer              # Composer completion
    fancy-ctrl-z          # Use ctrl-z to go _back_ to a suspended vim
    git                   # Git aliases
    gitfast               # Git completion
    jira                  # Commands to open jira links
    osx                   # Some mac utils.
    yarn                  # Yarn completion
    vi-mode               # vim in the command line
    zsh-nvm               # Have zsh manage nvm for you
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh


###############################################################################
# Theme Settings                                                              #
###############################################################################
source $ZSH_CUSTOM/config/lean.zsh
local_settings="$HOME/.zsh-theme-local.zsh"
[ -r "$local_settings" ] && [ -f "$local_settings" ] && source "$local_settings"


###############################################################################
# Plugin Settings                                                             #
###############################################################################

# JIRA
JIRA_URL="https://vimean.atlassian.net"
JIRA_NAME="corinne"
JIRA_RAPID_BOARD=true
JIRA_DEFAULT_ACTION="git"
JIRA_BRANCH_REGEX="s/(.+\-|^)([A-Z0-9]+-[0-9]+)(\-.+|$)/\2/p"
