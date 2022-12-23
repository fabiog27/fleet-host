### Clone from GitHub ###
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

### Setup .zshrc ###
echo "# asdf setup" >> ~/.zshrc
echo ". $HOME/.asdf/asdf.sh" >> ~/.zshrc
echo "fpath=(\${ASDF_DIR}/completions \$fpath)" >> ~/.zshrc
echo "autoload -Uz compinit && compinit" >> ~/.zshrc

### Install plugin dependencies ###

# Yarn #
apk add tar gpg gpg-agent

# Python #
apk add build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev \
    libxmlsec1-dev libffi-dev liblzma-dev libsasl2-dev \
    python3-dev libldap2-dev

# Ruby #
apk add bash curl git musl-locales \
    automake libffi yaml openssl-dev \
    zlib-dev gcc g++ make

# Java #
apk add bash curl unzip jq

### Install plugins ###
. $HOME/.asdf/asdf.sh
asdf plugin add nodejs
asdf plugin add yarn
asdf plugin add python
asdf plugin add ruby
asdf plugin add java
