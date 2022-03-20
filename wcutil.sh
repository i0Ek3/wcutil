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


function enter_tar() {
    # TODO: cannot get this id by common method
    id="ac8875c5f2cfa9594028fc2ebc2cc351"
    wc_version=`ls $HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application\ Support/com.tencent.xinWeChat | head -n 1`
    cd $HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Application\ Support/com.tencent.xinWeChat/"$wc_version"/"$id"
}

function remove_all() {
    rm -rf $HOME/Library/Containers/com.tencent.xinWeChat
    echo "com.tencent.xinWeChat removed!"
}

function backup_all() {
    cp -r $HOME/Library/Containers/com.tencent.xinWeChat ~/com.tencent.xinWeChat.bak
    echo "com.tencent.xinWeChat backuped to ~!"
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

    # for now, you need change this by your own
    unknown="1e3f003c149f7b7921396eda773ec286"
    cd Message/MessageTemp/$unknown/Audio

    mkdir -p ~/wc_backup/audio
    cp *.aud.silk ~/wc_backup/audio
    echo "Audio/*.aud.silk backuped!"
}

function main() {
    enter_tar
    remove_all
    #rm_unuseful_file

    #enforce_backup
    #gentle_backup
}

main
