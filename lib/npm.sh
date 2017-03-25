#!/bin/bash

# Gratefully lifted from https://github.com/necolas/dotfiles/blob/master/lib/npm

run_npm() {

    # Check for npm
    if type_exists 'npm'; then
        e_header "Installing Node.js packages..."

        # List of npm packages
        local packages="\
                yarn \
                eslint \
                jsdoc \
                grunt \
                gulp \
                claudia \
                lambda-local"

        # Install packages globally and quietly
        npm install $packages --global --quiet

        [[ $? ]] && e_success "Done"
    else
        printf "\n"
        e_error "Error: npm not found."
        printf "Aborting...\n"
        exit
    fi

}
