#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 checkout|shell|build <path/to/yml>"
    exit 1
fi

VENV_DIR="../yocto-venv"

do_prepare_env(){
    if [ -d "${VENV_DIR}" ]; then
        # Make sure that it is actually a python virtual environment
        # if it is not, then fail with an error message
        exit 1
    else
        python3 -m venv "${VENV_DIR}"
    fi

    # Source the venv
    echo "[+] Sourcing the Python venv"
    source "${VENV_DIR}/bin/activate" || {
        echo "[x] Failed to setup the venv"
        exit 1
    }

    # Install "kas"
    if ! pip3 install kas; then
        echo "[x] Error installing kas .."
        exitg 1
    fi

}

do_kas_checkout(){
    local yml="${1}"
    kas-container checkout "${yml}"
}

main(){
    do_prepare_env

    local action="$1"
    local yml="$2"

    if [ ! -f "${yml}" ]; then
        echo "[x] ${yml} does not exist"
        exit 1
    fi

    if [ "${action}" == "checkout" ]; then
        do_kas_checkout "${yml}"
    elif [ "${action}" == "shell" ]; then
        do_kas_shell "${yml}"
    elif [ "${action}" == "build" ]; then
        do_kas_build "${yml}"
    else
        echo "[x] Wrong action"
        exit 1
    fi
}

main "$@"
