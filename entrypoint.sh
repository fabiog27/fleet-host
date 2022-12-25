#!/bin/zsh

zparseopts -D -git-repo:=o_git_repo

PROJECT_DIR=/home/fleet/workspace

echo "-------------------------------------------------"
if [ -n "${o_git_repo[2]+1}" ]; then
    echo "Specified git repo: ${o_git_repo[2]}"

    HOST_NAME=$(echo $o_git_repo[2] | sed -E 's/^.*@(.*):.*$/\1/')
    FOLDER_NAME=$(echo $o_git_repo[2] | sed -E 's/^.*@.*:.*\/(.*)\.git$/\1/')
    echo "Host name: ${HOST_NAME}"
    echo "Folder name: ${FOLDER_NAME}"

    SSH_KEYSCAN_OUTPUT=$(ssh-keyscan -H $HOST_NAME)
#    echo "Keyscan output:"
#    echo $SSH_KEYSCAN_OUTPUT
    mkdir -p ~/.ssh
    echo $SSH_KEYSCAN_OUTPUT >> ~/.ssh/known_hosts

    PROJECT_DIR=$(echo "$(pwd)/${FOLDER_NAME}")

    if [[ -f ~/.ssh/id_git && -f ~/.ssh/id_git.pub ]]; then

        echo "Using ssh key"
        chmod 600 /home/fleet/.ssh/id_git
        chmod 600 /home/fleet/.ssh/id_git.pub
        git clone $o_git_repo[2] --config core.sshCommand="ssh -i /home/fleet/.ssh/id_git"

        if [ $? != 0 ]; then
            echo "Failure cloning, exiting"
            exit
        fi

    else

        echo "Proceeding to clone without ssh key"
        git clone $o_git_repo[2]

        if [ $? != 0 ]; then
            echo "Failure cloning, exiting"
            exit
        fi

    fi
    echo "Launching Fleet with project dir ${PROJECT_DIR}"
else
    echo "No git repo specified, launching with empty workspace directory"
fi
echo "-------------------------------------------------"

/home/fleet/fleet launch workspace -- \
    --auth=accept-everyone --publish --enableSmartMode \
    --projectDir=$PROJECT_DIR
