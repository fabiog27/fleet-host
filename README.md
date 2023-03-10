# fleet-host

This repo contains shell scripts and a Dockerfile to build a docker image ready to
[run Jetbrains Fleet on a remote server in a docker container](https://www.jetbrains.com/help/fleet/install-on-a-remote-machine.html).
Fleet is an IDE that supports remote collaboration - but it also provides access
to the host's filesystem. Thus, it's ideal to run it remotely in a docker container with
limited permissions.

## Preinstalled dependencies

The docker image is based on Ubuntu and has a few typical dependencies installed.
Additionally, the shell is setup with [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) for
a more comfortable experience and [asdf](https://github.com/asdf-vm/asdf) to install
development dependencies.

There's currently a bug (probably in Fleet) that results in the default shell being ignored,
so whenever you open a terminal with Fleet, you first have to run `/bin/zsh` to get oh-my-zsh
and asdf support.

For asdf, the plugins for nodejs, yarn, ruby, rust and java are preinstalled. There aren't any
preinstalled versions. The user has permissions to install more plugins and any versions
you need.

## Building

To build the docker image, simply clone this repo and run

    docker build -t fleet .

You can replace "fleet" with another image name if you want.

## Running

To run the Fleet container, there are two options:

### Running with an empty workspace:

    docker run -t fleet

Adapt "fleet" to the image name you chose while building

### Running with an existing git repo:

    docker run -t fleet --git-repo link-to-your-repo

If your repo is not public, you can specify an ssh key to use by mounting it into the
container as volumes:

    docker run -it -v path-to-ssh-key-directory-on-your-machine:/home/fleet/.ssh fleet --git-repo link-to-your-repo

The directory on your machine that you're mounting must contain a private key named 'id_git'
and a public key named 'id_git.pub'. Notice the added -i option for the docker run command:
This is necessary if your SSH key is password secured to allow you to enter it.

> IMPORTANT!
> Remember that anyone who joins your Fleet remote session will have access to the entire
> filesystem of the container, including those keys, so ensure that only the keys you
> need are in there and that you trust anyone who joins with those keys. Use a password
> protected key, and avoid mounting your entire ~/.ssh directory and instead copy just
> the key you need to a fresh directory.
