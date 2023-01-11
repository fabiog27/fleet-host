### Clone from GitHub ###
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

### Setup .zshrc ###
echo "# asdf setup" >> ~/.zshrc
echo ". $HOME/.asdf/asdf.sh" >> ~/.zshrc
echo "fpath=(\${ASDF_DIR}/completions \$fpath)" >> ~/.zshrc
echo "autoload -Uz compinit && compinit" >> ~/.zshrc

### Install plugins ###
. $HOME/.asdf/asdf.sh
asdf plugin add nodejs
asdf plugin add yarn
asdf plugin add python
asdf plugin add ruby
asdf plugin add java
asdf plugin add rust
