#!/bin/bash

COOKIE_FILE="/tmp/cookies.txt"
FILE_ID="0B3TtLmV-bYCeaTZwNFJveWV"
FILE_NAME="xyz.zip"
rm -rf ${FILE_NAME}
CONFIRM=$(wget --quiet --save-cookies ${COOKIE_FILE} --keep-session-cookies --no-check-certificate "https://drive.google.com/uc?export=download&id=${FILE_ID}" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
wget --load-cookies ${COOKIE_FILE} "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILE_ID}" -O ${FILE_NAME}
