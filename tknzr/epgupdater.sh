#!/bin/bash

WG_DIR="${HOME}/Drive/TV/apps/WebGrab+Plus/unix/wg++"
WG_EXE="${WG_DIR}/bin/WebGrab+Plus.exe"
LOCAL_REPO="${HOME}/Drive/local/iptv"

mono ${WG_EXE} # Full EPG update
sleep 3 && clear

# Checking for custom configs
if [ -z "$(ls -A ${WG_DIR}/CustomConfig)" ]; then
   	echo "No custom configs"
else
	echo Checking for updates from remote... # Check for updates
	cd ${LOCAL_REPO} && git pull
	sleep 3 && clear
	
	cd ${WG_DIR}/CustomConfig
	for d in */ ; do
		mono ${WG_EXE} "${d%/}"
		sleep 3 && clear
	done

	cd ${LOCAL_REPO} && git commit -am "EPG update (Bash v2)" && git push
fi