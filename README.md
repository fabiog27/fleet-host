# fleet-host

This repo contains shell scripts and a Dockerfile to build a docker image ready to
[run the Jetrbrains Fleet on a remote server in a docker container](https://www.jetbrains.com/help/fleet/install-on-a-remote-machine.html).
Fleet is an IDE that supports remote collaboration - but it also provides the access
to the host's filesystem. Thus, it's ideal to run it remotely in a docker container with
limited permissions.

## Preinstalled dependencies

The docker image is based on alpine linux and has a few typical dependencies installed.
Additionally, the shell is setup with [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) for
a more comfortable shell experience and [asdf](https://github.com/asdf-vm/asdf) to install
development dependencies.

There's currently a bug (probably with Fleet) that results in the default shell being ignored,
so whenever you open a terminal with fleet, you first have to run `/bin/zsh` to get oh-my-oh
and asdf support.

For asdf, the plugins for nodejs, yarn, ruby and java are preinstalled, but there are no
specific preinstalled versions. The user this with has permissions to install more plugins
and whatever versions you want.

## Building

To build the docker image, simply clone this repo and run

`docker build -t fleet .`

Replace "fleet" with whatever image name you want.

## Running

To run the Fleet container, there are two options:

### Running with an empty workspace:

`docker run -t fleet`

Adapt "fleet" to the image name you chose while building

### Running with an existing git repo:

`docker run -t fleet --git-repo link-to-your-repo`

If your repo is not public, you can specify an ssh key to use by mounting it into the
container as volumes:

`docker run -t -v path-to-ssh-key-directory-on-your-machine:/home/fleet/.ssh fleet --git-repo link-to-your-repo`

The directory on your machine that you're mounting must contain a private key named 'id_git'
and a public key named 'id_git.pub'.

> IMPORTANT!
> Remember that anyone who joins your Fleet remote session will have access to the entire
> filesystem of the container, including those keys, so ensure that only the keys you
> need are in there and that you trust anyone who joins with those keys. Therefore, avoid
> mounting your entire ~/.ssh directory and instead copy just the key you need to a fresh
> directory.
