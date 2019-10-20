#!/bin/bash

LOCAL_REPO="${HOME}/Drive/local/iptv"
TKNIZER_DIR="${HOME}/Drive/TV/apps/tknzr"

echo Checking for updates from remote... # Check for updates
cd ${LOCAL_REPO} && git pull

sleep 3 && clear

# Media Prima 
cd ${TKNIZER_DIR}/sources/MediaPrima
i=11 # First line

echo Tokenizing channels...
for ch in *; do 
    if [ -f "$ch" ]; then 
        echo "[""${ch:1}""]" 
        tkn=$(${TKNIZER_DIR}/youtube-dl -f hls-720 -g $(cat $ch))
        tknh8=$tkn"|Referer=$(cat $ch)"
        tknh8=${tknh8//\//\\/} # Escape URL front slashes

        sed -i '' "$i c\\
		$tknh8
		" ${LOCAL_REPO}/src/malaysia.m3u;
        i=$((i+3))	# URLs are spaced 3 lines apart
    fi 
done

# YouTube
cd ${TKNIZER_DIR}/sources/YouTube
i=37

for ch in *; do 
    if [ -f "$ch" ]; then 
        echo "[""${ch:1}""]" 
        tkn=$(${TKNIZER_DIR}/youtube-dl -f 95 -g $(cat $ch))
        tknh8=$tkn"|Referer=$(cat $ch)"
        tknh8=${tknh8//\//\\/} 

        sed -i '' "$i c\\
        $tknh8
        " ${LOCAL_REPO}/src/malaysia.m3u;
        i=$((i+3)) 
    fi 
done

sleep 3 && clear

cd ${LOCAL_REPO} && git commit -am "Token update (Bash v2)" && git push