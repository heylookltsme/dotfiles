# Parse options
force=false       # -f or --force
files_only=false  # --files-only

while (( $# )); do
  case "$1" in
    -f|--force)
      force=true
      shift
      ;;
    --files-only)
      files_only=true
      shift
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {

    # load libs
    source ./lib/utils.sh
    source ./lib/npm.sh

    # make sure we fetch all submodules
    git submodule init
    git submodule update --recursive

    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude ".osx" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" ./ \
        --exclude "LICENSE-MIT.txt" \
        -avh --no-perms . ~;

    if [ "$files_only" != true ]; then
        # Install zplugin
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

        # Install base16 shell
        git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell

        # Install vim plugins
        vim +PlugInstall +qall!

        # Install global node modules
        run_npm

        # Fix italics
        tic -o ~/.terminfo ./lib/xterm-256color.terminfo.txt

        # Change default shell to zsh
        chsh -s /bin/zsh
        exec zsh

        # Set base16 theme to bright
        base16_bright
    fi
}

if [ "$force" == true ]; then
    doIt;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;
unset doIt;
