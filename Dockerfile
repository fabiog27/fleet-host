FROM alpine:3

# install globally required packages
RUN apk update && apk add git curl zsh bash coreutils openssh vim

# setup user
RUN adduser -D -s /bin/zsh fleet
WORKDIR /home/fleet

# copy setup scripts
COPY setup/oh-my-zsh.sh setup/oh-my-zsh.sh
COPY setup/asdf-plugin-deps.sh setup/asdf-plugin-deps.sh
COPY setup/asdf.sh setup/asdf.sh
RUN chmod 777 -R setup

# install asdf global dependencies
RUN ["/bin/zsh", "setup/asdf-plugin-deps.sh"]

USER fleet

# oh-my-zsh
RUN ["/bin/zsh", "setup/oh-my-zsh.sh"]

# asdf
RUN ["/bin/zsh", "setup/asdf.sh"]

USER root

# remove setup scripts
RUN rm -r setup

# copy entrypoint script
COPY entrypoint.sh entrypoint.sh
RUN chmod a+x entrypoint.sh

USER fleet

# install fleet
RUN curl -LSs "https://download.jetbrains.com/product?code=FLL&release.type=preview&release.type=eap&platform=linux_x64" --output fleet && chmod +x fleet
RUN mkdir workspace

ENTRYPOINT ["/bin/zsh", "entrypoint.sh"] 
