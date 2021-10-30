#!/usr/bin/env bash
#
# Copyright (c) 2021-2022 brian
#
# File name: update.sh
# Description: Install latest version for xray
# System Required: GNU/Linux
# Version: 1.0

##############################################################
# Name
PROJECT="xray"
# Version link
VERSION_URL="https://api.github.com/repos/XTLS/Xray-core/releases/latest"

PLATFORM="linux"
# upx best | ultra-brute
UPX="best"
# arch arm64-v8a | arm32-v7a | arm32-v6
ARCH="arm32-v7a"

# fonts color
BOLD(){
    echo -e "\033[1m\033[01m$1\033[0m"
}

##############################################################
## Project Code

## Show help
show_help() {
  echo "usage: ./${PROJECT_NAME} [-h] [-a arm32-v7a] [-u best] "
  echo '  -a            :  Arch: '
  echo '  -u            :  upx --lzma --best'
  echo ''
  exit 0
}

# update github
update_release() {
    # fetch latest json
    LATEST=$(curl -fsSL "${VERSION_URL}" )
    VERSION_TAG=$(echo "${LATEST}" | grep 'tag_name' | cut -d'"' -f4 | sed 's/v//' )
    DOWNLOAD_URL=$(echo "${LATEST}" | grep 'browser_download_url.*.zip\"' | cut -d'"' -f4 | grep "${PLATFORM}-${ARCH}")
    DOWNLOAD_FILE="${DOWNLOAD_URL##*/}"

    # download zip
    BOLD "Latest tag: ${VERSION_TAG}"
    BOLD "Downloading $DOWNLOAD_URL to $DOWNLOAD_FILE"
    curl -fSL "$DOWNLOAD_URL"  -o "$DOWNLOAD_FILE"

    # tar and upx
    BOLD "Tar ${DOWNLOAD_FILE}"
    tar xzvf ${DOWNLOAD_FILE} -C ./

    if [ -n "$UPX" ]; then
        upx --lzma --$UPX -o ${PROJECT}_${ARCH} ${PROJECT}
        # mv ${PROJECT}_${ARCH} ${PROJECT}
    fi

    # rm file
    rm README.md
    rm LICENSE
    rm "$DOWNLOAD_FILE"

    md5sum xray v2ctl > md5sum.txt
}

# init args
init_args() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -a) ARCH="$2"; shift ;;
            -u) UPX="$2"; shift ;;
            -h | --help) show_help ;;
            *) ERRO "Unknown parameter passed: $1"; exit 1 ;;
        esac
        shift
    done
}

main() {

    init_args "$@"

    update_release
}

main "$@" || exit 1
