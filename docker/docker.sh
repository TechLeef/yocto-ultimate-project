#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 checkout|shell|build <path/to/yml> <path/to/YoctoShare>"
    exit 1
fi

PROJECT_DIR="$(realpath $(dirname "$0")/..)"
VENV_DIR="${PROJECT_DIR}/yocto-venv"
YOCTO_SHARE="${3}"

do_prepare_env(){
    if [ -d "${VENV_DIR}" ]; then
        if [ ! "${VENV_DIR}/pyvenv.cfg" ]; then
            echo "[x] Python venv directory exist but no pyvenv.cfg"
            echo "[x] Make sure to remove the directory and repeat again"
            exit 1
        fi
    else
        python3 -m venv "${VENV_DIR}" || {
            echo "[x] Failed to setup python3 venv"
            exit 1
        }
    fi

    # Source the venv
    echo "[+] Sourcing the Python venv"
    source "${VENV_DIR}/bin/activate" || {
        echo "[x] Failed to setup the venv"
        exit 1
    }

    # Install "kas"
    if ! pip3 list | grep -q kas; then
        echo "[+] Installing kas"
        if ! pip3 install kas; then
            echo "[x] Error installing kas .."
            exitg 1
        fi
    fi
}

do_kas(){
    local yml="${1}"
    local action="${2}"
    kas-container --runtime-args "-v ${YOCTO_SHARE}:/yoctoshare" "${action}" "${yml}"
}

main(){
    do_prepare_env

    local action="$1"
    local yml="$2"

    if [ ! -f "${yml}" ]; then
        echo "[x] ${yml} does not exist"
        exit 1
    fi

    if [ "${action}" != "shell" -a "${action}" != "build" -a "${action}" != "checkout" ]; then
        echo "[ERROR] Wrong KAS action, possible: shell, build or checkout"
        exit 1
    fi

    do_kas "${yml}" "${action}"
}

if [ ! -d "${YOCTO_SHARE}" ]; then
    echo "[ERROR] The provided path (${YOCTO_SHARE}) is not a directory"
    exit 1
else
    if [ ! -d "${YOCTO_SHARE}/downloads" -o ! -d "${YOCTO_SHARE}/sstate-cache" ]; then
        echo "[ERROR] Make sure you have downloads and sstate-cache under ${YOCTO_SHARE}"
        exit 1
    fi
fi

main "$@"
