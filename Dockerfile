FROM alpine:3

# install globally required packages
RUN apk update && apk add git curl zsh bash coreutils openssh

# setup user
RUN adduser -D -s /bin/zsh fleet
WORKDIR /home/fleet

# copy setup scripts
COPY setup/oh-my-zsh.sh setup/oh-my-zsh.sh
COPY setup/asdf.sh setup/asdf.sh
RUN chmod u+x -R setup

# oh-my-zsh
RUN ["/bin/zsh", "/setup/oh-my-zsh.sh"]

# asdf
RUN ["/bin/zsh", "setup/asdf.sh"]

# remove setup scripts
RUN rm -r setup

# install fleet
RUN curl -LSs "https://download.jetbrains.com/product?code=FLL&release.type=preview&release.type=eap&platform=linux_x64" --output fleet && chmod +x fleet
RUN mkdir workspace

# configure entrypoint
COPY entrypoint.sh entrypoint.sh
RUN chmod a+x entrypoint.sh
USER fleet

ENTRYPOINT ["/bin/zsh", "entrypoint.sh"] 
