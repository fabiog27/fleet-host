#!/bin/zsh

zparseopts -D \
    -git-repo:=o_git_repo \
    -ssh-key:=o_ssh_key

PROJECT_DIR=/home/fleet/workspace
SSH_KEY=

if [ -n "${o_git_repo[2]+1}" ]; then
    echo "Specified git repo: ${o_git_repo[2]}"
    HOST_NAME=$(cat o_git_repo | sed -E 's/^.*@(.*):.*$/\1/')
    ssh-keyscan -H $HOST_NAME >> ~/.ssh/known_hosts
    PROJECT_DIR=$(echo "$(pwd)/${o_git_repo[2]}")
    if [ -n "${o_ssh_key[2]+1}" ]; then
        echo "Using ssh key: ${o_ssh_key[2]}"
        mkdir -p ~/.ssh
        echo $o_ssh_key[2] > /home/fleet/.ssh/id_git
        SSH_KEY=$o_ssh_key[2]
        git clone $o_git_repo[2] --config core.sshCommand="ssh -i /home/flet/.ssh/id_git"
    else
        git clone $o_git_repo[2]
    fi
fi

echo "Launching Fleet with project dir ${PROJECT_DIR}"

/home/fleet/fleet launch workspace -- \
    --auth=accept-everyone --publish --enableSmartMode \
    --projectDir=$PROJECT_DIR
