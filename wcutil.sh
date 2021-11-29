#!/bin/bash

#
# wcutil - A WeChat util tool for macOS.
#
#  Usage: wcutil -help
#
#     -version, -v
#     -cipher,  -c
#     -backup,  -b {all, audio, vedio, db}
#     -delete,  -d {all, audio, vedio, db}
#     -help,    -h
#

function get_version() {
    echo "Current WeChat Version is: "
    ls $HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application\ Support/com.tencent.xinWeChat | head -n 1
}

function get_cipher() {
    wc_version=`get_version`

    echo "Your WeChat Cipher is: "
    ls $HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application\ Support/com.tencent.xinWeChat/$wc_version | head -n 1
}

function enter_tar() {
    cipher=`get_cipher`

    cd $HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application\ Support/com.tencent.xinWeChat/$wc_version/$cipher
}

# remove unuseful cached jpgs
function rm_unuseful_file() {
    enter_tar

    cd Avatar ; rm *.jpg ; cd ..
    echo 'Avatar cleaned!'

    cd Favorites/data ; rm *.jpg
    echo 'Favorites/data cleaned!'

    enter_tar

    # TODO: remove specific file instead of all
    #cd Message/MessageTemp ; rm -rf * ; cd .. ; cd ..
    cd Message
    rm -rf MessageTemp
    echo 'Message/MessageTemp cleaned!'
}

function enforce_backup() {
    enter_tar
    mkdir -p ~/wc_backup
    cd Message
    cp -r MessageTemp ~/wc_backup
}

function gentle_backup() {
    enter_tar

    # TODO: decode the cipher lists
    #unknown={"", ""}
    #for (( i = 1; i < len(unknown); i++ ))
    #   cd Message/MessageTemp/unknown{$i}
    #   do_something()

    unknown="1e3f003c149f7b7921396eda773ec286"
    cd Message/MessageTemp/$unknown/Audio

    mkdir -p ~/wc_backup/{audio, video, db}

    cp *.aud.silk ~/wc_backup/audio
}

function main() {
    get_version
    get_cipher

    rm_unuseful_file

    #enforce_backup
    #gentle_backup
}

main
