FROM alpine:3

# globally required packages
RUN apk update && apk add git curl zsh bash coreutils
COPY install-asdf-deps.sh install-asdf-deps.sh
RUN ["/bin/sh", "install-asdf-deps.sh"]

# setup user
RUN adduser --disabled-password --shell /bin/zsh fleet
USER fleet
WORKDIR /home/fleet

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# asdf
COPY setup-asdf.sh setup-asdf.sh
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN echo "# asdf setup" >> ~/.zshrc && \
    echo ". $HOME/.asdf/asdf.sh" >> ~/.zshrc && \
    echo "fpath=(\${ASDF_DIR}/completions \$fpath)" >> ~/.zshrc && \
    echo "autoload -Uz compinit && compinit" >> ~/.zshrc

RUN ["/bin/zsh", "setup-asdf.sh"] 
# fleet
RUN curl -LSs "https://download.jetbrains.com/product?code=FLL&release.type=preview&release.type=eap&platform=linux_x64" --output fleet && chmod +x fleet
RUN mkdir workspace

USER root
COPY entrypoint.sh entrypoint.sh
RUN chmod a+x entrypoint.sh
USER fleet

ENTRYPOINT ["/bin/zsh", "entrypoint.sh"] 
