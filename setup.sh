#!/bin/sh
#
# Setup development environment in WSL

sudo apt install -y \
	git \
	fzf \
	zsh \
	lf \
	zathura-pdf-poppler \
	stow \
	docker \
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

# Setup the wiki template
mkdir -p ~/proj
git clone http://alp.fritz.box:8080/cmk/wiki.git ~/proj/wiki

# Install Neovim using bob
curl -L -O 'https://github.com/MordechaiHadad/bob/releases/download/v4.1.6/bob-linux-x86_64.zip'
unzip bob-linux-x86_64.zip
test ! -d ~/.local/bin && mkdir -p ~/.local/bin
mv bob-linux-x86_64/bob ~/.local/bin/bob
rm -r ./*.zip
sudo chmod +x ~/.local/bin/bob
bob install nightly
bob use nightly

# Add the regular user to the docker group
useradd -aG docker $USER

# Generate a GPG key
printf "Generating a GPG key\n"
gpg --full-gen-key

# Init password safe
read -p "Enter the same email used for generating the GPG key: " email
pass init $email

# Change the login shell to Z-Shell
sudo chsh -s $(which zsh)
