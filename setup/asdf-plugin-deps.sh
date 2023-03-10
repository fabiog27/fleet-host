### Install plugin dependencies ###

# Python #

apt install -y dpkg-dev build-essential python-dev python3-dev libncursesw5-dev libsqlite3-dev \
               libreadline-dev libbz2-dev libffi-dev libssl-dev libgdbm-dev zlib1g-dev libjpeg-dev \
               libtiff-dev libpq-dev libxml2-dev libxslt1-dev libsdl2-dev libgstreamer-plugins-base1.0-dev \
               libnotify-dev freeglut3-dev libsm-dev libgtk-3-dev libwebkitgtk-3.0-dev libxtst-dev

# Ruby #
apt install -y autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev \
               zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev

# Java #
apt install -y bash curl unzip jq

# Rust #
apt install -y gcc
