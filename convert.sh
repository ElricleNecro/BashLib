#!/usr/bin/env bash

extract_ogg () {
	mplayer -ao pcm:fast:file=audio.ogg -vo null -vc null video.wbm
}

toogg () {
	output=$(basename $1)
	mencoder $1 -of rawaudio -oac lavc -lavcopts acodec=libvorbis -ovc copy -o ${output%.mp3}.ogg
	#ffmpeg -i Epic\ Violin\ Girl\ Lindsey\ Stirling.webm -acodec libvorbis -aq 60 Epic\ Violin\ Girl\ Lindsey\ Stirling.ogg
}

tomp3 () {
	output=$(basename $1)
	echo $output
	mencoder $1 -of rawaudio -oac mp3lame -ovc copy -o ${output%.*}.mp3
}
