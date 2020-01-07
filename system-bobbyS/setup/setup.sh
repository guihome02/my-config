#!/bin/bash -e

function exitScript() {
    echo
    echo -e "\n\033[1;33m[ABORTED]\033[0m Exiting $0"
    exit $?
}

trap exitScript 1 2 3 15 ERR

echo -e "\033[1;34m[INFO] Configure setup\033[0m"

EXTRA_VARS=""
read -p "Update '.gitconfig' file? [y/N] " GENERATE_GIT_CONFIG
GENERATE_GIT_CONFIG="${GENERATE_GIT_CONFIG:=N}"
case "$GENERATE_GIT_CONFIG" in
    y|Y)
        EXTRA_VARS="GENERATE_GIT_CONFIG=y"

        read -p "> GitHub GPG signing key: " GITHUB_SIGNING_KEY
        EXTRA_VARS="$EXTRA_VARS GITHUB_SIGNING_KEY=$GITHUB_SIGNING_KEY"
        ;;
    n|N)
        EXTRA_VARS="GENERATE_GIT_CONFIG=n"
        ;;
    *)
        echo -e "\n\033[1;31m[ERROR]\033[0m Invalid choice"
        exit 1
        ;;
esac

echo
echo -e "\033[1;34m[INFO] Run ansible playbook\033[0m"

CMD="ansible-playbook setup.yml --ask-become-pass --extra-vars \"$EXTRA_VARS\""
echo -e "\e[1m$CMD"
