#!/bin/zsh

zparseopts -D \
    -git-repo:=o_git_repo \
    -ssh-key:=o_ssh_key

PROJECT_DIR=/home/fleet/workspace
SSH_KEY=

if [ -n "${o_git_repo[2]+1}" ]; then
    echo "Specified git repo: ${o_git_repo[2]}"
    HOST_NAME=$(echo $o_git_repo[2] | sed -E 's/^.*@(.*):.*$/\1/')
    FOLDER_NAME=$(echo $o_git_repo[2] | sed -E 's/^.*@.*:.*/(.*)\.git$/\1/')
    echo "Host name: ${HOST_NAME}"
    echo "Folder name: ${FOLDER_NAME}"
    SSH_KEYSCAN_OUTPUT=$(ssh-keyscan -H $HOST_NAME)
    echo "Keyscan output:"
    echo $SSH_KEYSCAN_OUTPUT
    mkdir -p ~/.ssh
    echo $SSH_KEYSCAN_OUTPUT >> ~/.ssh/known_hosts
    PROJECT_DIR=$(echo "$(pwd)/${FOLDER_NAME}")
    if [ -n "${o_ssh_key[2]+1}" ]; then
        echo "Using ssh key: ${o_ssh_key[2]}"
        echo $o_ssh_key[2] > /home/fleet/.ssh/id_git
        SSH_KEY=$o_ssh_key[2]
        git clone $o_git_repo[2] --config core.sshCommand="ssh -i /home/fleet/.ssh/id_git"
    else
        git clone $o_git_repo[2]
    fi
fi

echo "Launching Fleet with project dir ${PROJECT_DIR}"

/home/fleet/fleet launch workspace -- \
    --auth=accept-everyone --publish --enableSmartMode \
    --projectDir=$PROJECT_DIR
