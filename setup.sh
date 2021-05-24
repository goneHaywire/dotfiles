#!/usr/bin/env bash

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

# what directories should be installable by all users including the root user
base=(
	bash
	vim
	tmux
	zsh
	git
	nvim
	functions
)

# folders that should, or only need to be installed for a local user
useronly=(
	vim
	tmux
	zsh
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
	usr=$1
	app=$2
	# -v verbose
	# -R recursive
	# -t target
	stow -v -R -t ~ ${app}
}

echo ""
echo "Stowing apps for user: ${whoami}"

# install apps available to local users and root
for app in ${base[@]}; do
	stowit "${HOME}" $app
done

    echo ""
    echo "##### ALL DONE"

