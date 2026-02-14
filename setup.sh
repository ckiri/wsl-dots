#!/bin/sh
#
# Setup a WSL development environment

sep="================================================================================"

sudo apt update

sudo apt upgrade

sudo apt install \
	git \
	zsh \
	lf \
    curl \
	zathura-pdf-poppler \
	stow \
	podman \
	unzip \
	tmux \
    firefox \
    pass

# Link config files
stow \
	zsh \
	nvim \
	tmux

# Create a history file
test ! -d ~/.cache/zsh && mkdir -p ~/.cache/zsh
test ! -f ~/.cache/zsh/history && touch ~/.cache/zsh/history
printf "\n\n"

# Install Neovim using bob
printf "${sep}\nInstalling Neovim\n${sep}\n\n"
curl -L -O 'https://github.com/MordechaiHadad/bob/releases/download/v4.1.6/bob-linux-x86_64.zip'
test -f ./bob-linux-x86_64.zip && unzip ./bob-linux-x86_64.zip
test ! -d ~/.local/bin && mkdir -p ~/.local/bin
mv bob-linux-x86_64/bob ~/.local/bin/bob
rm -r ./*.zip
sudo chmod +x ~/.local/bin/bob
~/.local/bin/bob install nightly
~/.local/bin/bob use nightly
printf "\n\n"

# Generate a GPG key
printf "${sep}\nGenerating a GPG key\n${sep}\n\n"
gpg --full-gen-key
printf "\n\n"

# Init password safe
printf "${sep}\nInitialize Pass\n${sep}\n\n"
printf "Enter the same email used for generating the GPG key: "; read email
printf "\n"
pass init $email
printf "\n\n"

# Setup Git
printf "${sep}\nSetting up Git\n${sep}\n\n"
printf "Enter your email address: "; read email
git config --global user.email "${email}"
printf "\n"
printf "Enter your full name: "; read name
git config --global user.name "${name}"
printf "\n\n"

# Change the login shell to Z-Shell
printf "${sep}\nChanging the login shell\n${sep}\n\n"
sudo chsh -s $(which zsh)
