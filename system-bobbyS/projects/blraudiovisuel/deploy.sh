#!/bin/bash -e

function exitScript() {
    echo
    echo -e "\n\033[1;33m[ABORTED]\033[0m Exiting $0"
    exit $?
}

trap exitScript 1 2 3 15 ERR

INVENTORY=$1

CMD="ansible-playbook -i inventory/$INVENTORY --extra-vars "inventory=$INVENTORY" blraudiovisuel.yml"

$CMD